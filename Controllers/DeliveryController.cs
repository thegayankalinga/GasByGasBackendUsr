using backend.Dtos.DeliverySchedule;
using backend.Interfaces;
using backend.Mappers;
using Microsoft.AspNetCore.Mvc;

namespace backend.Controllers;
[ApiController]
[Route("api/delivery")]
public class DeliveryController: ControllerBase
{
    private readonly IDeliveryRepository _deliveryRepository;
    private readonly IOutletRepository _outletRepository;

    public DeliveryController(IDeliveryRepository deliveryRepository, IOutletRepository outletRepository)
    {
        _deliveryRepository = deliveryRepository;
        _outletRepository = outletRepository;
    }


    [HttpPost]
    public async Task<IActionResult> Create([FromBody] DeliveryRequestDto request)
    {
        if(!ModelState.IsValid) return BadRequest(ModelState);
        
        var outlet = await _outletRepository.OutletExists(request.OutletId);
        if(!outlet) return NotFound("Outlet not found");

        var deliveryScheduleModel = request.DeliveryRequestDtoToDeliveryModel();
        await _deliveryRepository.CreateAsync(deliveryScheduleModel);
        return CreatedAtAction(nameof(GetById), new { id = deliveryScheduleModel.Id }, deliveryScheduleModel.DeliverySheduleModelToResponseDto());
        

    }

    [HttpGet("{id}")]
    public async Task<IActionResult> GetById([FromRoute] int id)
    {
        var schedule = await _deliveryRepository.GetById(id);
        if(schedule == null) return NotFound();
        return Ok(schedule.DeliverySheduleModelToResponseDto());
  
    }

    [HttpGet]
    public async Task<IActionResult> GetAll()
    {
        var schedules = await _deliveryRepository.GetAllAsync();
        return Ok(schedules.Select(schedule => schedule.DeliverySheduleModelToResponseDto()));
    }

    [HttpPut("{id}")]
    public async Task<IActionResult> Update([FromRoute] int id, [FromBody] DeliveryRequestDto request)
    {
        var outlet = await _outletRepository.OutletExists(request.OutletId);
        if(!outlet) return NotFound("Outlet not found");
        
        var scheduleModel = await _deliveryRepository.UpdateAsync(id, request);
        if(scheduleModel == null) return NotFound();
        return Ok(scheduleModel.DeliverySheduleModelToResponseDto());
    }
    
    [HttpDelete("{id}")]
    public async Task<IActionResult> Delete([FromRoute] int id)
    {
        try
        {
            var existingSchedule = await _deliveryRepository.GetById(id);
            if (existingSchedule == null)
                return NotFound("Delivery schedule not found");

            var result = await _deliveryRepository.DeleteAsync(id);
            if (!result)
                return StatusCode(500, "An error occurred while deleting the delivery schedule.");

            return Ok(new { message = $"Delivery schedule with ID {id} deleted successfully" });
        }
        catch (Exception e)
        {
            Console.WriteLine(e);
            return StatusCode(500, "An error occurred while deleting the delivery schedule.");
        }
    }
    
}