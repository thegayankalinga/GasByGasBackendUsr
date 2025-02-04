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
    private readonly IOutletRepository _outletRepository;
    
    const int NO_OF_CYLINDERS_ALLOWED = 3;
    
    public AccountController(UserManager<AppUser> userManager, ITokenService tokenService, SignInManager<AppUser> signInManager, IOutletRepository outletRepository)
    {
        _userManager = userManager;
        _tokenService = tokenService;
        _signInManager = signInManager;
        _outletRepository = outletRepository;
    }
    
    //Controller Starts here
    [HttpPost("register")]
    public async Task<IActionResult> Register([FromBody] UserRegisterRequestDto requestDto)
    {
        try
        {
            if(!ModelState.IsValid)
                return BadRequest(ModelState);
            
            
            //Admin User Creation
            NewUserResponseDto responseDto = null;
            if (requestDto.UserType == UserType.Admin)
            {
                var appUser = new AppUser
                {
                    Email = requestDto.Email,
                    UserName = requestDto.Email,
                    FullName = requestDto.FullName,
                    PhoneNumber = requestDto.PhoneNumber,
                    ConsumerType = requestDto.UserType,
                    IsConfirm = true,
                };
                
                var createdUser = await _userManager.CreateAsync(appUser, requestDto.Password);
                if (createdUser.Succeeded)
                {
                
                    var roleResult = await _userManager.AddToRoleAsync(appUser, "Admin");
                    if (roleResult.Succeeded)
                    {
                        responseDto = new NewUserResponseDto
                        {
                            Email = appUser.Email,
                            FullName = appUser.FullName,
                            PhoneNumber = appUser.PhoneNumber,
                            IsConfirm = appUser.IsConfirm,
                            UserType = appUser.ConsumerType ?? UserType.Personal,
                            Token = await _tokenService.CreateToken(appUser)
                        };
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
            
            //Outlet Manager Creation
            else if (requestDto.UserType == UserType.Manager)
            {
                if (requestDto.OutletId == null)
                {
                    return BadRequest("Must provide an outlet id for Managers");
                }

                if (!await _outletRepository.OutletExists((int)requestDto.OutletId))
                {
                    return BadRequest("Outlet does not exist");
                }
                
                var appUser = new AppUser
                {
                    Email = requestDto.Email,
                    UserName = requestDto.Email,
                    FullName = requestDto.FullName,
                    PhoneNumber = requestDto.PhoneNumber,
                    ConsumerType = requestDto.UserType,
                    IsConfirm = true,
                    OutletId = requestDto.OutletId
                };
                
                var createdUser = await _userManager.CreateAsync(appUser, requestDto.Password);
                if (createdUser.Succeeded)
                {
                
                    var roleResult = await _userManager.AddToRoleAsync(appUser, "Manager");
                    if (roleResult.Succeeded)
                    {

                        responseDto = new NewUserResponseDto
                        {
                            Email = appUser.Email,
                            FullName = appUser.FullName,
                            OutletId = appUser.OutletId,
                            PhoneNumber = appUser.PhoneNumber,
                            IsConfirm = appUser.IsConfirm,
                            UserType = appUser.ConsumerType ?? UserType.Personal,
                            Token = await _tokenService.CreateToken(appUser)
                        };

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
            
            //Personal User
            else if (requestDto.UserType == UserType.Personal)
            {
                if (requestDto.NIC == null)
                {
                    return BadRequest("NIC is required for personal account");
                }

                if (requestDto.City == null || requestDto.Address == null)
                {
                    return BadRequest("City and Address is required for personal account");
                }
                
                var appUser = new AppUser
                {
                    Email = requestDto.Email,
                    UserName = requestDto.Email,
                    FullName = requestDto.FullName,
                    NIC = requestDto.NIC,
                    PhoneNumber = requestDto.PhoneNumber,
                    Address = requestDto.Address,
                    City = requestDto.City,
                    ConsumerType = requestDto.UserType,
                    IsConfirm = true,
                    NoOfCylindersAllowed = NO_OF_CYLINDERS_ALLOWED,
                    RemainingCylindersAllowed = NO_OF_CYLINDERS_ALLOWED
                };
                
                
                var createdUser = await _userManager.CreateAsync(appUser, requestDto.Password);
                if (createdUser.Succeeded)
                {
                
                    var roleResult = await _userManager.AddToRoleAsync(appUser, "User");
                    if (roleResult.Succeeded)
                    {

                        responseDto = new NewUserResponseDto
                        {
                            Email = appUser.Email,
                            FullName = appUser.FullName,
                            NIC = appUser.NIC,
                            PhoneNumber = appUser.PhoneNumber,
                            Address = appUser.Address,
                            City = appUser.City,
                            IsConfirm = appUser.IsConfirm,
                            NoOfCylindersAllowed = appUser.NoOfCylindersAllowed,
                            RemainingCylindersAllowed = appUser.RemainingCylindersAllowed,
                            UserType = appUser.ConsumerType ?? UserType.Personal,
                            Token = await _tokenService.CreateToken(appUser)
                        };

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
            
            //Business User & Industries
            else if (requestDto.UserType == UserType.Business || requestDto.UserType == UserType.Industries)
            {

                if (requestDto.City == null || requestDto.Address == null)
                {
                    return BadRequest("City and Address is required for personal account");
                }
                
                if (requestDto.BusinessRegistration == null)
                {
                    return BadRequest("Business registration is required for Business & Industries");
                }

                if (requestDto.NoOfCylindersAllowed == null)
                {
                    return BadRequest("No of Cylinders are required for Business & Industries");
                }
                
                var appUser = new AppUser
                {
                    Email = requestDto.Email,
                    UserName = requestDto.Email,
                    FullName = requestDto.FullName,
                    BusinessRegistration = requestDto.BusinessRegistration,
                    PhoneNumber = requestDto.PhoneNumber,
                    Address = requestDto.Address,
                    City = requestDto.City,
                    ConsumerType = requestDto.UserType,
                    IsConfirm = false,
                    NoOfCylindersAllowed = requestDto.NoOfCylindersAllowed,
                    RemainingCylindersAllowed = requestDto.NoOfCylindersAllowed
                };
                
                var createdUser = await _userManager.CreateAsync(appUser, requestDto.Password);
                if (createdUser.Succeeded)
                {
                
                    var roleResult = await _userManager.AddToRoleAsync(appUser, "User");
                    if (roleResult.Succeeded)
                    {

                        responseDto = new NewUserResponseDto
                        {
                            Email = appUser.Email,
                            FullName = appUser.FullName,
                            BusinessRegistration = appUser.BusinessRegistration,
                            PhoneNumber = appUser.PhoneNumber,
                            Address = appUser.Address,
                            City = appUser.City,
                            IsConfirm = appUser.IsConfirm,
                            UserType = appUser.ConsumerType ?? UserType.Personal,
                            NoOfCylindersAllowed = appUser.NoOfCylindersAllowed,
                            RemainingCylindersAllowed = appUser.RemainingCylindersAllowed,
                            Token = await _tokenService.CreateToken(appUser)
                        };

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
            if (responseDto == null){return BadRequest("Something went wrong");}
            return Ok(responseDto);
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
            BusinessRegistration = user.BusinessRegistration ?? throw new InvalidOperationException(),
            IsConfirm = user.IsConfirm,
            OutletId = user.OutletId,
            PhoneNumber = user.PhoneNumber ?? throw new InvalidOperationException(),
            Address = user.Address ?? throw new InvalidOperationException(),  
            City = user.City ?? throw new InvalidOperationException(),
            UserType = user.ConsumerType ?? UserType.Personal,
            Token = await _tokenService.CreateToken(user)
        });
    }
    
}