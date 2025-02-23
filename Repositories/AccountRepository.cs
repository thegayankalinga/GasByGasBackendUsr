using backend.Data;
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
}