using System;
using System.Collections.Generic;
using System.Text;

namespace WebApp.Core.Repository.DTOs
{
    public class FilterDTO
    {
        public int PageSize { set; get; }
        public int PageNumber { set; get; }
        public string SearchText { set; get; }
    }
}
