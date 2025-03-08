using backend.Models;

namespace backend.Interfaces;

public interface IOutletRepository
{
    Task<List<Outlet>> GetAllOutletsAsync();
    Task<Outlet> GetOutletByIdAsync(int id);
    
    Task<bool> OutletExists(int id);

    Task<Outlet> CreateOutletAsync(Outlet outletModel);
    
    Task<bool> DeleteOutletAsync(int id);
}