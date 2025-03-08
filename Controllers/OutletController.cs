using backend.Dtos.Outlet;
using backend.Interfaces;
using backend.Mappers;
using Microsoft.AspNetCore.Authorization;
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
    
    // [Authorize]
    [HttpGet]
    public async Task<ActionResult<IEnumerable<OutletResponseDto>>> GetAll()
    {
        var outlets = await _outletRepo.GetAllOutletsAsync();
        var outletDtos = outlets.Select(o => o.ToOutletResponseDtofromModel());
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
        return Ok(outlet.ToOutletResponseDtofromModel());
    }

    [HttpPost]
    public async Task<ActionResult> CreateOutlet([FromBody] NewOutletRequestDto createOutletDto)
    {
        if(!ModelState.IsValid) return BadRequest(ModelState);
        
        var outletModel = createOutletDto.ToOutletModelFromRequestDto();
        await _outletRepo.CreateOutletAsync(outletModel);
        return CreatedAtAction(nameof(GetById), new { id = outletModel.Id },
            outletModel.ToOutletResponseDtofromModel());
    }

}