using backend.Data;
using backend.Interfaces;
using backend.Models;
using Microsoft.EntityFrameworkCore;

namespace backend.Repositories;

public class OutletRepository : IOutletRepository
{
    private readonly ApplicationDbContext _context;
    
    public OutletRepository(ApplicationDbContext context)
    {
        _context = context;
    }
    public async Task<List<Outlet>> GetAllOutletsAsync()
    {
        return await _context.Outlets.ToListAsync();
    }

    public async Task<Outlet> GetOutletByIdAsync(int id)
    {
        return await _context.Outlets.FirstOrDefaultAsync(x => x.Id == id);
    }

    public async Task<bool> OutletExists(int id)
    {
        return await _context.Outlets.AnyAsync(x => x.Id == id);
    }
    
}