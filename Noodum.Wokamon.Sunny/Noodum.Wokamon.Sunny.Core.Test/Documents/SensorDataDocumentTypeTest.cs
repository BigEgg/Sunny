using Microsoft.VisualStudio.TestTools.UnitTesting;
using Noodum.Wokamon.Sunny.Core.Documents;
using Noodum.Wokamon.Sunny.Core.Models;
using System;
using System.IO;
using System.Linq;

namespace Noodum.Wokamon.Sunny.Core.Test.Documents
{
    [TestClass]
    public class SensorDataDocumentTypeTest
    {
        private void TestCleanup(SensorType sensorType)
        {
            if (sensorType == SensorType.Gyroscope)
            {
                if (Directory.Exists(Path.Combine(SensorDataDocumentType.FileRootPath, SensorType.Gyroscope.ToString())))
                {
                    Directory.Delete(Path.Combine(SensorDataDocumentType.FileRootPath, SensorType.Gyroscope.ToString()), true);
                }
            }
            else if (sensorType == SensorType.Accelerometer)
            {
                if (Directory.Exists(Path.Combine(SensorDataDocumentType.FileRootPath, SensorType.Accelerometer.ToString())))
                {
                    Directory.Delete(Path.Combine(SensorDataDocumentType.FileRootPath, SensorType.Accelerometer.ToString()), true);
                }
            }
        }


        [TestMethod]
        public void GeneralTest()
        {
            Assert.IsNotNull(SensorDataDocumentType.FileRootPath);
            Assert.IsFalse(String.IsNullOrWhiteSpace(SensorDataDocumentType.FileRootPath));
            Assert.IsTrue(Path.IsPathRooted(SensorDataDocumentType.FileRootPath));
        }

        [TestMethod]
        public void GetFolderNameTest_Stop()
        {
            var phoneState = PhoneState.Handheld | PhoneState.Left | PhoneState.Stop;
            var folderName = SensorDataDocumentType.GetFolderName(SensorType.Accelerometer, 20, PhoneType.iPhone4, phoneState);
            var expected = Path.Combine(SensorDataDocumentType.FileRootPath, "Accelerometer", "20", "iPhone4", PhoneState.Stop.ToString());

            Assert.AreEqual(expected, folderName);

        }

        [TestMethod]
        public void GetFolderNameTest_General()
        {
            var phoneState = PhoneState.Handheld | PhoneState.Left | PhoneState.Walk;
            var folderName = SensorDataDocumentType.GetFolderName(SensorType.Accelerometer, 20, PhoneType.iPhone4, phoneState);
            var expected = Path.Combine(SensorDataDocumentType.FileRootPath, "Accelerometer", "20", "iPhone4", phoneState.ToString());

            Assert.AreEqual(expected, folderName);
        }

        [TestMethod]
        public void NewTest_Gyrosensor()
        {
            var document = SensorDataDocumentType.New<GyroscopeData>();
            Assert.IsNotNull(document);
        }

        [TestMethod]
        public void NewTest_Accelerometer()
        {
            var document = SensorDataDocumentType.New<AccelerometerData>();
            Assert.IsNotNull(document);
        }

        [TestMethod]
        public void SaveTest_Accelerometer()
        {
            TestCleanup(SensorType.Accelerometer);
            var phoneState = PhoneState.Handheld | PhoneState.Left | PhoneState.Walk;

            var document = SensorDataDocumentType.New<AccelerometerData>();
            SensorDataDocumentType.Save(document, 20, PhoneType.iPhone4, phoneState);

            var folder = SensorDataDocumentType.GetFolderName(SensorType.Accelerometer, 20, PhoneType.iPhone4, phoneState);
            Assert.IsTrue(Directory.Exists(folder));

            var files = Directory.EnumerateFiles(folder);
            Assert.AreEqual(1, files.Count());
        }

        [TestMethod]
        public void SaveTest_Gyrosensor()
        {
            TestCleanup(SensorType.Gyroscope);
            var phoneState = PhoneState.Handheld | PhoneState.Left | PhoneState.Walk;

            var document = SensorDataDocumentType.New<GyroscopeData>();
            SensorDataDocumentType.Save(document, 20, PhoneType.iPhone4, phoneState);

            var folder = SensorDataDocumentType.GetFolderName(SensorType.Accelerometer, 20, PhoneType.iPhone4, phoneState);
            Assert.IsTrue(Directory.Exists(folder));

            var files = Directory.EnumerateFiles(folder);
            Assert.AreEqual(1, files.Count());
        }
    }
}
