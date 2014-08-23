﻿using Microsoft.VisualStudio.TestTools.UnitTesting;
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
            var phoneStatus = PhoneStatus.Handheld | PhoneStatus.Left | PhoneStatus.Stop;
            var folderName = SensorDataDocumentType.GetFolderName(SensorType.Accelerometer, 20, PhoneType.iPhone4, phoneStatus);
            var expected = Path.Combine(SensorDataDocumentType.FileRootPath, "Accelerometer", "20", "iPhone4", PhoneStatus.Stop.ToString());

            Assert.AreEqual(expected, folderName);

        }

        [TestMethod]
        public void GetFolderNameTest_General()
        {
            var phoneStatus = PhoneStatus.Handheld | PhoneStatus.Left | PhoneStatus.Walk;
            var folderName = SensorDataDocumentType.GetFolderName(SensorType.Accelerometer, 20, PhoneType.iPhone4, phoneStatus);
            var expected = Path.Combine(SensorDataDocumentType.FileRootPath, "Accelerometer", "20", "iPhone4", phoneStatus.ToString());

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
            var phoneStatus = PhoneStatus.Handheld | PhoneStatus.Left | PhoneStatus.Walk;

            var document = SensorDataDocumentType.New<AccelerometerData>();
            SensorDataDocumentType.Save(document, 20, PhoneType.iPhone4, phoneStatus);

            var folder = SensorDataDocumentType.GetFolderName(SensorType.Accelerometer, 20, PhoneType.iPhone4, phoneStatus);
            Assert.IsTrue(Directory.Exists(folder));

            var files = Directory.EnumerateFiles(folder);
            Assert.AreEqual(1, files.Count());
        }

        [TestMethod]
        public void SaveTest_Gyrosensor()
        {
            TestCleanup(SensorType.Gyroscope);
            var phoneStatus = PhoneStatus.Handheld | PhoneStatus.Left | PhoneStatus.Walk;

            var document = SensorDataDocumentType.New<GyroscopeData>();
            SensorDataDocumentType.Save(document, 20, PhoneType.iPhone4, phoneStatus);

            var folder = SensorDataDocumentType.GetFolderName(SensorType.Accelerometer, 20, PhoneType.iPhone4, phoneStatus);
            Assert.IsTrue(Directory.Exists(folder));

            var files = Directory.EnumerateFiles(folder);
            Assert.AreEqual(1, files.Count());
        }

        [TestMethod]
        [ExpectedException(typeof(NotSupportedException))]
        public void OpenTest_UnvalidFilePath_Accelerometer()
        {
            var phoneStatus = PhoneStatus.Handheld | PhoneStatus.Left | PhoneStatus.Walk;
            var folderName = SensorDataDocumentType.GetFolderName(SensorType.Gyroscope, 20, PhoneType.iPhone4, phoneStatus);

            SensorDataDocumentType.Open<AccelerometerData>(folderName);
        }

        [TestMethod]
        [ExpectedException(typeof(NotSupportedException))]
        public void OpenTest_UnvalidFilePath_Gyroscope()
        {
            var phoneStatus = PhoneStatus.Handheld | PhoneStatus.Left | PhoneStatus.Walk;
            var folderName = SensorDataDocumentType.GetFolderName(SensorType.Accelerometer, 20, PhoneType.iPhone4, phoneStatus);

            SensorDataDocumentType.Open<GyroscopeData>(folderName);
        }

        [TestMethod]
        [ExpectedException(typeof(FileNotFoundException))]
        public void OpenTest_FileNotExist_Accelerometer()
        {
            var phoneStatus = PhoneStatus.Handheld | PhoneStatus.Left | PhoneStatus.Walk;
            var folderName = SensorDataDocumentType.GetFolderName(SensorType.Accelerometer, 20, PhoneType.iPhone4, phoneStatus);

            SensorDataDocumentType.Open<AccelerometerData>(folderName);
        }

        [TestMethod]
        [ExpectedException(typeof(FileNotFoundException))]
        public void OpenTest_FileNotExist_Gyroscope()
        {
            var phoneStatus = PhoneStatus.Handheld | PhoneStatus.Left | PhoneStatus.Walk;
            var folderName = SensorDataDocumentType.GetFolderName(SensorType.Gyroscope, 20, PhoneType.iPhone4, phoneStatus);

            SensorDataDocumentType.Open<GyroscopeData>(folderName);
        }
    }
}
