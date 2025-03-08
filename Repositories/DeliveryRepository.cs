using backend.Data;
using backend.Dtos.DeliverySchedule;
using backend.Interfaces;
using backend.Models;
using Microsoft.EntityFrameworkCore;

namespace backend.Repositories;

public class DeliveryRepository: IDeliveryRepository
{
    private readonly ApplicationDbContext _context;

    public DeliveryRepository(ApplicationDbContext context)
    {
        _context = context;
    }

    public async Task<DeliverySchedule> CreateAsync(DeliverySchedule deliveryScheduleModel)
    {
        await _context.DeliverySchedules.AddAsync(deliveryScheduleModel);
        await _context.SaveChangesAsync();
        return deliveryScheduleModel;
    }

    protected void AddStocksToTokenAtCreation()
    {
        
    }

    public async Task<List<DeliverySchedule>> GetAllAsync()
    {
        return await _context.DeliverySchedules.ToListAsync();
    }

    public async Task<DeliverySchedule?> GetById(int id)
    {
        return await _context.DeliverySchedules.FindAsync(id);
    }

    
    public async Task<bool> DeliveryExists(int id)
    {
        return await _context.DeliverySchedules.AnyAsync(s => s.Id == id);
    }

    public async Task<List<DeliverySchedule>> GetConfirmedDeliveriesForDate(DateOnly date)
    {
        
        
        return await _context.DeliverySchedules
            .Where(d => d.ConfirmedByAdmin && d.DeliveryDate == date)
            .ToListAsync();
    }

    public async Task<DeliverySchedule?> UpdateAsync(int id, DeliveryRequestDto requestDto)
    {
        var deliveryScheduleModel = await _context.DeliverySchedules.FindAsync(id);
        if(deliveryScheduleModel == null) return null;

        if (deliveryScheduleModel.DeliveryDate != requestDto.DeliveryDate)
        {
            deliveryScheduleModel.DeliveryDate = requestDto.DeliveryDate;
            //TODO: Update the Stock Confirmed Date
        }
       
        
        deliveryScheduleModel.ConfirmedByAdmin = requestDto.ConfirmedByAdmin;
        if (deliveryScheduleModel.NoOfUnitsInDelivery != requestDto.NoOfUnitsInDelivery)
        {
            deliveryScheduleModel.NoOfUnitsInDelivery = requestDto.NoOfUnitsInDelivery;
            //TODO: Update the stock No of unit dispatched.
        }
        
        deliveryScheduleModel.OutletId = requestDto.OutletId;
        deliveryScheduleModel.DispatcherVehicleId = requestDto.DispatcherVehicleId;
        
        await _context.SaveChangesAsync();
        return deliveryScheduleModel;
    }
    
    public async Task<bool> DeleteAsync(int id)
    {
        var deliverySchedule = await _context.DeliverySchedules.FindAsync(id);
        if (deliverySchedule == null) return false;

        _context.DeliverySchedules.Remove(deliverySchedule);
        await _context.SaveChangesAsync();
        return true;
    }
}