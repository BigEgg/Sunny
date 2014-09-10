using System.Collections.Generic;

namespace Noodum.Wokamon.Sunny.Core.Models
{
    public class LearningData
    {
        private List<double> inputData;
        private List<double> outputData;

        public LearningData()
        {
            inputData = new List<double>();
            outputData = new List<double>();
        }

        public List<double> InputData { get { return this.inputData; } }

        public List<double> OutputData { get { return this.outputData; } }
    }
}
