using System.ComponentModel.DataAnnotations;
using backend.Enums;

namespace backend.Dtos.GasToken;

public class CreateTokenRequestDto
{
    
    [DataType(DataType.Date)]
    public required DateOnly ExpectedPickupDate { get; set; }
    public required ConsumerType ConsumerType { get; set; }
}