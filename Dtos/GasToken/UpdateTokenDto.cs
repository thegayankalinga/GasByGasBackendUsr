using backend.Enums;

namespace backend.Dtos.GasToken;

public class UpdateTokenDto
{
    
    
    public DateOnly? ReadyDate { get; set; }
    public required DateOnly ExpectedPickupDate { get; set; }
    public required GasTokenStatus Status { get; set; } 
    public bool IsEmpltyCylindersGivent { get; set; }
    public bool IsPaid { get; set; } = false;
    public DateOnly? PaymentDate { get; set; }
    public required string UserEmail { get; set; }
    public int? DeliveryScheduleId { get; set; }
}