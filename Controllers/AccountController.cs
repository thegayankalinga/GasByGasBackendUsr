using backend.Dtos.Account;
using backend.Enums;
using backend.Interfaces;
using backend.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace backend.Controllers;

[ApiController]
[Route("api/account")]
public class AccountController : ControllerBase
{
    private readonly UserManager<AppUser> _userManager;
    private readonly ITokenService _tokenService;
    private readonly SignInManager<AppUser> _signInManager;
    
    public AccountController(UserManager<AppUser> userManager, ITokenService tokenService, SignInManager<AppUser> signInManager)
    {
        _userManager = userManager;
        _tokenService = tokenService;
        _signInManager = signInManager;
    }
    
    //Controller Starts here
    [HttpPost("register")]
    public async Task<IActionResult> Register([FromBody] UserRegisterRequestDto requestDto)
    {
        try
        {
            if(!ModelState.IsValid)
                return BadRequest(ModelState);
            //TODO: Additional validation to check if the user role is type user and if the NIC is duplicated
            
            var appUser = new AppUser
            {
                Email = requestDto.Email,
                UserName = requestDto.Email,
                FullName = requestDto.FullName,
                NIC = requestDto.NIC,
                PhoneNumber = requestDto.PhoneNumber,
                Address = requestDto.Address,
                City = requestDto.City,
                ConsumerType = requestDto.ConsumerType
            };
            
            var createdUser = await _userManager.CreateAsync(appUser, requestDto.Password);
            if (createdUser.Succeeded)
            {
                var roleResult = await _userManager.AddToRoleAsync(appUser, "User");
                if (roleResult.Succeeded)
                {
                    return Ok(
                            new NewUserResponseDto
                            {
                                Email = appUser.Email,
                                FullName = appUser.FullName,
                                NIC = appUser.NIC,
                                PhoneNumber = appUser.PhoneNumber,
                                Address = appUser.Address,  
                                City = appUser.City,
                                ConsumerType = appUser.ConsumerType ?? ConsumerType.Personal,
                                Token = await _tokenService.CreateToken(appUser)
                            }
                    );
                }
                else
                {
                    return StatusCode(500, roleResult.Errors);
                }
            }
            else
            {
                return StatusCode(500, createdUser.Errors);
            }
        }
        catch (Exception e)
        {
            Console.WriteLine(e);
            return StatusCode(500, e.Message);
        }
    }
    
    //[Authorize] to have token requirement enforced for the user
    //[Authorize]
    [HttpPost("login")]
    public async Task<IActionResult> Login(LoginDto loginDto)
    {
        if(!ModelState.IsValid)
            return BadRequest(ModelState);
        
        var user = await _userManager.Users.FirstOrDefaultAsync(user => user.Email == loginDto.Email);
        if(user == null) 
            return Unauthorized("Invalid Credentials");
        
        var result = await _signInManager.CheckPasswordSignInAsync(user, loginDto.Password, false);
        if(!result.Succeeded)
            return Unauthorized("Invalid Credentials!");

        return Ok(new NewUserResponseDto
        {
            Email = user.Email ?? throw new InvalidOperationException(),
            FullName = user.FullName ?? throw new InvalidOperationException(),
            NIC = user.NIC ?? throw new InvalidOperationException(),
            PhoneNumber = user.PhoneNumber ?? throw new InvalidOperationException(),
            Address = user.Address ?? throw new InvalidOperationException(),  
            City = user.City ?? throw new InvalidOperationException(),
            ConsumerType = user.ConsumerType ?? ConsumerType.Personal,
            Token = await _tokenService.CreateToken(user)
        });
    }
    
}