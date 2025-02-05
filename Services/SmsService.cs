using System.Text;
using System.Text.Json;
using backend.Interfaces;
using Microsoft.IdentityModel.Tokens;
using Newtonsoft.Json;
using JsonSerializer = System.Text.Json.JsonSerializer;

namespace backend.Services;

public class SmsService : ISmsService
{
    private const string apiUrl = "https://app.text.lk/api/http/sms/send"; // Text.LK SMS API Endpoint
    private const string userId = "TextLKDemo"; // Replace with your Text.LK user ID
    
    private readonly IKeyVaultService _keyVaultService;
    private SymmetricSecurityKey? _key;
    private string? _secret;
    
    public SmsService(IKeyVaultService keyVaultService)
    {
        _keyVaultService = keyVaultService;
    }
    
    private async Task InitializeKeyAsync()
    {
        // Retrieve the signing key from Azure Key Vault
        
        var smskey = await _keyVaultService.GetSecretAsync("smsapikey");
        if (string.IsNullOrEmpty(smskey))
        {
            throw new InvalidOperationException("SMS Signing key not found in Azure Key Vault.");
        }

        _key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(smskey));
        _secret = smskey;
    }

    public async Task<bool> SendSmsAsync(string recipient, string message)
    {
        if (_key == null)
        {
            await InitializeKeyAsync();
        }

        using HttpClient client = new HttpClient();
 
        string requestUri =
            $"{apiUrl}?recipient={recipient}&sender_id={userId}&message={Uri.EscapeDataString(message)}&api_token={_secret}";
        Console.WriteLine(requestUri);
        try
        {
            HttpResponseMessage response = await client.GetAsync(requestUri);
            string responseString = await response.Content.ReadAsStringAsync();

            var jsonResponse = JsonSerializer.Deserialize<JsonElement>(responseString);
            string status = jsonResponse.GetProperty("status").GetString() ?? throw new InvalidOperationException("Null Status Response from SMS API");
            Console.WriteLine(responseString);
            return status == "success";
        }
        catch (Exception e)
        {
            Console.WriteLine(e);
            Console.WriteLine(e.Message);
            return false;
        }
    }
}