using backend.Dtos.Sms;
using backend.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace backend.Controllers;

[ApiController]
[Route("api/sms")]
public class SmsController: ControllerBase
{
    private readonly ISmsService _smsService;

    public SmsController(ISmsService smsService)
    {
        _smsService = smsService;
    }

    [HttpPost("send")]
    public async Task<IActionResult> SendSms([FromBody] SmsRequestDto smsRequestDto)
    {
        if(!ModelState.IsValid) return BadRequest(ModelState);
        
        var status = await _smsService.SendSmsAsync(smsRequestDto.Recepient, smsRequestDto.Message);

        
        return Ok(status);
    }
    
}