namespace backend.Interfaces;

public interface ISmsService
{
    Task<bool> SendSmsAsync(string recipient, string message);
}