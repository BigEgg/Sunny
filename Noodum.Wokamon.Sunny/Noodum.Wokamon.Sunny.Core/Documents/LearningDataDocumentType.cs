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
        /// <summary>
        /// Gets the file path.
        /// </summary>
        /// <param name="phoneType">Type of the phone.</param>
        /// <param name="algorithmType">Type of the algorithm.</param>
        /// <param name="annLogicType">Type of the ANN logic.</param>
        /// <returns>The file path.</returns>
        public static string GetFilePath(PhoneType phoneType, AlgorithmType algorithmType, ANNLogicType annLogicType)
        {
            return Path.Combine(
                fileRootPath,
                phoneType.ToString() + "_" + algorithmType.ToString() + "_" + annLogicType.ToString() + fileExtension);
        }

        /// <summary>
        /// Gets the file path.
        /// </summary>
        /// <param name="algorithmType">Type of the algorithm.</param>
        /// <param name="annLogicType">Type of the ANN logic.</param>
        /// <returns>The file path.</returns>
        public static string GetFilePath(AlgorithmType algorithmType, ANNLogicType annLogicType)
        {
            return Path.Combine(
                fileRootPath,
                algorithmType.ToString() + "_" + annLogicType.ToString() + fileExtension);
        }

        /// <summary>
        /// Create a new instance of <see cref="SensorDataDocument"/> class.
        /// </summary>
        /// <returns>New instance of <see cref="SensorDataDocument"/> class</returns>
        public static LearningDataDocument New()
        {
            return new LearningDataDocument();
        }

        /// <summary>
        /// Saves the specified document.
        /// </summary>
        /// <param name="document">The document.</param>
        /// <param name="phoneType">Type of the phone.</param>
        /// <param name="algorithmType">Type of the algorithm.</param>
        /// <param name="annLogicType">Type of the ANN logic.</param>
        public static void Save(LearningDataDocument document, PhoneType phoneType, AlgorithmType algorithmType, ANNLogicType annLogicType)
        {
            if (document == null) { throw new ArgumentNullException("document cannot be null."); }
            if (document.Data.Count == 0) { throw new ArgumentException("document's data cannot be empty."); }

            var filePath = GetFilePath(phoneType, algorithmType, annLogicType);
            SaveCore(document, filePath);
        }

        /// <summary>
        /// Saves the specified document.
        /// </summary>
        /// <param name="document">The document.</param>
        /// <param name="phoneType">Type of the phone.</param>
        /// <param name="algorithmType">Type of the algorithm.</param>
        /// <param name="annLogicType">Type of the ANN logic.</param>
        public static void Save(LearningDataDocument document, AlgorithmType algorithmType, ANNLogicType annLogicType)
        {
            if (document == null) { throw new ArgumentNullException("document cannot be null."); }
            if (document.Data.Count == 0) { throw new ArgumentException("document's data cannot be empty."); }

            var filePath = GetFilePath(algorithmType, annLogicType);
            SaveCore(document, filePath);
        }

        private static void SaveCore(LearningDataDocument document, string filePath)
        {
            if (!Directory.Exists(fileRootPath))
            {
                Directory.CreateDirectory(fileRootPath);
            }

            using (var fs = new FileStream(filePath, FileMode.CreateNew))
            {
                using (var sw = new StreamWriter(fs))
                {
                    sw.Write(document.Data.Count.ToString() + " ");
                    sw.Write(document.Data[0].InputData.Count.ToString() + " ");
                    sw.Write(document.Data[0].OutputData.Count.ToString() + Environment.NewLine);

                    foreach (var learningData in document.Data)
                    {
                        string inputSring = string.Join(", ", learningData.InputData);
                        sw.WriteLine(inputSring);
                        string outputString = string.Join(", ", learningData.OutputData);
                        sw.WriteLine(outputString);
                    }
                }
            }
        }
        #endregion
    }
}
