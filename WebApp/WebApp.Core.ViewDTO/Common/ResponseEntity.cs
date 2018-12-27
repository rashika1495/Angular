using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Dynamic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;


namespace WebApp.Core.ViewDTO.Common
{
    public class ResponseEntity
    {
        public bool IsValid { set; get; }

        public IEnumerable<ErrorMessage> Message { get; set; }
    }
    public static class Common 
    {
        public static ContentResult GetResponse(string message, dynamic data, HttpStatusCode statusCode, int count = 0)
        {
            dynamic res = new ExpandoObject();
            res.message = message;
            res.data = data;

            return new ContentResult
            {
                Content = Newtonsoft.Json.JsonConvert.SerializeObject(res),
                ContentType = "text/json",
                StatusCode = (int)statusCode
            };
        }
    }
   
}
