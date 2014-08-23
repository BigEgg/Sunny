using System;
using System.Collections.Generic;
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


    }
}
