using backend.Services;
using Microsoft.AspNetCore.Mvc;

namespace backend.Controllers;

[ApiController]
[Route("api/scheduler")]
public class SchedulerController: ControllerBase
{
    private readonly SchedulerService _schedulerService;

    public SchedulerController(SchedulerService schedulerService)
    {
        _schedulerService = schedulerService;
    }

    [HttpPost]
    [Route("run-now")]
    public async Task<IActionResult> RunNow()
    {
        await _schedulerService.RunNow();
        return Ok("Scheduler Started...");
    }
    
}