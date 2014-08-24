using Noodum.Wokamon.Sunny.Core.Algorithms;
using Noodum.Wokamon.Sunny.Core.Models;
using System;
using System.IO;

namespace Noodum.Wokamon.Sunny.Core.Documents
{
    public class LearningDataDocumentType
    {
        #region Fields
        private const string fileExtension = ".learning";
        private static string fileRootPath;
        #endregion

        /// <summary>
        /// Initializes the <see cref="SensorDataDocumentType"/> class.
        /// </summary>
        static LearningDataDocumentType()
        {
            fileRootPath = Path.Combine(
                Path.GetDirectoryName(AppDomain.CurrentDomain.BaseDirectory),
                "Learning");
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
        public static string GetFolderName(PhoneType phoneType, AlgorithmType algorithmType, ANNLogicType annLogicType)
        {
            return Path.Combine(
                fileRootPath,
                phoneType.ToString(),
                algorithmType.ToString(),
                annLogicType.ToString());
        }

        /// <summary>
        /// Create a new instance of <see cref="SensorDataDocument"/> class.
        /// </summary>
        /// <returns>New instance of <see cref="SensorDataDocument"/> class</returns>
        public static LearningDataDocument New()
        {
            return new LearningDataDocument();
        }

        public static LearningDataDocument Open(string filePaht)
        {
            throw new NotImplementedException();
        }

        public static void Save(LearningDataDocument document, AlgorithmType algorithmType, ANNLogicType annLogicType)
        {

        }
        #endregion
    }
}
