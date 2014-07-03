using Noodum.Wokamon.Sunny.Core.Models;
using System.Collections.Generic;

namespace Noodum.Wokamon.Sunny.Core.Documents
{
    public class SensorDataDocument<T> where T : ISensorData
    {
        #region Fields
        private IList<T> data;
        #endregion

        public SensorDataDocument()
        {
            this.data = new List<T>();
        }

        #region Properties
        public IList<T> Data { get { return this.data; } }
        #endregion
    }
}
