using System.ComponentModel.DataAnnotations;
using backend.Enums;
using Microsoft.EntityFrameworkCore;

namespace backend.Models;

public class GasToken
{
    [Key]
    public int Id { get; set; }
    
    [DataType(DataType.Date)]
    public required DateOnly RequestDate { get; set; } = DateOnly.FromDateTime(DateTime.Now);
    
    [DataType(DataType.Date)]
    public DateOnly? ReadyDate { get; set; }
    
    [DataType(DataType.Date)]
    public required DateOnly ExpectedPickupDate { get; set; }

    public required GasTokenStatus Status { get; set; } = GasTokenStatus.Pending;
    
    public required UserType UserType { get; set; }
    
    //TODO: This functions should be a Outlet Manager to update
    public bool IsEmpltyCylindersGivent { get; set; } = false;
    
    //TODO: Keep a Gas Prices as a constant for now. when the delivery is assigned price needs to be added 
    [Precision(18,2)]
    public decimal? Price { get; set; }
    
    //TODO: add a API to update the payment status. 
    public bool IsPaid { get; set; } = false;
    
    public DateOnly? PaymentDate { get; set; }
    
    [MaxLength(200)]
    public required string UserEmail { get; set; }
    
    public required int OutletId { get; set; }
    
    public int? DeliveryScheduleId { get; set; }
    
    //TODO: This date cannot be more than request date + 2 weeks
    //TODO: one user can only take 3 request on pending status
    //TODO: If there are no stocks or planned delivery based stock availability block the user from creating a token
}