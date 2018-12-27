using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace WebApp.Core.Model.Common
{
    public class ErrorMessage
    {
        public ErrorMessage()
        {

        }
        public ErrorMessage(string error, string status)
        {
            Message = error;
            Code = status;
            Status = status;
        }

        public string Message { get; set; }

        public string Code { get; set; }

        public string Status { get; set; }

        public string MoreDetails { get; set; }


        public IEnumerable<ErrorMessage> FillErrorMessage(string message, string statusCode, string statusMessage, Exception ex)
        {
            List<ErrorMessage> errorMessageList = new List<ErrorMessage>();
            errorMessageList.Add(new ErrorMessage { Message = message, Code = statusCode, Status = statusMessage, MoreDetails = GetExceptionMoreDetails(ex) });
            return errorMessageList.AsEnumerable();
        }

        public static string GetExceptionMoreDetails(Exception ex)
        {
            StringBuilder body = new StringBuilder();
            body.Append("Error Message: " + ex.Message);

            body.Append(" ****************Stack Trace************************* ");
            body.Append(ex.StackTrace);

            body.Append(" ****************Inner Exception********************* ");
            body.Append(ex.InnerException);

            return body.ToString();
        }
    }
}
