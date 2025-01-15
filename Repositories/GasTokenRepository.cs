using backend.Data;
using backend.Interfaces;
using backend.Models;
using Microsoft.EntityFrameworkCore;

namespace backend.Repositories;

public class GasTokenRepository : IGasTokenRepository
{
    private readonly ApplicationDbContext _context;
    public GasTokenRepository(ApplicationDbContext context)
    {
        _context = context;
    }
    public async Task<List<GasToken>> GetAllAsync()
    {
        return await _context.GasTokens.ToListAsync();
    }

    public async Task<GasToken> CreateAsync(GasToken gasTokenModel)
    {
        await _context.GasTokens.AddAsync(gasTokenModel);
        await _context.SaveChangesAsync();
        return gasTokenModel;
    }

    public async Task<GasToken> GetByIdAsync(int id)
    {
        return await _context.GasTokens.FirstOrDefaultAsync(x => x.Id == id);
    }

    public async Task<List<GasToken>> GetAllByEmailAsync(string email)
    {
        return await _context.GasTokens.Where(x => x.UserEmail == email).ToListAsync();
    }
}