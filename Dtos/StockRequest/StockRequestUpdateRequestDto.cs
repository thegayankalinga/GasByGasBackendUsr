namespace backend.Dtos.StockRequest;

public class StockRequestUpdateRequestDto
{   
    public int? OutletId { get; set; }
    
    public DateOnly? CompletedDate { get; set; }

    public bool? Completed { get; set; }
    
    public int? DeliveryScheduleId { get; set; }
    
    public int? NoOfUnitsDispatched { get; set; }
    
}