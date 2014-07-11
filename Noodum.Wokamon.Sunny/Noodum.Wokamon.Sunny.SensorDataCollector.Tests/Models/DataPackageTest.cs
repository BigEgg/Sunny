using Microsoft.VisualStudio.TestTools.UnitTesting;
using Noodum.Wokamon.Sunny.Core.Models;
using Noodum.Wokamon.Sunny.SensorDataCollector.Models;
using System.Collections.Generic;

namespace Noodum.Wokamon.Sunny.SensorDataCollector.Tests.Models
{
    [TestClass]
    public class DataPackageTest
    {
        [TestMethod]
        public void SerializeTest_DataPackage_Accelerometer()
        {
            var dataPackage = new DataPackage<AccelerometerData>();
            dataPackage.PhoneData = new PhoneData()
            {
                PhoneStats = PhoneStatus.Handheld | PhoneStatus.Left | PhoneStatus.Walk,
                PhoneType = PhoneType.iPhone4,
                UpdateInterval = 20
            };
            dataPackage.Data = new List<AccelerometerData>();
            dataPackage.Data.Add(new AccelerometerData() { X = 0.111F, Y = 0.555F, Z = 0.666F });
            dataPackage.Data.Add(new AccelerometerData() { X = 0.611F, Y = 0.855F, Z = 0.766F });

            var jsonString = Newtonsoft.Json.JsonConvert.SerializeObject(dataPackage);
            Assert.IsFalse(string.IsNullOrWhiteSpace(jsonString));
            //  {"PhoneData":{"PhoneType":0,"PhoneStats":4,"UpdateInterval":20},"Data":[{"X":0.111,"Y":0.555,"Z":0.666},{"X":0.611,"Y":0.855,"Z":0.766}]}

            var newDataPackage = Newtonsoft.Json.JsonConvert.DeserializeObject(jsonString, typeof(DataPackage<AccelerometerData>)) as DataPackage<AccelerometerData>;
            Assert.IsNotNull(newDataPackage);
            Assert.AreEqual(dataPackage.PhoneData.PhoneStats, newDataPackage.PhoneData.PhoneStats);
            Assert.AreEqual(dataPackage.PhoneData.PhoneType, newDataPackage.PhoneData.PhoneType);
            Assert.AreEqual(dataPackage.PhoneData.UpdateInterval, newDataPackage.PhoneData.UpdateInterval);
            Assert.AreEqual(dataPackage.Data.Count, newDataPackage.Data.Count);
        }

        [TestMethod]
        public void SerializeTest_DataPackage_Gyrosensor()
        {
            var dataPackage = new DataPackage<GyrosensorData>();
            dataPackage.PhoneData = new PhoneData()
            {
                PhoneStats = PhoneStatus.Handheld | PhoneStatus.Left | PhoneStatus.Walk,
                PhoneType = PhoneType.iPhone4,
                UpdateInterval = 20
            };
            dataPackage.Data = new List<GyrosensorData>();
            dataPackage.Data.Add(new GyrosensorData() { DeltaX = 0.111F, DeltaY = 0.555F, DeltaZ = 0.666F });
            dataPackage.Data.Add(new GyrosensorData() { DeltaX = 0.611F, DeltaY = 0.855F, DeltaZ = 0.766F });

            var jsonString = Newtonsoft.Json.JsonConvert.SerializeObject(dataPackage);
            Assert.IsFalse(string.IsNullOrWhiteSpace(jsonString));
            //  {"PhoneData":{"PhoneType":0,"PhoneStats":4,"UpdateInterval":20},"Data":[{"DeltaX":0.111,"DeltaY":0.555,"DeltaZ":0.666},{"DeltaX":0.611,"DeltaY":0.855,"DeltaZ":0.766}]}

            var newDataPackage = Newtonsoft.Json.JsonConvert.DeserializeObject(jsonString, typeof(DataPackage<GyrosensorData>)) as DataPackage<GyrosensorData>;
            Assert.IsNotNull(newDataPackage);
            Assert.AreEqual(dataPackage.PhoneData.PhoneStats, newDataPackage.PhoneData.PhoneStats);
            Assert.AreEqual(dataPackage.PhoneData.PhoneType, newDataPackage.PhoneData.PhoneType);
            Assert.AreEqual(dataPackage.PhoneData.UpdateInterval, newDataPackage.PhoneData.UpdateInterval);
            Assert.AreEqual(dataPackage.Data.Count, newDataPackage.Data.Count);
        }

    }
}
