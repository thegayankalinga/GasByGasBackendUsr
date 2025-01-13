using System.ComponentModel.DataAnnotations;
using backend.Enums;

namespace backend.Dtos.Account;

public class NewUserResponseDto
{

    public required string Email { get; set; }
    public required string FullName { get; set; }
    public required string NIC { get; set; }
    public required string PhoneNumber { get; set; }
    public required string Address { get; set; }
    public required string City { get; set; }
    
    [EnumDataType(typeof(ConsumerType))]
    public ConsumerType ConsumerType { get; set; }
    public required string Token { get; set; }

}