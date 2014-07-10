using Noodum.Wokamon.Sunny.Core.Models;

namespace Noodum.Wokamon.Sunny.Core.Documents
{
    public class ANNDocumentHelper
    {
        /// <summary>
        /// Gets the name of the file.
        /// </summary>
        /// <param name="sensorType">Type of the sensor.</param>
        /// <param name="updateInterval">The update interval.</param>
        /// <param name="phoneType">Type of the phone.</param>
        /// <param name="annLogicType">Type of the ANN logic.</param>
        /// <returns></returns>
        public string GetFileName(SensorType sensorType, int updateInterval, PhoneType phoneType, ANNLogicType annLogicType)
        {
            return string.Format(sensorType.ToString(), "_", updateInterval.ToString(), "_", phoneType.ToString(), "_", annLogicType.ToString());
        }

        /// <summary>
        /// Gets the name of the file.
        /// </summary>
        /// <param name="sensorType">Type of the sensor.</param>
        /// <param name="updateInterval">The update interval.</param>
        /// <param name="annLogicType">Type of the ANN logic.</param>
        /// <returns></returns>
        public string GetFileName(SensorType sensorType, int updateInterval, ANNLogicType annLogicType)
        {
            return string.Format(sensorType.ToString(), "_", updateInterval.ToString(), "_", annLogicType.ToString());
        }
    }
}
