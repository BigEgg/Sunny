using Microsoft.VisualStudio.TestTools.UnitTesting;
using Noodum.Wokamon.Sunny.Core.Models;

namespace Noodum.Wokamon.Sunny.Core.Test.Models
{
    [TestClass]
    public class GyrosensorDataTest
    {
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
