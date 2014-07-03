using Noodum.Wokamon.Sunny.Core.Models;

namespace Noodum.Wokamon.Sunny.SensorDataCollector.Models
{
    public class PhoneData
    {
        public PhoneType PhoneType { get; set; }
        public PhoneStats PhoneStats { get; set; }
        public int UpdateInterval { get; set; }
    }
}