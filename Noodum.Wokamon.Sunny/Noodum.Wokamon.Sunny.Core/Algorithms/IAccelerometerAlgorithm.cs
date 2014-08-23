
using Noodum.Wokamon.Sunny.Core.Models;

namespace Noodum.Wokamon.Sunny.Core.Algorithms
{
    public interface IAccelerometerAlgorithm : IAlgorithm
    {
        double Calculate(AccelerometerData oldData, AccelerometerData newData);
    }
}
