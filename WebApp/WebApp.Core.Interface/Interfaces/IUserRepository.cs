using System;
using System.Collections.Generic;
using System.Text;
using WebApp.Core.Model;
using WebApp.Core.Model.Common;

namespace WebApp.Core.Interface.Interfaces
{
    public interface IUserRepository
    {
        ResponseEntity AddUserAsync(UserModel userModel);
        List<UserModel> GetUsers(FilterModel filterModel);
    }
}
