using backend.Dtos.GasToken;
using backend.Enums;
using backend.Models;

namespace backend.Mappers;

public static class TokenMapper
{

    public static TokenResponseDto ToTokenResponseDto(this GasToken tokenModel)
    {
        return new TokenResponseDto()
        {
            Id = tokenModel.Id,
            RequestDate = tokenModel.RequestDate,
            ReadyDate = tokenModel.ReadyDate,
            ExpectedPickupDate = tokenModel.ExpectedPickupDate,
            Status = tokenModel.Status,
            Price = tokenModel.Price,
            IsPaid = tokenModel.IsPaid,
            PaymentDate = tokenModel.PaymentDate,
            IsEmpltyCylindersGiven = tokenModel.IsEmpltyCylindersGivent,
            ConsumerType = tokenModel.ConsumerType,
            UserEmail = tokenModel.UserEmail,
            OutletId = tokenModel.OutletId,
            DeliveryScheduleId = tokenModel.DeliveryScheduleId
        };

    }
    public static GasToken ToTokenFromCreateTokenDto(this CreateTokenRequestDto createTokenDto, int outletId, string userEmail){

        return new GasToken
        {
            RequestDate = DateOnly.FromDateTime(DateTime.Now),
            ExpectedPickupDate = createTokenDto.ExpectedPickupDate,
            Status = GasTokenStatus.Pending,
            ConsumerType = createTokenDto.ConsumerType,
            UserEmail = userEmail,
            OutletId = outletId
        };
    }
}