using Noodum.Wokamon.Sunny.Core.Documents;
using Noodum.Wokamon.Sunny.Core.Models;
using Noodum.Wokamon.Sunny.SensorDataCollector.Controllers.Attributes;
using Noodum.Wokamon.Sunny.SensorDataCollector.Models;
using System;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace Noodum.Wokamon.Sunny.SensorDataCollector.Controllers
{
    [ExceptionHandling]
    public class SensorDataController : ApiController
    {
        // POST api/sensordata/accelerometer
        [HttpPost]
        public HttpResponseMessage Accelerometer([FromBody]DataPackage<AccelerometerData> data)
        {
            if (data == null) { throw new ArgumentNullException("data cannot be null"); }

            var document = SensorDataDocumentType.New<AccelerometerData>();
            foreach (var entry in data.Data)
            {
                document.Data.Add(entry);
            }
            SensorDataDocumentType.Save(document, data.PhoneData.UpdateInterval, data.PhoneData.PhoneType, data.PhoneData.PhoneStats);

            return new HttpResponseMessage(HttpStatusCode.OK);
        }

        // POST api/sensordata/gyroscope
        [HttpPost]
        public HttpResponseMessage Gyroscope([FromBody] DataPackage<GyrosensorData> data)
        {
            if (data == null) { throw new ArgumentNullException("data cannot be null"); }

            var document = SensorDataDocumentType.New<GyrosensorData>();
            foreach (var entry in data.Data)
            {
                document.Data.Add(entry);
            }
            SensorDataDocumentType.Save(document, data.PhoneData.UpdateInterval, data.PhoneData.PhoneType, data.PhoneData.PhoneStats);

            return new HttpResponseMessage(HttpStatusCode.OK);
        }
    }
}