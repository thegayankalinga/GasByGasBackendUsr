using System.ComponentModel.DataAnnotations;
using backend.Enums;

namespace backend.Dtos.Account;

public class NewUserResponseDto
{

    public required string Email { get; set; }
    public required string FullName { get; set; }
    public string? NIC { get; set; }
    
    public string? BusinessRegistration{get;set;}
    public bool IsConfirm { get; set; }
    public int? OutletId { get; set; }
    public required string PhoneNumber { get; set; }
    public string Address { get; set; }
    public string City { get; set; }
    
    [EnumDataType(typeof(UserType))]
    public UserType UserType { get; set; }
    public required string Token { get; set; }
    
    public int? NoOfCylindersAllowed { get; set; }
    public int? RemainingCylindersAllowed { get; set; }

}