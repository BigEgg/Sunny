using Noodum.Wokamon.Sunny.Core.Models;

namespace Noodum.Wokamon.Sunny.Core.Documents
{
    public class ANNDocumentHelper
    {
        public string GetFileName(SensorType sensorType, int updateInterval, PhoneType phoneType, ANNLogicType annLogicType)
        {
            return string.Format(sensorType.ToString(), "_", updateInterval.ToString(), "_", phoneType.ToString(), "_", annLogicType.ToString());
        }

        public string GetFileName(SensorType sensorType, int updateInterval, ANNLogicType annLogicType)
        {
            return string.Format(sensorType.ToString(), "_", updateInterval.ToString(), "_", annLogicType.ToString());
        }
    }
}
