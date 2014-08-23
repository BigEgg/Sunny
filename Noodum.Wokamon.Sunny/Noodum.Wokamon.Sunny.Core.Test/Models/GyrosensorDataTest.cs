using Microsoft.VisualStudio.TestTools.UnitTesting;
using Noodum.Wokamon.Sunny.Core.Models;
using System;
using System.IO;

namespace Noodum.Wokamon.Sunny.Core.Test.Models
{
    [TestClass]
    public class GyrosensorDataTest
    {
        [TestMethod]
        [ExpectedException(typeof(ArgumentException))]
        public void ConstructorTest_ParameterNull()
        {
            new GyrosensorData(null);
        }

        [TestMethod]
        [ExpectedException(typeof(InvalidDataException))]
        public void ConstructorTest_UnknownData()
        {
            new GyrosensorData("1,2,3");
        }

        [TestMethod]
        public void ConstructorTest_ValidData()
        {
            var data = new GyrosensorData("0.11, 0.55, 0.66");
            Assert.IsTrue(Math.Abs(0.11 - data.DeltaX) < 0.000001);
            Assert.IsTrue(Math.Abs(0.55 - data.DeltaY) < 0.000001);
            Assert.IsTrue(Math.Abs(0.66 - data.DeltaZ) < 0.000001);
        }

        [TestMethod]
        public void ToStringTest()
        {
            var data = new GyrosensorData()
            {
                DeltaX = 0.11F,
                DeltaY = 0.55F,
                DeltaZ = 0.66F
            };
            Assert.AreEqual("0.11, 0.55, 0.66", data.ToString());
        }
    }
}
