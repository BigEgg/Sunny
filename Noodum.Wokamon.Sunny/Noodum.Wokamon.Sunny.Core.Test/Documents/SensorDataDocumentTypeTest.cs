using Microsoft.VisualStudio.TestTools.UnitTesting;
using Noodum.Wokamon.Sunny.Core.Documents;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Noodum.Wokamon.Sunny.Core.Test.Documents
{
    [TestClass]
    public class SensorDataDocumentTypeTest
    {
        [TestMethod]
        public void GeneralTest()
        {
            Assert.IsNotNull(SensorDataDocumentType.FileRootPath);
            Assert.IsTrue(String.IsNullOrWhiteSpace(SensorDataDocumentType.FileRootPath));
            Assert.IsTrue(Path.IsPathRooted(SensorDataDocumentType.FileRootPath));
        }


    }
}
