using System.ComponentModel.DataAnnotations;

namespace backend.Models;

public class DeliverySchedule
{
    [Key]
    public int Id { get; set; }
    public required DateOnly DeliveryDate { get; set; }
    public required bool ConfirmedByAdmin { get; set; } = false;
    
    public required int NoOfUnitsInDelivery { get; set; }
    
    public required int OutletId { get; set; }
    
    public required int DispatcherId { get; set; }
    
    
}