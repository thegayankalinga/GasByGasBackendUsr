using backend.Data;
using backend.Dtos.StockRequest;
using backend.Interfaces;
using backend.Models;
using Microsoft.EntityFrameworkCore;

namespace backend.Repositories;

public class StockRepository: IStockRepository
{
    private readonly ApplicationDbContext _context;

    public StockRepository(ApplicationDbContext context)
    {
        _context = context;
    }

    public async Task<List<StockRequest>> GetAllStockRequestsAsync()
    {
        return await _context.StockRequests.ToListAsync();
    }

    public async Task<List<StockRequest>> GetAllStockRequestsByOutletIdAsync(int outletId)
    {
        return await _context.StockRequests.Where(s => s.OutletId == outletId).ToListAsync();
    }

    public async Task<StockRequest?> GetStockRequestByIdAsync(int id)
    {
        return await _context.StockRequests.FindAsync(id);
    }

    public async Task<List<StockRequest>> GetAllStockRequestsByDeliveryIdAsync(int deliveryId)
    {
        return await _context.StockRequests.Where(s=> s.DeliveryScheduleId == deliveryId).ToListAsync();
    }

    public async Task<StockRequest?> CreateStockRequestAsync(StockRequest stockRequestModel)
    {
       await _context.StockRequests.AddAsync(stockRequestModel);
       await _context.SaveChangesAsync();
       return stockRequestModel;
    }
    
    public async Task<StockRequest?> UpdateStockRequestAsync(int id, StockRequestUpdateRequestDto updateRequest)
    {
        var stockRequestModel = await _context.StockRequests.FindAsync(id);

        if (stockRequestModel == null) return null;
        
        stockRequestModel.Completed = stockRequestModel.Completed;
        stockRequestModel.CompletedDate = stockRequestModel.CompletedDate;
        stockRequestModel.NoOfUnitsDispatched = stockRequestModel.NoOfUnitsDispatched;
        stockRequestModel.DeliveryScheduleId = updateRequest.DeliveryScheduleId;
        
        if (updateRequest.OutletId != stockRequestModel.OutletId && updateRequest.OutletId != null)
        {
            Console.WriteLine($"Updating OutletId from {stockRequestModel.OutletId} to {updateRequest.OutletId}");
            stockRequestModel.OutletId = (int)updateRequest.OutletId!;
        }
       
        
        await _context.SaveChangesAsync();
        return stockRequestModel;
    }

    public async Task<StockRequest?> DeleteStockRequestAsync(int id)
    {
        var stockRequest = await _context.StockRequests.FindAsync(id);
        
        if (stockRequest == null)
        {
            return null;
        }
        
        _context.Remove(stockRequest);
        await _context.SaveChangesAsync();
        return stockRequest;
    }
}