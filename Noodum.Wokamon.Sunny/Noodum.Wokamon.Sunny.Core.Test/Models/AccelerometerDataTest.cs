using Microsoft.VisualStudio.TestTools.UnitTesting;
using Noodum.Wokamon.Sunny.Core.Models;

namespace Noodum.Wokamon.Sunny.Core.Test.Models
{
    [TestClass]
    public class AccelerometerDataTest
    {
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
