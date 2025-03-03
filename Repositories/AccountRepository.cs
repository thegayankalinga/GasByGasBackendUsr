using backend.Data;
using backend.Enums;
using backend.Interfaces;
using backend.Models;
using Microsoft.EntityFrameworkCore;

namespace backend.Repositories;

public class AccountRepository : IAccountRepository
{
    private readonly ApplicationDbContext _context;
    public AccountRepository(ApplicationDbContext context)
    {
        _context = context;
    }
    
    public async Task<bool> UserExists(string email)
    {
        return await _context.Users.AnyAsync(s => s.Email == email);
    }

    public async Task<List<AppUser>> GetManagersByOutletIdAsync(int outletId)
    {
        return await _context.Users.Where(s => s.OutletId == outletId).ToListAsync();
    }

    public async Task<List<AppUser>> GetConsumersAsync()
    {
        var filteredUsers = await _context.Users
            .Where(u => u.ConsumerType == UserType.Personal || 
                                u.ConsumerType == UserType.Business || 
                                u.ConsumerType == UserType.Industries)
            .ToListAsync();
        return filteredUsers;
        
    }
}