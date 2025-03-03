using backend.Dtos.Account;
using backend.Enums;
using backend.Interfaces;
using backend.Mappers;
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
    private readonly IAccountRepository _accountRepo;
    
    const int NO_OF_CYLINDERS_ALLOWED = 3;
    
    public AccountController(UserManager<AppUser> userManager, ITokenService tokenService, SignInManager<AppUser> signInManager, IOutletRepository outletRepository, IAccountRepository accountRepo)
    {
        _userManager = userManager;
        _tokenService = tokenService;
        _signInManager = signInManager;
        _outletRepository = outletRepository;
        _accountRepo = accountRepo;
    }


    [HttpGet("getManagers/{outletId}")]
    public async Task<IActionResult> GetManagers(int outletId)
    {
        var outlet = await _outletRepository.OutletExists(outletId);
        if (outlet == null)
        {
            return NotFound("Outlet not found");
        }
        
       
        var managers = await _accountRepo.GetManagersByOutletIdAsync(outletId);
        if (!managers.Any())
        {
            return NoContent();
        }
        var managerReponseDtos = managers.Select(s => s.ToManagerReponseDto());
        return Ok(managerReponseDtos);
    }

    [HttpGet("getConsumers")]
    public async Task<IActionResult> GetConsumers()
    {
        var consumers = await _accountRepo.GetConsumersAsync();
        if (!consumers.Any())
        {
            return NoContent();
        }

        var consumerReponseDtos = consumers.Select(s => s.ToConsumerResponseDto());
        return Ok(consumerReponseDtos);
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
            NIC = user.NIC,
            BusinessRegistration = user.BusinessRegistration,
            IsConfirm = user.IsConfirm,
            OutletId = user.OutletId,
            PhoneNumber = user.PhoneNumber ?? throw new InvalidOperationException(),
            Address = user.Address, 
            City = user.City,
            RemainingCylindersAllowed = user.RemainingCylindersAllowed,
            NoOfCylindersAllowed = user.NoOfCylindersAllowed,
            UserType = user.ConsumerType ?? UserType.Personal,
            Token = await _tokenService.CreateToken(user)
        });
    }

    [HttpPut("update/{email}")]
    public async Task<IActionResult> UpdateUser([FromRoute] string email, [FromBody] UpdateUserDto updateUserDto)
    {
        try
        {
            if (!ModelState.IsValid)
                return BadRequest(ModelState);

            var user = await _userManager.FindByEmailAsync(email);
            if (user == null)
                return NotFound("User not found");
            
            // Update user properties
            user.Email = updateUserDto.Email ?? user.Email;
            user.UserName = updateUserDto.Email ?? user.UserName;
            user.FullName = updateUserDto.FullName ?? user.FullName;
            user.PhoneNumber = updateUserDto.PhoneNumber ?? user.PhoneNumber;

            if (updateUserDto.ConsumerType == UserType.Personal)
            {
                user.NIC = updateUserDto.NIC ?? user.NIC;
                user.City = updateUserDto.City ?? user.City;
                user.Address = updateUserDto.Address ?? user.Address;
               
            }
            
            if (updateUserDto.ConsumerType == UserType.Manager)
            {
                user.OutletId = updateUserDto.OutletId ?? user.OutletId;
            }

            if (updateUserDto.ConsumerType == UserType.Business || updateUserDto.ConsumerType == UserType.Industries)
            {
                user.BusinessRegistration = updateUserDto.BusinessRegistration ?? user.BusinessRegistration;
                user.City = updateUserDto.City ?? user.City;
                user.Address = updateUserDto.Address ?? user.Address;
               
            }
           
            
            var result = await _userManager.UpdateAsync(user);
            if(!result.Succeeded) return StatusCode(500, result.Errors);

            var updatedUser = await _userManager.FindByEmailAsync(email);
            return Ok(new NewUserResponseDto
            {
                //Force unwrap the null here
                Email = updatedUser!.Email ?? throw new InvalidOperationException(),
                FullName = updatedUser.FullName ?? throw new InvalidOperationException(),
                NIC = updatedUser.NIC,
                BusinessRegistration = updatedUser.BusinessRegistration,
                IsConfirm = updatedUser.IsConfirm,
                OutletId = updatedUser.OutletId,
                PhoneNumber = updatedUser.PhoneNumber ?? throw new InvalidOperationException(),
                Address = updatedUser.Address, 
                City = updatedUser.City,
                RemainingCylindersAllowed = updatedUser.RemainingCylindersAllowed,
                NoOfCylindersAllowed = updatedUser.NoOfCylindersAllowed,
                UserType = updatedUser.ConsumerType ?? UserType.Personal,
                Token = await _tokenService.CreateToken(updatedUser)
            });

        }catch (Exception e)
        {
            Console.WriteLine(e);
            return StatusCode(500, e.Message);
        }
    }
    
    
    [HttpPut("updateConfirmStatus/{email}")]
    public async Task<IActionResult> UpdateUserConfirmation([FromRoute] string email, UpdateConfimDto updateConfimDto)
    {
        try
        {
            if (!ModelState.IsValid)
                return BadRequest(ModelState);
        
            var user = await _userManager.FindByEmailAsync(email);
            if (user == null)
                return NotFound("User not found");
            
            // Update user properties

            user.IsConfirm = updateConfimDto.IsConfirm;
           
            
            var result = await _userManager.UpdateAsync(user);
            
            if(!result.Succeeded) return StatusCode(500, result.Errors);
            return Ok(new { message = "User updated successfully with confirmation status" });
        
        }catch (Exception e)
        {
            Console.WriteLine(e);
            return StatusCode(500, e.Message);
        }
    }
    
    [HttpPut("updateReminaingCylinders/{email}")]
    public async Task<IActionResult> UpdateRemainingCylinders([FromRoute] string email, UpdateRemainingCylinders remainingCylindersDto)
    {
        try
        {
            if (!ModelState.IsValid)
                return BadRequest(ModelState);
        
            var user = await _userManager.FindByEmailAsync(email);
            if (user == null)
                return NotFound("User not found");
            
            // Update user properties

            user.RemainingCylindersAllowed = remainingCylindersDto.RemainingCylindersAllowed;
            
            var result = await _userManager.UpdateAsync(user);
            if(!result.Succeeded) return StatusCode(500, result.Errors);
            
            return Ok(new { message = "User updated successfully with new remaining cylinders" });
        
        }catch (Exception e)
        {
            Console.WriteLine(e);
            return StatusCode(500, e.Message);
        }
    }
    
    [HttpPut("updateAllowedCylinders/{email}")]
    public async Task<IActionResult> UpdateAllowedCylinders([FromRoute] string email, UpdateAllowedCylindersDto allowedCylindersDto)
    {
        try
        {
            if (!ModelState.IsValid)
                return BadRequest(ModelState);
        
            var user = await _userManager.FindByEmailAsync(email);
            if (user == null)
                return NotFound("User not found");
            
            // Update user properties

            user.NoOfCylindersAllowed = allowedCylindersDto.NoOfCylindersAllowed;
            
            var result = await _userManager.UpdateAsync(user);
            if(!result.Succeeded) return StatusCode(500, result.Errors);
            
            return Ok(new { message = "User updated successfully with new no of allowed cylinders" });
        
        }catch (Exception e)
        {
            Console.WriteLine(e);
            return StatusCode(500, e.Message);
        }
    }
    
}