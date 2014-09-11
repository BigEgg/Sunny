using Noodum.Wokamon.Sunny.Core.Algorithms;
using Noodum.Wokamon.Sunny.Core.Documents;
using Noodum.Wokamon.Sunny.Core.Models;
using System.Collections.Generic;

namespace Noodum.Wokamon.Sunny.Learning.Preproduces
{
    public abstract class PreproduceBase
    {
        private ANNLogicType annLogic;

        public PreproduceBase(ANNLogicType annLogic)
        {
            this.annLogic = annLogic;
        }

        public ANNLogicType ANNLogic
        {
            get { return annLogic; }
        }


        public abstract void Preproduce();

        protected abstract List<LearningData> Calclulate(List<SensorDataDocument<ISensorData>> sensorData);

        protected abstract List<SensorDataDocument<ISensorData>> GetSensorDataDocument(int updateInterval, PhoneType phoneType, PhoneState phoneState);
    }
}
