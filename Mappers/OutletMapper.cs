using backend.Dtos.Outlet;
using backend.Models;

namespace backend.Mappers;

public static class OutletMapper
{
    //Convert model to dto
    public static OutletResponseDto ToOutletResponseDtofromModel(this Outlet outletModel)
    {
        return new OutletResponseDto
        {
            Id = outletModel.Id,
            OutletName = outletModel.OutletName,
            OutletAddress = outletModel.OutletAddress,
            City = outletModel.City,
            Stock = outletModel.Stock
        };
    }
    
    //TODO: Convert dto to model
     public static Outlet ToOutletModelFromRequestDto(this NewOutletRequestDto newOutletRequestDto)
     {
         return new Outlet
         {
             OutletName = newOutletRequestDto.OutletName,
             OutletAddress = newOutletRequestDto.OutletAddress,
             City = newOutletRequestDto.City,
             Stock = newOutletRequestDto.Stock
         };
     }
}