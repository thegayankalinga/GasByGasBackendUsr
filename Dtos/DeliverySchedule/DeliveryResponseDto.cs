namespace backend.Dtos.DeliverySchedule;

public class DeliveryResponseDto
{
    public int Id { get; set; }
    public required DateOnly DeliveryDate { get; set; }
    public required bool ConfirmedByAdmin { get; set; }
    public required int NoOfUnitsInDelivery { get; set; }
    public required int OutletId { get; set; }
    public required string DispatcherVehicleId { get; set; }
}