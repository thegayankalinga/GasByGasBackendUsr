using backend.Dtos.Outlet;
using backend.Models;

namespace backend.Mappers;

public static class OutletMapper
{
    //Convert model to dto
    public static OutletResponseDto ToUserResponseDto(this Outlet outletModel)
    {
        return new OutletResponseDto
        {
            Id = outletModel.Id,
            OutletName = outletModel.OutletName,
            OutletAddress = outletModel.OutletAddress,
            City = outletModel.City
        };
    }
    
    //TODO: Convert dto to model
    // public static Outlet ToOutletFromRequestDto(this NewOutletRequestDto newOutletRequestDto)
    // {
    //     return new Outlet
    //     {
    //         
    //     }
    // }
}