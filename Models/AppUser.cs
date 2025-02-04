using System.ComponentModel.DataAnnotations;
using backend.Enums;
using Microsoft.AspNetCore.Identity;

namespace backend.Models;

public class AppUser : IdentityUser
{
    [MaxLength(200)]
    public string? FullName { get; set; }
    
    [MaxLength(13)]
    public string? NIC { get; set; }
    
    // [MaxLength(15)]
    // public string? PhoneNumber { get; set; }
    
    [MaxLength(300)]
    public string? Address { get; set; }
    
    [MaxLength(50)]
    public string? City { get; set; }
    
    public UserType? ConsumerType { get; set; }
    
    //TODO: Add bool to see the confirmation if the personal users auto set to confirm and if the 
    //Industries or business, admin to have a method to update confirmation 
    //TODO: also add Business Registration Number to the model when the above changes are doing.
}