namespace backend.Dtos.Outlet;

public class NewOutletRequestDto
{
    public required string OutletName { get; set; }
    
    public required string OutletAddress { get; set; }
    
    public required string City { get; set; }
    
    public int? Stock { get; set; }

}