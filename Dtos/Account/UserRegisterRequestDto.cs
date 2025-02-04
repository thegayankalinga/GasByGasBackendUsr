using System.ComponentModel.DataAnnotations;
using backend.Enums;

namespace backend.Dtos.Account;

public class UserRegisterRequestDto
{
    [Required]
    [EmailAddress]
    public required string Email { get; set; }
    
    [Required]
    public required string Password { get; set; }
    
    [Required]
    public required string FullName { get; set; }
    

    [MaxLength(13)]
    [MinLength(10)]
    public string? NIC { get; set; }
    
    [MaxLength(50)]
    public string? BusinessRegistration { get; set; }
    
    [Required]
    [MaxLength(15)]
    [MinLength(10)]
    [Phone]
    public required string PhoneNumber { get; set; }
    

    [MaxLength(200)]
    public string? Address { get; set; }
    
    public int? OutletId { get; set; }

    [MaxLength(50)]
    public string? City { get; set; }
    
    [Required]
    [EnumDataType(typeof(UserType))]
    public UserType UserType { get; set; } 
    
    public int? NoOfCylindersAllowed { get; set; }
    
}