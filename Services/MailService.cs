using backend.Interfaces;
using Mailjet.Client;
using Mailjet.Client.Resources;
using Newtonsoft.Json.Linq;

namespace backend.Services;

public class MailService: IMailService
{
    private readonly IKeyVaultService _keyVaultService;
    private string? _emailApiKey;
    private string? _emailApiSecret;

    public MailService(IKeyVaultService keyVaultService)
    {
        _keyVaultService = keyVaultService;
    }
    
    private async Task InitializeKeyAsync()
    {
        // Retrieve the signing key from Azure Key Vault
        
        var emailKey = await _keyVaultService.GetSecretAsync("emailapikey");
        var emailSecret = await _keyVaultService.GetSecretAsync("mailjetkey");
        if (string.IsNullOrEmpty(emailKey) || string.IsNullOrEmpty(emailSecret))
        {
            throw new InvalidOperationException("Email key or secret not found in Azure Key Vault.");
        }

        _emailApiKey = emailKey;
        _emailApiSecret = emailSecret;
    }

    public async Task<bool> SendEmailAsync(string toEmail, string toName, string subject, string body)
    {
        if (_emailApiKey == null || _emailApiSecret == null)
        {
            await InitializeKeyAsync();
        }

        MailjetClient mailjetClient = new MailjetClient(_emailApiKey, _emailApiSecret);

        MailjetRequest emailRequest = new MailjetRequest
            {
                Resource = Send.Resource,
            }
            .Property(Send.FromEmail, "bg15407@gmail.com")
            .Property(Send.FromName, "GasByGas")
            .Property(Send.Subject, subject)
            .Property(Send.TextPart, body)
            .Property(Send.HtmlPart, body)
            .Property(Send.Recipients, new JArray
            {
                new JObject
                {
                    {"Email", toEmail}
                }
            });
        
        MailjetResponse emailResponse = await mailjetClient.PostAsync(emailRequest);
        if (emailResponse.IsSuccessStatusCode)
        {
            Console.WriteLine("Email sent");
            Console.WriteLine(emailResponse.GetData());
            return true;
           
        }
        else
        {
            Console.WriteLine("Email sent failed");
            Console.WriteLine($"StatusCode: {emailResponse.StatusCode}\n");
            Console.WriteLine($"ErrorInfo: {emailResponse.GetErrorInfo()}\n");
            Console.WriteLine(emailResponse.GetData());
            Console.WriteLine($"ErrorMessage: {emailResponse.GetErrorMessage()}\n");
            return false;
           
        }


    }
}