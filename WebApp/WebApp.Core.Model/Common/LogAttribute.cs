using System;
using System.Collections.Generic;
using System.Text;

namespace WebApp.Core.Model.Common
{
    public class LogAttribute
    {
        public DateTime CreatedDate { set; get; }
        public DateTime UpdatedDate { set; get; }
        public string CreatedBy { set; get; }
        public string UpdatedBy { set; get; }

        public IEnumerable<ErrorMessage> Message { get; set; }
    }
}
