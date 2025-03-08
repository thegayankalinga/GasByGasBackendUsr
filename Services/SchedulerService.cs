using backend.Interfaces;

namespace backend.Services;

public class SchedulerService: BackgroundService
{
    private readonly IServiceProvider _serviceProvider;
    private ILogger<SchedulerService> _logger;

    public SchedulerService(IServiceProvider serviceProvider, ILogger<SchedulerService> logger)
    {
        _serviceProvider = serviceProvider;
        _logger = logger;
    }

    protected override async Task ExecuteAsync(CancellationToken stoppingToken)
    {
        _logger.LogInformation("Scheduler Service is starting.");
        while (!stoppingToken.IsCancellationRequested)
        {
            try
            {
                await SendDeliveryReminderEmails();
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Scheduler Service is starting.");
            }
        }
    }

    private async Task SendDeliveryReminderEmails()
    {
        using (var scope = _serviceProvider.CreateScope())
        {
            var gasTokenRepo = scope.ServiceProvider.GetRequiredService<IGasTokenRepository>();
            var mailService = scope.ServiceProvider.GetRequiredService<IMailService>();
            var deliveryRepo = scope.ServiceProvider.GetRequiredService<IDeliveryRepository>();
            
            
            var tomorrow = DateTime.Now.AddDays(1);
            var confirmedDeliveries = await deliveryRepo.GetConfirmedDeliveriesForDate(tomorrow);
            
            
            foreach (var delivery in confirmedDeliveries)
            {
                var gasTokens = await gasTokenRepo.GetGasTokensByDeliveryScheduleIdAsync(delivery.Id);
                var emailAddresses = gasTokens.Select(g => g.UserEmail).Distinct().ToList();

                foreach (var email in emailAddresses)
                {
                    string subject = "Upcoming Gas Delivery Reminder";
                    string body = $"Your scheduled gas delivery is on {delivery.DeliveryDate:dddd, MMMM d, yyyy}. " +
                                  $"Please visit the outlet with your empty cylinder and money.";

                    await mailService.SendEmailAsync(email, "User Name", subject, body);
                    _logger.LogInformation($"Sent delivery reminder email to {email} for DeliveryScheduleId {delivery.Id}.");
                }
            }
        }
    }
    
    
    

}