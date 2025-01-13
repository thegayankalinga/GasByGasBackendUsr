using System.ComponentModel.DataAnnotations;

namespace backend.Dtos.Account;

public class LoginDto
{
    [Required]
    [EmailAddress]
    public required string Email { get; set; }
    [Required]
    public required string Password { get; set; }
}