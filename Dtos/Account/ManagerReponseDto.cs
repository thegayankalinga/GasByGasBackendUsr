using backend.Enums;

namespace backend.Dtos.Account;

public class ManagerReponseDto
{
    
    public string? Email { get; set; }

    public string? FullName { get; set; }
    
    public bool IsConfirm { get; set; }
    
    public UserType? ConsumerType { get; set; }
    
    public int? OutletId { get; set; }
    
}