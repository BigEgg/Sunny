using System;
using System.Net;
using System.Net.Http;
using System.Web.Http.Filters;

namespace Noodum.Wokamon.Sunny.SensorDataCollector.Controllers.Attributes
{
    public class ExceptionHandlingAttribute : ExceptionFilterAttribute
    {
        public override void OnException(HttpActionExecutedContext actionExecutedContext)
        {
            if (actionExecutedContext.Exception is ArgumentException ||
                actionExecutedContext.Exception is ArgumentNullException)
            {
                actionExecutedContext.Response = new HttpResponseMessage(HttpStatusCode.BadRequest)
                {
                    Content = new StringContent(actionExecutedContext.Exception.Message),
                    ReasonPhrase = "Bad Request"
                };
            }
            else
            {
                actionExecutedContext.Response = new HttpResponseMessage(HttpStatusCode.InternalServerError)
                {
                    Content = new StringContent("An error occurred, please try again or contact the administrator."),
                    ReasonPhrase = "Critical Exception"
                };
            }
        }
    }
}