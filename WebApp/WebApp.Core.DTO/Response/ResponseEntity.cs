using System;
using System.Collections.Generic;
using System.Text;

namespace WebApp.Core.DTO.Response
{
    public class ResponseEntity
    {
        public bool IsValid { set; get; }

        public IEnumerable<ErrorMessage> Message { get; set; }
    }
}
