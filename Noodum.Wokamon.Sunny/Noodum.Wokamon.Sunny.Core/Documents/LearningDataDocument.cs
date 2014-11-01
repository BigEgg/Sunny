using Noodum.Wokamon.Sunny.Core.Models;
using System.Collections.Generic;

namespace Noodum.Wokamon.Sunny.Core.Documents
{
    public class LearningDataDocument
    {
        private List<LearningData> data;

        public LearningDataDocument()
        {
            data = new List<LearningData>();
        }

        public List<LearningData> Data { get { return data; } }
    }
}
