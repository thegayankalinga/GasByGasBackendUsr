using System.ComponentModel.DataAnnotations;

namespace backend.Dtos.DeliverySchedule;

public class DeliveryRequestDto
{
    public required DateOnly DeliveryDate { get; set; }
    public required bool ConfirmedByAdmin { get; set; }
    public required int NoOfUnitsInDelivery { get; set; }
    public required int OutletId { get; set; }
    [MaxLength(30)]
    public required string DispatcherVehicleId { get; set; }
}