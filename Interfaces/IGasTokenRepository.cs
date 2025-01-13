using backend.Models;

namespace backend.Interfaces;

public interface IGasTokenRepository
{
    public Task<List<GasToken>> GetAllAsync();
    
    Task<GasToken> CreateAsync(GasToken gasTokenModel);
    
    Task<GasToken> GetByIdAsync(int id);
    
}