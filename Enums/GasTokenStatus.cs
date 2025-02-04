using System.Runtime.Serialization;

namespace backend.Enums;

public enum GasTokenStatus
{
    [EnumMember(Value = "Pending")]
    Pending = 1,
    [EnumMember(Value = "Assigned")]
    Assigned = 2,
    [EnumMember(Value = "Completed")]
    Completed = 3,
    [EnumMember(Value = "Canceled")]
    Cancelled = 4,
    
}