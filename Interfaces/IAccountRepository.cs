namespace backend.Interfaces;

public interface IAccountRepository
{
    Task<bool> UserExists(string email);
}