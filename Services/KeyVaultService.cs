using Azure.Identity;
using Azure.Security.KeyVault.Secrets;
using backend.Interfaces;

namespace backend.Services;

public class KeyVaultService : IKeyVaultService
{
    private readonly SecretClient _secretClient;

    public KeyVaultService(IConfiguration configuration)
    {
        var keyVaultUri = configuration["AzureKeyVault:VaultUri"];
        if (string.IsNullOrEmpty(keyVaultUri))
        {
            throw new ArgumentException("Azure Key Vault URI is not configured.");
        }

        _secretClient = new SecretClient(new Uri(keyVaultUri), new DefaultAzureCredential());
    }

    public async Task<string> GetSecretAsync(string secretName)
    {
        KeyVaultSecret secret = await _secretClient.GetSecretAsync(secretName);
        return secret.Value;
    }
}