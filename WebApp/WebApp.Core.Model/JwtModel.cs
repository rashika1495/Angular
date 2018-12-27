using System;
using System.Collections.Generic;
using System.Text;

namespace WebApp.Core.Model
{
    public class JwtModel
    {
        public int StatusCode { get; set; }
        public string Token { get; set; }

        public dynamic Data { set; get; }
    }
}
