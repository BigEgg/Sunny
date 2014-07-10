using Noodum.Wokamon.Sunny.Core.Models;
using System;
using System.IO;
using System.Reflection;

namespace Noodum.Wokamon.Sunny.Core.Documents
{
    public class SensorDataDocumentType
    {
        #region Fields
        private const string fileExtension = ".rawdata";
        private static string fileRootPath;
        #endregion

        static SensorDataDocumentType()
        {
            fileRootPath = Path.Combine(
                Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location),
                "RawData");
        }

        #region Properties
        public static string FileRootPath { get { return fileRootPath; } }
        #endregion

        #region Methods
        public static string GetFolderName(SensorType sensorType, int updateInterval, PhoneType phoneType, PhoneStats phoneStats)
        {
            return Path.Combine(
                fileRootPath,
                sensorType.ToString(),
                updateInterval.ToString(),
                phoneType.ToString(),
                phoneStats.ToString());
        }

        public static SensorDataDocument<T> New<T>() where T : ISensorData
        {
            return new SensorDataDocument<T>();
        }

        public static void Save<T>(SensorDataDocument<T> document, SensorType sensorType, int updateInterval, PhoneType phoneType, PhoneStats phoneStats)
            where T : ISensorData
        {
            using (var fs = new FileStream(
                Path.Combine(GetFolderName(sensorType, updateInterval, phoneType, phoneStats),
                             DateTime.Now.ToString("yyyyMMDD") + fileExtension),
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
