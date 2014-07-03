namespace Noodum.Wokamon.Sunny.Core.Models
{
    public class AccelerometerData : ISensorData
    {
        public float X { get; set; }
        public float Y { get; set; }
        public float Z { get; set; }


        public override string ToString()
        {
            return string.Format("%s, %s, %s", X, Y, Z);
        }
    }
}