using Noodum.Wokamon.Sunny.Core.Models;
using System;
using System.IO;

namespace Noodum.Wokamon.Sunny.Core.Documents
{
    public class SensorDataDocumentType
    {
        #region Fields
        private const string fileExtension = ".rawdata";
        private static string fileRootPath;
        #endregion

        /// <summary>
        /// Initializes the <see cref="SensorDataDocumentType"/> class.
        /// </summary>
        static SensorDataDocumentType()
        {
            fileRootPath = Path.Combine(
                Path.GetDirectoryName(AppDomain.CurrentDomain.BaseDirectory),
                "RawData");
        }

        #region Properties
        /// <summary>
        /// Gets the file root path.
        /// </summary>
        /// <value>
        /// The file root path.
        /// </value>
        public static string FileRootPath { get { return fileRootPath; } }
        #endregion

        #region Methods
        /// <summary>
        /// Gets the folder name by specific types.
        /// </summary>
        /// <param name="sensorType">Type of the sensor.</param>
        /// <param name="updateInterval">The update interval.</param>
        /// <param name="phoneType">Type of the phone.</param>
        /// <param name="phoneState">The phone stats.</param>
        /// <returns></returns>
        public static string GetFolderName(SensorType sensorType, int updateInterval, PhoneType phoneType, PhoneState phoneState)
        {
            if ((phoneState & PhoneState.Stop) == PhoneState.Stop)
            {
                phoneState = PhoneState.Stop;
            }

            return Path.Combine(
                fileRootPath,
                sensorType.ToString(),
                updateInterval.ToString(),
                phoneType.ToString(),
                phoneState.ToString());
        }

        /// <summary>
        /// Create a new instance of <see cref="SensorDataDocument<T>"/> class.
        /// </summary>
        /// <typeparam name="T">The Sensor data type.</typeparam>
        /// <returns>New instance of <see cref="SensorDataDocument<t>"/> class</returns>
        public static SensorDataDocument<T> New<T>() where T : ISensorData
        {
            return new SensorDataDocument<T>();
        }

        /// <summary>
        /// Opens the Sensor Data document via file path.
        /// </summary>
        /// <typeparam name="T">The Sensor data type.</typeparam>
        /// <param name="filePath">The file path.</param>
        /// <returns>The Sensor Data document.</returns>
        /// <exception cref="System.NotSupportedException">
        /// Unknown sensor type.
        /// or
        /// filePath not valid.
        /// </exception>
        /// <exception cref="System.IO.FileNotFoundException"></exception>
        public static SensorDataDocument<ISensorData> Open<T>(String filePath) where T : ISensorData
        {
            SensorType sensorType;
            if (typeof(T) == typeof(GyroscopeData)) { sensorType = SensorType.Gyroscope; }
            else if (typeof(T) == typeof(AccelerometerData)) { sensorType = SensorType.Accelerometer; }
            else { throw new NotSupportedException("Unknown sensor type."); }

            if (!filePath.Contains(sensorType.ToString())) { throw new NotSupportedException("filePath not valid."); }
            if (!File.Exists(filePath)) { throw new FileNotFoundException(string.Format("file cannot be found by path: {0}", fileExtension)); }

            var document = new SensorDataDocument<ISensorData>();
            using (var fs = new FileStream(filePath, FileMode.Open, FileAccess.Read))
            {
                using (var sr = new StreamReader(fs))
                {
                    string data = String.Empty;
                    while (!string.IsNullOrEmpty(data = sr.ReadLine()))
                    {
                        if (sensorType == SensorType.Accelerometer)
                        {
                            document.Data.Add(new AccelerometerData(data));
                        }
                        else
                        {
                            document.Data.Add(new GyroscopeData(data));
                        }
                    }
                }
            }
            return document;
        }

        /// <summary>
        /// Saves the specified document.
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="document">The document.</param>
        /// <param name="updateInterval">The update interval.</param>
        /// <param name="phoneType">Type of the phone.</param>
        /// <param name="phoneState">The phone stats.</param>
        /// <exception cref="System.NotSupportedException">Unknown sensor type.</exception>
        public static void Save<T>(SensorDataDocument<T> document, int updateInterval, PhoneType phoneType, PhoneState phoneState)
            where T : ISensorData
        {
            SensorType sensorType;
            if (typeof(T) == typeof(GyroscopeData)) { sensorType = SensorType.Gyroscope; }
            else if (typeof(T) == typeof(AccelerometerData)) { sensorType = SensorType.Accelerometer; }
            else { throw new NotSupportedException("Unknown sensor type."); }

            var folderName = GetFolderName(sensorType, updateInterval, phoneType, phoneState);
            if (!Directory.Exists(folderName))
            {
                Directory.CreateDirectory(folderName);
            }

            using (var fs = new FileStream(
                Path.Combine(folderName, DateTime.Now.ToString("yyyyMMdd-HHmmss") + fileExtension),
                FileMode.Append,
                FileAccess.Write))
            {
                using (var sw = new StreamWriter(fs))
                {
                    foreach (var entry in document.Data)
                    {
                        sw.WriteLine(entry.ToString());
                    }
                }
            }
        }
        #endregion
    }
}
