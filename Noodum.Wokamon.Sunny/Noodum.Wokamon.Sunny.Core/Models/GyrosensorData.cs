namespace Noodum.Wokamon.Sunny.Core.Models
{
    public class GyrosensorData : ISensorData
    {
        public float DeltaX { get; set; }
        public float DeltaY { get; set; }
        public float DeltaZ { get; set; }

        public override string ToString()
        {
            return string.Format("{0}, {1}, {2}", DeltaX, DeltaY, DeltaZ);
        }
    }
}
