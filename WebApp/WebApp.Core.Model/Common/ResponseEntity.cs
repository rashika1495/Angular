using System;
using System.Collections.Generic;
using System.Text;

namespace WebApp.Core.Model.Common
{
    public class ResponseEntity
    {
        public bool IsValid { set; get; }

        public IEnumerable<ErrorMessage> Message { get; set; }
    }
}
