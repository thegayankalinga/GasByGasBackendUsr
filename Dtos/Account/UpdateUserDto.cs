using backend.Enums;

namespace backend.Dtos.Account;

public class UpdateUserDto
{
    public string? FullName { get; set; }
    public int? OutletId { get; set; }
    public string? NIC { get; set; }

    public string? BusinessRegistration { get; set; }
    public string? PhoneNumber { get; set; }
    
    public UserType? ConsumerType { get; set; }
    
    public string? Email { get; set; }
    
    public string? Address { get; set; }
    
    public string? City { get; set; }
    
}

 // email, fullname, phonenumber, isconfirm
 //manager => outletId
 //personal => nic, address, city, noOfCylinderAllowed, remainingCylindersAllowed
 //business/industries => br, address, city, noOfCylinderAllowed, remainingCylindersAllowed