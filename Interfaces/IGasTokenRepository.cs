using backend.Dtos.GasToken;
using backend.Models;

namespace backend.Interfaces;

public interface IGasTokenRepository
{
    public Task<List<GasToken>> GetAllAsync();
    
    Task<GasToken> CreateAsync(GasToken gasTokenModel);
    
    Task<GasToken?> GetByIdAsync(int id);

    Task<List<GasToken>> GetAllByEmailAsync(string email);
    
    Task<List<GasToken>> GetAllByOutletAsync(int outletId);

    Task<GasToken?> UpdateExpectedDateOfTokenAsync(int id, CreateTokenRequestDto createTokenDto);

    Task<GasToken?> UpdateTokenAsync(int id, UpdateTokenDto updateTokenDto);
    
    Task<GasToken?> DeleteTokenAsync(int id);
    
    Task<List<GasToken>> GetGasTokensByDeliveryScheduleIdAsync(int deliveryScheduleId);

}