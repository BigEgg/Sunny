using System;
using System.IO;
using System.Linq;

namespace Noodum.Wokamon.Sunny.Core.Models
{
    public class AccelerometerData : ISensorData
    {
        public AccelerometerData()
        { }

        public AccelerometerData(String dataString)
        {
            if (string.IsNullOrEmpty(dataString)) { throw new ArgumentException("data cannot be null or empty."); }

            String[] data = dataString.Split(new[] { ", " }, StringSplitOptions.RemoveEmptyEntries);
            if (data.Count() != 3) { throw new InvalidDataException("data don't have 3 value."); }

            X = float.Parse(data[0]);
            Y = float.Parse(data[1]);
            Z = float.Parse(data[2]);
        }

        public float X { get; set; }
        public float Y { get; set; }
        public float Z { get; set; }


        public override string ToString()
        {
            return string.Format("{0}, {1}, {2}", X, Y, Z);
        }
    }
}