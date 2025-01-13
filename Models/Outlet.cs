using System.ComponentModel.DataAnnotations;

namespace backend.Models;

public class Outlet
{
    [Key]
    public int Id { get; set; }
    
    [MaxLength(100)]
    public required string OutletName { get; set; }
    
    [MaxLength(200)]
    public string? OutletAddress { get; set; }
    
    [MaxLength(50)]
    public required string City { get; set; }

    public int? Stock { get; set; } = 0;
    //TODO: add stock update API and when delivery schedule is confirmed 

}