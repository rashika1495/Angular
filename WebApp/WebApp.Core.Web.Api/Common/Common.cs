using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Dynamic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;


namespace WebApp.Core.Web.Api.Controllers
{
    
    public static class Common 
    {
        public static ContentResult GetResponse(string message, dynamic data, HttpStatusCode statusCode, int count = 0)
        {
            dynamic res = new ExpandoObject();
            res.message = message;
            res.data = data;
            res.statuscode = statusCode;
            return new ContentResult
            {
                Content = Newtonsoft.Json.JsonConvert.SerializeObject(res),
                ContentType = "text/json",
                StatusCode = (int)statusCode
            };
        }
    }
   
}
