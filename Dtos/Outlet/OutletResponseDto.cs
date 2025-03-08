namespace backend.Dtos.Outlet;

public class OutletResponseDto
{
    public int Id { get; set; }
    
    public required string OutletName { get; set; }
    
    public string? OutletAddress { get; set; }
    
    public required string City { get; set; }
    
    public int? Stock { get; set; }
    
}