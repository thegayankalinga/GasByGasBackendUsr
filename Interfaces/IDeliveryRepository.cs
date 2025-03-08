using backend.Models;

namespace backend.Interfaces;

public interface IDeliveryRepository
{
    Task<bool> DeliveryExists(int id);
    Task<List<DeliverySchedule>> GetConfirmedDeliveriesForDate(DateTime date);

    
}