using System;
using System.Collections.Generic;
using System.Text;
using WebApp.Core.Model;
using WebApp.Core.Repository.DTOs;

namespace WebApp.Core.Repository.Helper
{
    public static class FilterHelper
    {
        internal static FilterDTO GetFilter(FilterModel filterModel)
        {
            var filter = new FilterDTO()
            {
                PageNumber = filterModel.PageNumber,
                PageSize = filterModel.PageSize,
                SearchText = filterModel.SearchText
            };
            return filter;
        }
    }
}
