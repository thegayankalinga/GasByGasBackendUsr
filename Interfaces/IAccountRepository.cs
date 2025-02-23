using backend.Models;

namespace backend.Interfaces;

public interface IAccountRepository
{
    Task<bool> UserExists(string email);
    Task<List<AppUser>> GetManagersByOutletIdAsync(int outletId);
    
}