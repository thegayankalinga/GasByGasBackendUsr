using backend.Dtos.Account;
using backend.Models;

namespace backend.Mappers;

public static class UserMappers
{
    //Convert Users to DTO
    public static ManagerReponseDto ToManagerReponseDto(this AppUser userModel)
    {
        return new ManagerReponseDto
        {
            Email = userModel.Email,
            FullName = userModel.FullName,
            IsConfirm = userModel.IsConfirm,
            ConsumerType = userModel.ConsumerType,
            OutletId = userModel.OutletId,
        };
    }

    public static ConsumerResponseDto ToConsumerResponseDto(this AppUser userModel)
    {
        return new ConsumerResponseDto
        {
            Email = userModel.Email,
            FullName = userModel.FullName,
            NIC = userModel.Nic,
            BusinessRegistration = userModel.BusinessRegistration,
            IsConfirm = userModel.IsConfirm,
            PhoneNumber = userModel.PhoneNumber,
            Address = userModel.Address,
            City = userModel.City,
            UserType = userModel.ConsumerType,
            NoOfCylindersAllowed = userModel.NoOfCylindersAllowed,
            RemainingCylindersAllowed = userModel.RemainingCylindersAllowed
        };
    }
}