using backend.Dtos.StockRequest;
using backend.Models;

namespace backend.Interfaces;

public interface IStockRepository
{
    Task<List<StockRequest>> GetAllStockRequestsAsync();
    Task<List<StockRequest>> GetAllStockRequestsByOutletIdAsync(int outletId);
    Task<StockRequest?> GetStockRequestByIdAsync(int id);
    Task<List<StockRequest>> GetAllStockRequestsByDeliveryIdAsync(int deliveryId);
    
    Task<StockRequest> CreateStockRequestAsync(StockRequest? stockRequest);
    
    Task<StockRequest?> UpdateStockRequestAsync(int id, StockRequestUpdateRequestDto stockRequest);
    
    Task<StockRequest?> DeleteStockRequestAsync(int id);
}