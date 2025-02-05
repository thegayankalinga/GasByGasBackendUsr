using System.ComponentModel.DataAnnotations;

namespace backend.Dtos.Sms;

public class SmsRequestDto
{
    [Required]
    public string Recepient{get;set;}
    
    [Required]
    public string Message{get;set;}
}