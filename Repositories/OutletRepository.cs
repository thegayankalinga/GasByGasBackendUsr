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

    public async Task<Outlet> CreateOutletAsync(Outlet outletModel)
    {
         await _context.Outlets.AddAsync(outletModel);
         await _context.SaveChangesAsync();
         return outletModel;
    }
    
    public async Task<bool> DeleteOutletAsync(int id)
    {
        var outlet = await _context.Outlets.FindAsync(id);
        if (outlet == null) return false;

        _context.Outlets.Remove(outlet);
        await _context.SaveChangesAsync();
        return true;
    }
}