namespace backend.Dtos.StockRequest;

public class StockRequestReponseDto
{

    public int Id { get; set; }
    
    public required int OutletId { get; set; }
    
    public DateOnly RequestedDate { get; set; }
    
    public DateOnly? CompletedDate { get; set; }

    public bool Completed { get; set; } = false;
    
    public int? DeliveryScheduleId { get; set; }
    
    public int NoOfUnitsRequired { get; set; }
    
    public int NoOfUnitsDispatched { get; set; }
}