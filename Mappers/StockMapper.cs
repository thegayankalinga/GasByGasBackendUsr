using backend.Dtos.StockRequest;
using backend.Models;

namespace backend.Mappers;

public static class StockMapper
{
    public static StockRequestReponseDto StockRequestToStockRequestResponseDto(this StockRequest model)
    {
        return new StockRequestReponseDto()
        {
            Id = model.Id,
            OutletId = model.OutletId,
            DeliveryScheduleId = model.DeliveryScheduleId,
            RequestedDate = model.RequestedDate,
            CompletedDate = model.CompletedDate,
            Completed = model.Completed,
            NoOfUnitsRequired = model.NoOfUnitsRequired,
            NoOfUnitsDispatched = model.NoOfUnitsDispatched,
        };
    }

    public static StockRequest StockRequestDtoToStockRequest(this StockRequestDto dto)
    {
        return new StockRequest
        {
            OutletId = dto.OutletId,
            RequestedDate = DateOnly.FromDateTime(DateTime.Now),
            NoOfUnitsRequired = dto.NoOfUnitsRequired,
        };
    }
}