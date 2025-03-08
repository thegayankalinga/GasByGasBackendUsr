using System.ComponentModel.DataAnnotations;

namespace backend.Models;

public class StockRequest
{
    [Key]
    public int Id { get; set; }
    
    public required int OutletId { get; set; }
    
    public DateOnly RequestedDate { get; set; }
    
    public DateOnly? CompletedDate { get; set; }
    
    
}