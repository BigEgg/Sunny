using System;
using System.IO;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Noodum.Wokamon.Sunny.Core.Models;

namespace Noodum.Wokamon.Sunny.Core.Test.Models
{
    [TestClass]
    public class AccelerometerDataTest
    {
        [TestMethod]
        [ExpectedException(typeof(ArgumentException))]
        public void ConstructorTest_ParameterNull()
        {
            new AccelerometerData(null);
        }

        [TestMethod]
        [ExpectedException(typeof(InvalidDataException))]
        public void ConstructorTest_UnknownData()
        {
            new AccelerometerData("1,2,3");
        }

        [TestMethod]
        public void ConstructorTest_ValidData()
        {
            var data = new AccelerometerData("0.11, 0.55, 0.66");
            Assert.IsTrue(Math.Abs(0.11 - data.X) < 0.000001);
            Assert.IsTrue(Math.Abs(0.55 - data.Y) < 0.000001);
            Assert.IsTrue(Math.Abs(0.66 - data.Z) < 0.000001);
        }

        [TestMethod]
        public void ToStringTest()
        {
            var data = new AccelerometerData()
            {
                X = 0.11F,
                Y = 0.55F,
                Z = 0.66F
            };
            Assert.AreEqual("0.11, 0.55, 0.66", data.ToString());
        }
    }
}
