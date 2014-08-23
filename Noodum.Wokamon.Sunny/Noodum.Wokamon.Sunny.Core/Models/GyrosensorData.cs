using System;
using System.IO;
using System.Linq;

namespace Noodum.Wokamon.Sunny.Core.Models
{
    public class GyrosensorData : ISensorData
    {
        public GyrosensorData()
        { }

        public GyrosensorData(String dataString)
        {
            if (string.IsNullOrEmpty(dataString)) { throw new ArgumentException("data cannot be null or empty."); }

            String[] data = dataString.Split(new[] { ", " }, StringSplitOptions.RemoveEmptyEntries);
            if (data.Count() != 3) { throw new InvalidDataException("data don't have 3 value."); }

            DeltaX = float.Parse(data[0]);
            DeltaY = float.Parse(data[1]);
            DeltaZ = float.Parse(data[2]);
        }

        public float DeltaX { get; set; }
        public float DeltaY { get; set; }
        public float DeltaZ { get; set; }

        public override string ToString()
        {
            return string.Format("{0}, {1}, {2}", DeltaX, DeltaY, DeltaZ);
        }
    }
}
