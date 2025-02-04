namespace backend.Interfaces;

public interface IDeliveryRepository
{
    Task<bool> DeliveryExists(int id);
}