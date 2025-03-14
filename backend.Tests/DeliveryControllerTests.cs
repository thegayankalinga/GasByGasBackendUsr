using backend.Controllers;
using backend.Dtos.DeliverySchedule;
using backend.Interfaces;
using backend.Models;
using Microsoft.AspNetCore.Mvc;
using Moq;
using System.Collections.Generic;
using System.Threading.Tasks;
using Xunit;

namespace backend.backend.Tests;



public class DeliveryControllerTests
{
    private readonly Mock<IDeliveryRepository> _deliveryRepositoryMock;
    private readonly Mock<IOutletRepository> _outletRepositoryMock;
    private readonly DeliveryController _deliveryController;
    
    
    


    public DeliveryControllerTests()
    {
        _deliveryRepositoryMock = new Mock<IDeliveryRepository>();
        _outletRepositoryMock = new Mock<IOutletRepository>();
        _deliveryController = new DeliveryController(_deliveryRepositoryMock.Object, _outletRepositoryMock.Object);
    }
    
    [Fact]
        public async Task Create_ShouldReturnCreatedResponse_WhenValidRequest()
        {
            // Arrange
            var request = new DeliveryRequestDto 
            { 
                OutletId = 1, 
                NoOfUnitsInDelivery = 10, 
                ConfirmedByAdmin = true, 
                DeliveryDate = DateOnly.FromDateTime(DateTime.UtcNow),
                DispatcherVehicleId = "abc0fff" 
            };
            var deliveryModel = new DeliverySchedule 
            { 
                Id = 1, 
                OutletId = 1, 
                NoOfUnitsInDelivery = 10, 
                ConfirmedByAdmin = true, 
                DeliveryDate = DateOnly.FromDateTime(DateTime.UtcNow),
                DispatcherVehicleId = "bdfdfs"
            };

            _outletRepositoryMock.Setup(x => x.OutletExists(request.OutletId)).ReturnsAsync(true);
            _deliveryRepositoryMock.Setup(x => x.CreateAsync(It.IsAny<DeliverySchedule>())).ReturnsAsync(deliveryModel);

            // Act
            var result = await _deliveryController.Create(request);

            // Assert
            var createdAtActionResult = Assert.IsType<CreatedAtActionResult>(result);
            Assert.Equal(201, createdAtActionResult.StatusCode);
        }

        [Fact]
        public async Task GetById_ShouldReturnNotFound_WhenDeliveryNotExists()
        {
            // Arrange
            _deliveryRepositoryMock.Setup(x => x.GetById(It.IsAny<int>())).ReturnsAsync((DeliverySchedule)null);
            
            // Act
            var result = await _deliveryController.GetById(1);

            // Assert
            var notFoundResult = Assert.IsType<NotFoundResult>(result);
            Assert.Equal(404, notFoundResult.StatusCode);
        }

        [Fact]
        public async Task GetAll_ShouldReturnListOfDeliveries()
        {
            // Arrange
            var deliveries = new List<DeliverySchedule> { new DeliverySchedule
                {
                    Id = 1,
                    OutletId = 1,
                    DeliveryDate =  DateOnly.FromDateTime(DateTime.UtcNow),
                    ConfirmedByAdmin = false,
                    NoOfUnitsInDelivery = 0,
                    DispatcherVehicleId = "abctest3434"
                }
            };
            _deliveryRepositoryMock.Setup(x => x.GetAllAsync()).ReturnsAsync(deliveries);
            
            // Act
            var result = await _deliveryController.GetAll();

            // Assert
            var okResult = Assert.IsType<OkObjectResult>(result);
            var returnValue = Assert.IsType<List<DeliverySchedule>>(okResult.Value);
            Assert.Single(returnValue);
        }

        [Fact]
        public async Task Delete_ShouldReturnOk_WhenDeliveryExists()
        {
            // Arrange
            _deliveryRepositoryMock.Setup(x => x.GetById(It.IsAny<int>())).ReturnsAsync(new DeliverySchedule
            {
                Id = 1,
                DeliveryDate = DateOnly.FromDateTime(DateTime.UtcNow),
                ConfirmedByAdmin = false,
                NoOfUnitsInDelivery = 0,
                OutletId = 0,
                DispatcherVehicleId = "db33"
            });
            _deliveryRepositoryMock.Setup(x => x.DeleteAsync(It.IsAny<int>())).ReturnsAsync(true);

            // Act
            var result = await _deliveryController.Delete(1);

            // Assert
            var okResult = Assert.IsType<OkObjectResult>(result);
            Assert.Equal(200, okResult.StatusCode);
        }
}