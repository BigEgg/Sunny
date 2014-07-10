using Noodum.Wokamon.Sunny.Core.Models;
using System.Collections.Generic;

namespace Noodum.Wokamon.Sunny.SensorDataCollector.Models
{
    public class DataPackage<T> where T : ISensorData
    {
        public PhoneData PhoneData { get; set; }
        public IList<T> Data { get; set; }
    }
}