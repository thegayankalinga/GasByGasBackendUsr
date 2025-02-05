using backend.Dtos.Sms;
using backend.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace backend.Controllers;

[ApiController]
[Route("api/notify")]
public class NotificationController: ControllerBase
{
    private readonly ISmsService _smsService;
    private readonly IMailService _mailService;

    public NotificationController(ISmsService smsService, IMailService mailService)
    {
        _smsService = smsService;
        _mailService = mailService;
    }

    [HttpPost("sms")]
    public async Task<IActionResult> SendSms([FromBody] SmsRequestDto smsRequestDto)
    {
        if(!ModelState.IsValid) return BadRequest(ModelState);
        
        var status = await _smsService.SendSmsAsync(smsRequestDto.Recepient, smsRequestDto.Message);

        
        if (status) return Ok(status);
        return BadRequest("Something went wrong");
    }
    
    [HttpPost("email")]
    public async Task<IActionResult> SendEmail([FromBody] EmailRequestDto emailRequestDto)
    {
        if(!ModelState.IsValid) return BadRequest(ModelState);

        var result = await _mailService.SendEmailAsync(emailRequestDto.ToEmail, emailRequestDto.ToName,
            emailRequestDto.Subject, emailRequestDto.Body);
        if(result) return Ok();
        return BadRequest("Something went wrong");
    }
    
    
}