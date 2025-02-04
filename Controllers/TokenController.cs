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
    
    public TokenController(IGasTokenRepository tokenRepo, IOutletRepository outletRepo, IAccountRepository accountRepo)
    {
        _tokenRepo = tokenRepo;
        _accountRepo = accountRepo;
        _outletRepo = outletRepo;
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
    [HttpPut("{id}")]
    public async Task<IActionResult> UpdateTokenDate([FromRoute] int id, [FromBody] CreateTokenRequestDto createTokenDto)
    {
        var tokenModel = await _tokenRepo.UpdateExpectedDateOfTokenAsync(id, createTokenDto);
        if(tokenModel == null){return NotFound();}
        return Ok(tokenModel.ToTokenResponseDto());
    }
    
    //Delete
}