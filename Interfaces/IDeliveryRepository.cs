using backend.Dtos.DeliverySchedule;
using backend.Models;

namespace backend.Interfaces;

public interface IDeliveryRepository
{
    Task<DeliverySchedule> CreateAsync(DeliverySchedule deliveryScheduleModel);
    Task<bool> DeliveryExists(int id);
    Task<List<DeliverySchedule>> GetConfirmedDeliveriesForDate(DateOnly date);
    
    Task<DeliverySchedule?> GetById(int id);

    Task<List<DeliverySchedule>> GetAllAsync();
    
    Task<DeliverySchedule?> UpdateAsync(int id, DeliveryRequestDto scheduleRequest);


}