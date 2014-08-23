using System.Data;
using System.Threading;
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
        /// Gets the name of the folder.
        /// </summary>
        /// <param name="sensorType">Type of the sensor.</param>
        /// <param name="updateInterval">The update interval.</param>
        /// <param name="phoneType">Type of the phone.</param>
        /// <param name="phoneStats">The phone stats.</param>
        /// <returns></returns>
        public static string GetFolderName(SensorType sensorType, int updateInterval, PhoneType phoneType, PhoneStatus phoneStats)
        {
            if ((phoneStats & PhoneStatus.Stop) == PhoneStatus.Stop)
            {
                phoneStats = PhoneStatus.Stop;
            }

            return Path.Combine(
                fileRootPath,
                sensorType.ToString(),
                updateInterval.ToString(),
                phoneType.ToString(),
                phoneStats.ToString());
        }

        /// <summary>
        /// News this instance.
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <returns></returns>
        public static SensorDataDocument<T> New<T>() where T : ISensorData
        {
            return new SensorDataDocument<T>();
        }

        public static SensorDataDocument<ISensorData> Open<T>(String filePath) where T : ISensorData
        {
            SensorType sensorType;
            if (typeof(T) == typeof(GyrosensorData)) { sensorType = SensorType.Gyrosensor; }
            else if (typeof(T) == typeof(AccelerometerData)) { sensorType = SensorType.Accelerometer; }
            else { throw new NotSupportedException("Unknown sensor type."); }

            if (!filePath.Contains(sensorType.ToString())) { throw new NotSupportedException("filePath not valid."); }

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
                            document.Data.Add(new GyrosensorData(data));
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
        /// <param name="phoneStats">The phone stats.</param>
        public static void Save<T>(SensorDataDocument<T> document, int updateInterval, PhoneType phoneType, PhoneStatus phoneStats)
            where T : ISensorData
        {
            SensorType sensorType;
            if (typeof(T) == typeof(GyrosensorData)) { sensorType = SensorType.Gyrosensor; }
            else if (typeof(T) == typeof(AccelerometerData)) { sensorType = SensorType.Accelerometer; }
            else { throw new NotSupportedException("Unknown sensor type."); }

            var folderName = GetFolderName(sensorType, updateInterval, phoneType, phoneStats);
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
