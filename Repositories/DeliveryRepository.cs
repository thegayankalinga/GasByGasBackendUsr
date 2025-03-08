using backend.Data;
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


    public async Task<bool> DeliveryExists(int id)
    {
        return await _context.DeliverySchedules.AnyAsync(s => s.Id == id);
    }

    public async Task<List<DeliverySchedule>> GetConfirmedDeliveriesForDate(DateTime date)
    {
        DateOnly deliveryDate = DateOnly.FromDateTime(date);
        
        return await _context.DeliverySchedules
            .Where(d => d.ConfirmedByAdmin && d.DeliveryDate == deliveryDate)
            .ToListAsync();
    }
}