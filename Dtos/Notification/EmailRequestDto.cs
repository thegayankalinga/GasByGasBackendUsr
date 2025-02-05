using System.ComponentModel.DataAnnotations;

namespace backend.Dtos.Sms;

public class EmailRequestDto
{
    [Required]
    public required string ToEmail{get;set;}
    
    [Required]
    public required string ToName { get; set; }
    
    [Required]
    public required string Subject {get;set;}
    
    
    [Required]
    public required string Body{get;set;}
}