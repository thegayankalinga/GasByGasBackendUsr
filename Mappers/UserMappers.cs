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
}