using System;
using System.Collections.Generic;
using System.Text;

namespace WebApp.Core.Model
{
    public class FilterModel
    {
        public int PageSize { set; get; }
        public int PageNumber { set; get; }
        public string SearchText { set; get; }
    }
}
