using backend.Dtos.StockRequest;
using backend.Interfaces;
using backend.Mappers;
using backend.Models;
using Microsoft.AspNetCore.Mvc;

namespace backend.Controllers;

[ApiController]
[Route("api/stocks")]
public class StockController: ControllerBase
{
    
    private readonly IStockRepository _stockRepository;
    private readonly IOutletRepository _outletRepository;
    private readonly IDeliveryRepository _deliveryRepository;

    public StockController(IStockRepository stockRepository, IOutletRepository outletRepository, IDeliveryRepository deliveryRepository)
    {
        _stockRepository = stockRepository;
        _outletRepository = outletRepository;
        _deliveryRepository = deliveryRepository;
    }
    
    [HttpGet]
    public async Task<IActionResult> GetAll()
    {
        var stockRequests = await _stockRepository.GetAllStockRequestsAsync();
        var stockRequestResponseDto = stockRequests.Select(s => s.StockRequestToStockRequestResponseDto());
        return Ok(stockRequestResponseDto);
    }

    [HttpGet ("{id}")]
    public async Task<IActionResult> GetById([FromRoute] int id)
    {
        var stockRequest = await _stockRepository.GetStockRequestByIdAsync(id);
        if (stockRequest == null)return NotFound("No stock request found");
        var stockRequestResponseDto = stockRequest.StockRequestToStockRequestResponseDto();
        return Ok(stockRequestResponseDto);
    }

    [HttpGet ("by-outlet/{id}")]
    public async Task<IActionResult> GetStockRequestByOutletId([FromRoute] int id)
    {
        
        var stockRequests = await _stockRepository.GetAllStockRequestsByOutletIdAsync(id);
        if (stockRequests == null)return NotFound("No stock request found for that outlet");
        
        var stockRequestResponseDtos = stockRequests.Select(s => s.StockRequestToStockRequestResponseDto());
        return Ok(stockRequestResponseDtos);
    }


    [HttpPost]
    public async Task<IActionResult> CreateNewStockRequest([FromBody] StockRequestDto request)
    {
        
       
        
        if (!ModelState.IsValid) return BadRequest(ModelState);
        //TODO: Block if more than 3 open requests in service level and controller level
        
        var outlet = await _outletRepository.OutletExists(request.OutletId);
        if (!outlet) return NotFound("No outlet found");
  
        var stockModel = request.StockRequestDtoToStockRequest();
        var stockRequest = await _stockRepository.CreateStockRequestAsync(stockModel);
        if (stockRequest == null) return BadRequest(ModelState);
        
        var stockRequestResponseDto = stockRequest.StockRequestToStockRequestResponseDto();
        return CreatedAtAction(nameof(GetById), new{id = stockRequest.Id}, stockRequestResponseDto);
        
    }

    [HttpPut]
    [Route("{id}")]
    public async Task<IActionResult> UpdateStockRequest([FromRoute] int id, [FromBody] StockRequestUpdateRequestDto request)
    {
        if (!ModelState.IsValid) return BadRequest(ModelState);

        if (request.OutletId != null)
        {
            var outlet = await _outletRepository.OutletExists((int)request.OutletId);
            if (!outlet) return NotFound("No outlet fo that ID found");
        }

        if (request.DeliveryScheduleId != null)
        {
            var delivery = await _deliveryRepository.DeliveryExists((int)request.DeliveryScheduleId);
            if (!delivery) return NotFound("No delivery schedule found");
        }

        var stockRequest = await _stockRepository.UpdateStockRequestAsync(id, request);
        if (stockRequest == null) return BadRequest(ModelState);
        
        var stockRequestResponseDto = stockRequest.StockRequestToStockRequestResponseDto();
        return Ok(stockRequestResponseDto);
    }
    
}