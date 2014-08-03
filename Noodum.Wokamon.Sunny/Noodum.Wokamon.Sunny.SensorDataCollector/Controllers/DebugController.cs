using System;
using System.Web.Http;

namespace Noodum.Wokamon.Sunny.SensorDataCollector.Controllers
{
    public class DebugController : ApiController
    {
        //  GET api/debug/testconnection
        [HttpGet]
        public String TestConnection()
        {
            return "Can connect.";
        }
    }
}
