using backend.Data;
using backend.Dtos.GasToken;
using backend.Interfaces;
using backend.Models;
using backend.Services;
using Microsoft.EntityFrameworkCore;

namespace backend.Repositories;

public class GasTokenRepository : IGasTokenRepository
{
    private readonly ApplicationDbContext _context;
    private readonly IMailService _mailService;
    private readonly ISmsService _smsService;
  
    public GasTokenRepository(ApplicationDbContext context, IMailService mailService, ISmsService smsService)
    {
        _context = context;
        _mailService = mailService;
        _smsService = smsService;
    }
    
    public async Task<List<GasToken>> GetAllAsync()
    {
        return await _context.GasTokens.ToListAsync();
    }

    public async Task<GasToken> CreateAsync(GasToken gasTokenModel)
    {
        await _context.GasTokens.AddAsync(gasTokenModel);
        await _context.SaveChangesAsync();
        return gasTokenModel;
    }

    public async Task<GasToken?> GetByIdAsync(int id)
    {
        return await _context.GasTokens.FirstOrDefaultAsync(x => x.Id == id);
    }

    public async Task<List<GasToken>> GetAllByEmailAsync(string email)
    {
        return await _context.GasTokens.Where(x => x.UserEmail == email).ToListAsync();
    }

    public async Task<List<GasToken>> GetAllByOutletAsync(int outletId)
    {
        return await _context.GasTokens.Where(x => x.OutletId == outletId).ToListAsync();
    }
    
    //Update the Expected PickUp Date
    public async Task<GasToken?> UpdateExpectedDateOfTokenAsync(int id, CreateTokenRequestDto createTokenDto)
    {
        var tokenModel = await _context.GasTokens.FirstOrDefaultAsync(x => x.Id == id);
        if (tokenModel == null)
        {
            return null;
        }
        
        tokenModel.ExpectedPickupDate = createTokenDto.ExpectedPickupDate;
        await _mailService.SendEmailAsync(tokenModel.UserEmail, "User Name", "Updated Gas Pickup Date",
            $"Your New Pickup Date is {tokenModel.ExpectedPickupDate}");
        //Removed the SMS Gateway due to cost
        
        await _context.SaveChangesAsync();
        return tokenModel;
    }

    public async Task<GasToken?> UpdateTokenAsync(int id, UpdateTokenDto updateTokenDto)
    {
        var tokenModel = await _context.GasTokens.FirstOrDefaultAsync(x => x.Id == id);
        
        if (tokenModel == null)
        {
            return null;
        }
        
        tokenModel.ReadyDate = updateTokenDto.ReadyDate;
        tokenModel.ExpectedPickupDate = updateTokenDto.ExpectedPickupDate;
        tokenModel.Status = updateTokenDto.Status;
        tokenModel.IsEmptyCylinderGiven = updateTokenDto.IsEmpltyCylindersGivent;
        tokenModel.IsPaid = updateTokenDto.IsPaid;
        tokenModel.PaymentDate = updateTokenDto.PaymentDate;
        tokenModel.UserEmail = updateTokenDto.UserEmail;
        tokenModel.DeliveryScheduleId = updateTokenDto.DeliveryScheduleId;
        
        await _context.SaveChangesAsync();
        
        string message = $"@" +
                         $"Your Request has been updated with the following information" +
                         $"Ready Date: {tokenModel.ReadyDate}" +
                         $"Expected Pickup Date: {tokenModel.ExpectedPickupDate}";
                        
        
        await _mailService.SendEmailAsync(tokenModel.UserEmail, "User Name", "Updated Gas Request",
            $"Your Request Details Has been Updated {tokenModel.ExpectedPickupDate}");
        
        return tokenModel;
    }

    public async Task<GasToken?> DeleteTokenAsync(int id)
    {
        var gasTokenModel = await _context.GasTokens.FirstOrDefaultAsync(x => x.Id == id);
        
        if (gasTokenModel == null)
        {
            return null;
        }
        _context.GasTokens.Remove(gasTokenModel);
        await _context.SaveChangesAsync();
        return gasTokenModel;
    }

    public async Task<List<GasToken>> GetGasTokensByDeliveryScheduleIdAsync(int deliveryScheduleId)
    {
        return await _context.GasTokens.Where(x => x.DeliveryScheduleId == deliveryScheduleId).ToListAsync();
    }
}