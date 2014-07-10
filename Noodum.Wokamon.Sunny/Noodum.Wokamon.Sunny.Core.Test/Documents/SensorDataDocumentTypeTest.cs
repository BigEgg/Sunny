using Microsoft.VisualStudio.TestTools.UnitTesting;
using Noodum.Wokamon.Sunny.Core.Documents;
using Noodum.Wokamon.Sunny.Core.Models;
using System;
using System.IO;

namespace Noodum.Wokamon.Sunny.Core.Test.Documents
{
    [TestClass]
    public class SensorDataDocumentTypeTest
    {
        [TestMethod]
        public void GeneralTest()
        {
            Assert.IsNotNull(SensorDataDocumentType.FileRootPath);
            Assert.IsFalse(String.IsNullOrWhiteSpace(SensorDataDocumentType.FileRootPath));
            Assert.IsTrue(Path.IsPathRooted(SensorDataDocumentType.FileRootPath));
        }

        [TestMethod]
        public void NewTest_Gyrosensor()
        {
            var document = SensorDataDocumentType.New<GyrosensorData>();
            Assert.IsNotNull(document);
        }

        [TestMethod]
        public void NewTest_Accelerometer()
        {
            var document = SensorDataDocumentType.New<AccelerometerData>();
            Assert.IsNotNull(document);
        }
    }
}
