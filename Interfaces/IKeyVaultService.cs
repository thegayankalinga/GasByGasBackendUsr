namespace backend.Interfaces;

public interface IKeyVaultService
{
    Task<string> GetSecretAsync(string secretName);
}