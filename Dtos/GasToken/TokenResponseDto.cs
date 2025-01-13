using backend.Enums;
using backend.Models;

namespace backend.Dtos.GasToken;

public class TokenResponseDto
{
    public int Id { get; set; }
    public required DateOnly RequestDate { get; set; }
    
    public DateOnly? ReadyDate { get; set; }
    public required DateOnly ExpectedPickupDate { get; set; }
    public required GasTokenStatus Status { get; set; } 
    public required ConsumerType ConsumerType { get; set; }
    
    public bool IsEmpltyCylindersGivent { get; set; }
    
    public decimal? Price { get; set; }
    
    public bool IsPaid { get; set; } = false;
    
    public DateOnly? PaymentDate { get; set; }
    
    public required string UserEmail { get; set; }
    
    public required int OutletId { get; set; }
    
    public int? DeliveryScheduleId { get; set; }
}