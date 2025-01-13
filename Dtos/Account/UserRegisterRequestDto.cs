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
    
    [Required]
    [MaxLength(13)]
    [MinLength(10)]
    public required string NIC { get; set; }
    
    [Required]
    [MaxLength(15)]
    [MinLength(10)]
    [Phone]
    public required string PhoneNumber { get; set; }
    
    [Required]
    [MaxLength(200)]
    public required string Address { get; set; }
    
    [Required]
    [MaxLength(50)]
    public required string City { get; set; }
    
    [Required]
    [EnumDataType(typeof(ConsumerType))]
    public ConsumerType ConsumerType { get; set; } 
    
}