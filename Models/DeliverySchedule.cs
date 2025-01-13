using System.ComponentModel.DataAnnotations;

namespace backend.Models;

public class DeliverySchedule
{
    [Key]
    public int Id { get; set; }
    
    //TODO: One day before the delivery email should be sent to the token holders
    public required DateOnly DeliveryDate { get; set; }
    
    //TODO: Add method to update the confirmation status
    //TODO: Based on the update, stock update, token assignment, notify user should be done
    public required bool ConfirmedByAdmin { get; set; } = false;
    
    public required int NoOfUnitsInDelivery { get; set; }
    
    public required int OutletId { get; set; }
    
    public required int DispatcherId { get; set; }
    
    
}