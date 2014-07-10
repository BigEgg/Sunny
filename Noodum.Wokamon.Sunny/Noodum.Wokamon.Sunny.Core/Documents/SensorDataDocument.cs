using Noodum.Wokamon.Sunny.Core.Models;
using System.Collections.Generic;

namespace Noodum.Wokamon.Sunny.Core.Documents
{
    public class SensorDataDocument<T> where T : ISensorData
    {
        #region Fields
        private IList<T> data;
        #endregion

        /// <summary>
        /// Initializes a new instance of the <see cref="SensorDataDocument{T}"/> class.
        /// </summary>
        public SensorDataDocument()
        {
            this.data = new List<T>();
        }

        #region Properties
        /// <summary>
        /// Gets the data.
        /// </summary>
        /// <value>
        /// The data.
        /// </value>
        public IList<T> Data { get { return this.data; } }
        #endregion
    }
}
