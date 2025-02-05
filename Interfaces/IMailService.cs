namespace backend.Interfaces;

public interface IMailService
{
    Task<bool> SendEmailAsync(string toEmail, string toName, string subject, string body);
}