using Noodum.Wokamon.Sunny.Core.Algorithms;
using Noodum.Wokamon.Sunny.Core.Documents;
using Noodum.Wokamon.Sunny.Core.Models;
using System.Collections.Generic;
using System.IO;

namespace Noodum.Wokamon.Sunny.Learning.Preproduces
{
    public abstract class AccelerometerPreproduce : PreproduceBase
    {
        public AccelerometerPreproduce(ANNLogicType annLogic)
            : base(annLogic)
        {

        }

        protected override List<SensorDataDocument<ISensorData>> GetSensorDataDocument(int updateInterval, Core.Models.PhoneType phoneType, Core.Models.PhoneState phoneState)
        {
            var folderName = SensorDataDocumentType.GetFolderName(SensorType.Accelerometer, updateInterval, phoneType, phoneState);
            var files = Directory.EnumerateFiles(folderName);

            var result = new List<SensorDataDocument<ISensorData>>();
            foreach (var fileName in files)
            {
                result.Add(SensorDataDocumentType.Open<AccelerometerData>(fileName));
            }
            return result;
        }
    }
}
