using Noodum.Wokamon.Sunny.Core.Models;
using System;

namespace Noodum.Wokamon.Sunny.Core.Algorithms
{
    public class COSAlgorithm : IAccelerometerAlgorithm
    {
        public double Calculate(AccelerometerData oldData, AccelerometerData newData)
        {
            if (oldData == null) { throw new ArgumentNullException("oldData cannot be null."); }
            if (newData == null) { throw new ArgumentNullException("newData cannot be null."); }

            double length1 = Math.Sqrt(oldData.X * oldData.X + oldData.Y * oldData.Y + oldData.Z * oldData.Z);
            double length2 = Math.Sqrt(newData.X * newData.X + newData.Y * newData.Y + newData.Z * newData.Z);

            return (oldData.X * newData.X + oldData.Y * newData.Y + oldData.Z * newData.Z) / (length1 * length2);
        }
    }
}
