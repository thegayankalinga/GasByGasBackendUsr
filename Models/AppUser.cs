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
    
    [MaxLength(50)]
    public string? BusinessRegistration { get; set; }
    
    public bool IsConfirm { get; set; }
    
    // [MaxLength(15)]
    //public string? PhoneNumber { get; set; }
    
    [MaxLength(300)]
    public string? Address { get; set; }
    
    [MaxLength(50)]
    public string? City { get; set; }
    
    public UserType? ConsumerType { get; set; }
    
    public int? OutletId { get; set; }
    
    public int? NoOfCylindersAllowed { get; set; }
    
    public int? RemainingCylindersAllowed { get; set; }
    
}