using System.Collections.Generic;

namespace Noodum.Wokamon.Sunny.Core.Models
{
    public class LearningData
    {
        private List<int> inputData;
        private List<int> outputData;

        public LearningData()
        {
            inputData = new List<int>();
            outputData = new List<int>();
        }

        public List<int> InputData { get { return this.inputData; } }

        public List<int> OutputData { get { return this.outputData; } }
    }
}
