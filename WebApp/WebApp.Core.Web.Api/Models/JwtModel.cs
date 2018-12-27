using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace WebApp.Core.Web.Api.Models
{
    public class JwtModel
    {
        public int StatusCode { get; set; }
        public string Token { get; set; }

        public dynamic Data { set; get; }
    }
}
