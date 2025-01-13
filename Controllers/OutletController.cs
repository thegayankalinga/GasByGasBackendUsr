using backend.Dtos.Outlet;
using backend.Interfaces;
using backend.Mappers;
using Microsoft.AspNetCore.Mvc;

namespace backend.Controllers;

[ApiController]
[Route("api/outlet")]
public class OutletController : ControllerBase
{
    private readonly IOutletRepository _outletRepo;

    public OutletController(IOutletRepository outletRepo)
    {
        _outletRepo = outletRepo;
    }
    
    [HttpGet]
    public async Task<ActionResult<IEnumerable<OutletResponseDto>>> GetAll()
    {
        var outlets = await _outletRepo.GetAllOutletsAsync();
        var outletDtos = outlets.Select(o => o.ToUserResponseDto());
        return Ok(outletDtos);
    }

    [HttpGet("{id}")]
    public async Task<IActionResult> GetById([FromRoute] int id)
    {
        var outlet = await _outletRepo.GetOutletByIdAsync(id);
        if (outlet == null)
        {
            return NotFound();
        }
        return Ok(outlet.ToUserResponseDto());
    }
}