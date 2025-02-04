using System.Runtime.Serialization;

namespace backend.Enums;

public enum UserType
{
    [EnumMember(Value = "Personal")]
    Personal = 0,
    [EnumMember(Value = "Business")]
    Business = 1,
    [EnumMember(Value = "Industries")]
    Industries = 2,
    [EnumMember(Value = "Admin")]
    Admin = 3,
    [EnumMember(Value = "Manager")]
    Manager = 4,
}