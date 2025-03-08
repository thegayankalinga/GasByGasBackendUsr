using backend.Data;
using backend.Dtos.GasToken;
using backend.Interfaces;
using backend.Models;
using Microsoft.EntityFrameworkCore;

namespace backend.Repositories;

public class GasTokenRepository : IGasTokenRepository
{
    private readonly ApplicationDbContext _context;
  
    public GasTokenRepository(ApplicationDbContext context)
    {
        _context = context;
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

    public async Task<GasToken> GetByIdAsync(int id)
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
    public async Task<GasToken> UpdateExpectedDateOfTokenAsync(int id, CreateTokenRequestDto createTokenDto)
    {
        var tokenModel = await _context.GasTokens.FirstOrDefaultAsync(x => x.Id == id);
        if (tokenModel == null)
        {
            return null;
        }

        tokenModel.ExpectedPickupDate = createTokenDto.ExpectedPickupDate;
        
        await _context.SaveChangesAsync();
        return tokenModel;
    }

    public async Task<GasToken> UpdateTokenAsync(int id, UpdateTokenDto updateTokenDto)
    {
        var tokenModel = await _context.GasTokens.FirstOrDefaultAsync(x => x.Id == id);
        
        if (tokenModel == null)
        {
            return null;
        }
        
        tokenModel.ReadyDate = updateTokenDto.ReadyDate;
        tokenModel.ExpectedPickupDate = updateTokenDto.ExpectedPickupDate;
        tokenModel.Status = updateTokenDto.Status;
        tokenModel.IsEmpltyCylindersGivent = updateTokenDto.IsEmpltyCylindersGivent;
        tokenModel.IsPaid = updateTokenDto.IsPaid;
        tokenModel.PaymentDate = updateTokenDto.PaymentDate;
        tokenModel.UserEmail = updateTokenDto.UserEmail;
        tokenModel.DeliveryScheduleId = updateTokenDto.DeliveryScheduleId;
        
        await _context.SaveChangesAsync();
        return tokenModel;
    }

    public async Task<GasToken> DeleteTokenAsync(int id)
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
}