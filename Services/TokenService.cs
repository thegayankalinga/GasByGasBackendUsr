using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using backend.Interfaces;
using backend.Models;
using Microsoft.IdentityModel.Tokens;

namespace backend.Services;

public class TokenService : ITokenService
{
    private readonly IConfiguration _configuration;
    private SymmetricSecurityKey? _key;
    private readonly IKeyVaultService _keyVaultService;

    public TokenService(IConfiguration configuration, IKeyVaultService keyVaultService)
    {
        _configuration = configuration;
        _keyVaultService = keyVaultService;
        // _key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_configuration[_keyVaultService.GetSecretAsync("lmusigningkey").Result] ?? throw new InvalidOperationException("Invalid Signing Key")));
    }
    
    private async Task InitializeKeyAsync()
    {
        // Retrieve the signing key from Azure Key Vault
        var signingKey = await _keyVaultService.GetSecretAsync("lmusigningkey");
        if (string.IsNullOrEmpty(signingKey))
        {
            throw new InvalidOperationException("Signing key not found in Azure Key Vault.");
        }

        _key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(signingKey));
    }
    
    public async Task<string> CreateToken(AppUser user)
    {
        // Ensure the signing key is initialized
        if (_key == null)
        {
            await InitializeKeyAsync();
        }
        var claims = new List<Claim>
        {
            new Claim(JwtRegisteredClaimNames.Email, user.Email ?? throw new InvalidOperationException()),
            new Claim(JwtRegisteredClaimNames.Name, user.FullName ?? throw new InvalidOperationException()),
            new Claim(JwtRegisteredClaimNames.PhoneNumber, user.PhoneNumber ?? throw new InvalidOperationException()),

        };
        
        var credentials = new SigningCredentials(_key, SecurityAlgorithms.HmacSha512Signature);
        var tokenDescription = new SecurityTokenDescriptor
        {
            Subject = new ClaimsIdentity(claims),
            Expires = DateTime.UtcNow.AddDays(30),
            SigningCredentials = credentials,
            Issuer = _configuration["JWT:Issuer"],
            Audience = _configuration["JWT:Audience"]
        };
        var tokenHandler = new JwtSecurityTokenHandler();
        var token = tokenHandler.CreateToken(tokenDescription); 
        return tokenHandler.WriteToken(token);
    }
}