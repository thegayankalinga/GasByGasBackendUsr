using backend.Interfaces;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using System;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;

namespace backend.Services
{
    public class SchedulerService : BackgroundService
    {
        private readonly IServiceProvider _serviceProvider;
        private readonly ILogger<SchedulerService> _logger;
        private readonly TimeSpan _executionTime = TimeSpan.FromHours(6); // Runs at 6 AM UTC daily

        public SchedulerService(IServiceProvider serviceProvider, ILogger<SchedulerService> logger)
        {
            _serviceProvider = serviceProvider;
            _logger = logger;
        }

        protected override async Task ExecuteAsync(CancellationToken stoppingToken)
        {
            _logger.LogInformation("Scheduler Service is starting...");

            while (!stoppingToken.IsCancellationRequested)
            {
                try
                {
                    DateTime now = DateTime.UtcNow;
                    DateTime nextRunTime = now.Date.Add(_executionTime);

                    if (now >= nextRunTime)
                    {
                        nextRunTime = nextRunTime.AddDays(1);
                    }

                    TimeSpan delay = nextRunTime - now;
                    _logger.LogInformation($"Next scheduled execution at: {nextRunTime} UTC.");

                    await Task.Delay(delay, stoppingToken);

                    await SendDeliveryReminderEmails();
                }
                catch (TaskCanceledException)
                {
                    _logger.LogInformation("Scheduler Service is stopping...");
                    break;
                }
                catch (Exception ex)
                {
                    _logger.LogError(ex, "Error occurred while executing the scheduler.");
                }
            }
        }

        public async Task RunNow()
        {
            _logger.LogInformation("Manually triggering email reminders...");
            await SendDeliveryReminderEmails();
        }

        private async Task SendDeliveryReminderEmails()
        {
            using (var scope = _serviceProvider.CreateScope())
            {
                var gasTokenRepo = scope.ServiceProvider.GetRequiredService<IGasTokenRepository>();
                var mailService = scope.ServiceProvider.GetRequiredService<IMailService>();
                var deliveryRepo = scope.ServiceProvider.GetRequiredService<IDeliveryRepository>();

                var tomorrow = DateOnly.FromDateTime(DateTime.UtcNow.AddDays(1));
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

                _logger.LogInformation("All scheduled emails have been sent.");
            }
        }
    }
}