using System.Collections.Specialized;
using backend.Dtos.GasToken;
using backend.Interfaces;
using backend.Mappers;
using Microsoft.AspNetCore.Mvc;

namespace backend.Controllers;

[ApiController]
[Route("api/gastoken")]
public class TokenController : ControllerBase
{
    private readonly IGasTokenRepository _tokenRepo;
    private readonly IOutletRepository _outletRepo;
    private readonly IAccountRepository _accountRepo;
    private readonly IDeliveryRepository _deliveryRepo;
    
    public TokenController(IGasTokenRepository tokenRepo, IOutletRepository outletRepo, IAccountRepository accountRepo, IDeliveryRepository deliveryRepo)
    {
        _tokenRepo = tokenRepo;
        _accountRepo = accountRepo;
        _outletRepo = outletRepo;
        _deliveryRepo = deliveryRepo;
    }
    
    //Get All
     [HttpGet]
     public async Task<IActionResult> GetAll()
     {
         var gasTokens = await _tokenRepo.GetAllAsync();
         var gasTokenDtos = gasTokens.Select(s => s.ToTokenResponseDto());
         return Ok(gasTokenDtos);
     }
     
     //Get all tokens by user 
     [HttpGet("byuser/{email}")]
     public async Task<IActionResult> GetAllByUser([FromRoute] string email)
     {
         var gasTokens = await _tokenRepo.GetAllByEmailAsync(email);
         var gasToekDtos = gasTokens.Select(s => s.ToTokenResponseDto());
         return Ok(gasToekDtos);
     }
     
     //Get all tokens by outlet
     [HttpGet("byoutlet/{outletId}")]
     public async Task<IActionResult> GetAllByOutlet([FromRoute] int outletId)
     {
         var gasTokens = await _tokenRepo.GetAllByOutletAsync(outletId);
         var gasTokensDtos = gasTokens.Select(s => s.ToTokenResponseDto());
         return Ok(gasTokensDtos);
     }
    
    //Get by Id
    [HttpGet("{id}")]
    public async Task<IActionResult> GetById([FromRoute] int id)
    {
        var token = await _tokenRepo.GetByIdAsync(id);
        if(token == null){return NotFound();}

        return Ok(token.ToTokenResponseDto());
    }
    
    //Post
    [HttpPost]
    public async Task<IActionResult> Create([FromQuery] int outletId, [FromQuery]string consumerEmail, [FromBody] CreateTokenRequestDto createTokenDto){
        //Check if the parent is existing
        if(!await _accountRepo.UserExists(consumerEmail)){
            return BadRequest("User does not exist");
        }

        if (!await _outletRepo.OutletExists(outletId))
        {
            return BadRequest("Outlet does not exist");
        }

        var tokenModel = createTokenDto.ToTokenFromCreateTokenDto(outletId, consumerEmail);
        await _tokenRepo.CreateAsync(tokenModel);
        return CreatedAtAction(nameof(GetById), new{id = tokenModel.Id}, tokenModel.ToTokenResponseDto());
        //return CreatedAtAction(nameof(GetById), new{id = childModel}, childModel.ToChildDto());
    }
    
    //Put
    [HttpPut("expectedDate/{id}")]
    public async Task<IActionResult> UpdateTokenExpectedDate([FromRoute] int id, [FromBody] CreateTokenRequestDto createTokenDto)
    {
        var tokenModel = await _tokenRepo.UpdateExpectedDateOfTokenAsync(id, createTokenDto);
        if(tokenModel == null){return NotFound();}
        return Ok(tokenModel.ToTokenResponseDto());
    }
    
    //Put
    [HttpPut("update/{id}")]
    public async Task<IActionResult> UpdateToken([FromRoute] int id, [FromBody] UpdateTokenDto updateTokenDto){
        
        //if the user email not found 
        var user = await _accountRepo.UserExists(updateTokenDto.UserEmail);
        
        if (!user)
        {
            return BadRequest("User does not exist");
        }
      
        //if the delivery schedule id is not found
        if (updateTokenDto.DeliveryScheduleId != null)
        {
            Console.WriteLine("inside the delivery schedule");
            
            var deliverySchedule = await _deliveryRepo.DeliveryExists((int)updateTokenDto.DeliveryScheduleId);
            Console.WriteLine(deliverySchedule);
            if(!deliverySchedule){return BadRequest("Delivery Schedule does not exist");}
        }
       
        
        var tokenModel= await _tokenRepo.UpdateTokenAsync(id, updateTokenDto);
        if(tokenModel == null){return NotFound();}
        return Ok(tokenModel.ToTokenResponseDto());
    }
    
    //Delete
    [HttpDelete]
    [RouteAttribute("{tokenId}")]
    public async Task<IActionResult> DeleteGasToken([FromRoute] int tokenId)
    {
        var gasTokenModel = await _tokenRepo.DeleteTokenAsync(tokenId);
        if (gasTokenModel == null)
        {
            return NotFound();
        }

         
        return NoContent();
    }
}