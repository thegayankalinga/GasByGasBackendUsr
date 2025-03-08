using backend.Dtos.DeliverySchedule;
using backend.Models;

namespace backend.Mappers;

public static class DeliveryScheduleMapper
{
    //Model to Response
    public static DeliveryResponseDto DeliverySheduleModelToResponseDto(this DeliverySchedule deliveryScheduleModel)
    {
        return new DeliveryResponseDto
        {
            Id = deliveryScheduleModel.Id,
            DeliveryDate = deliveryScheduleModel.DeliveryDate,
            ConfirmedByAdmin = deliveryScheduleModel.ConfirmedByAdmin,
            NoOfUnitsInDelivery = deliveryScheduleModel.NoOfUnitsInDelivery,
            OutletId = deliveryScheduleModel.OutletId,
            DispatcherVehicleId = deliveryScheduleModel.DispatcherVehicleId,
            
        };
    }
        
    //Request to Model
    public static DeliverySchedule DeliveryRequestDtoToDeliveryModel(this DeliveryRequestDto deliveryRequestDto)
    {
        return new DeliverySchedule
        {
            DeliveryDate = deliveryRequestDto.DeliveryDate,
            ConfirmedByAdmin = deliveryRequestDto.ConfirmedByAdmin,
            NoOfUnitsInDelivery = deliveryRequestDto.NoOfUnitsInDelivery,
            OutletId = deliveryRequestDto.OutletId,
            DispatcherVehicleId = deliveryRequestDto.DispatcherVehicleId,
        };
    }
}