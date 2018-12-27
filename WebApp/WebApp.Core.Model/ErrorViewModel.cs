using System;
using System.Collections.Generic;
using System.Text;

namespace WebApp.Core.Model
{
    public class ErrorViewModel
    {
        public string RequestId { get; set; }

        public bool ShowRequestId => !string.IsNullOrEmpty(RequestId);
    }
}
