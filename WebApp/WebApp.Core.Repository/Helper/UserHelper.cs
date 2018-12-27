using System;
using System.Collections.Generic;
using System.Text;
using WebApp.Core.Model;
using WebApp.Core.Repository.DTOs;

namespace WebApp.Core.Repository.Helper
{
    public static class UserHelper
    {
        internal static UserDTO AddUser(UserModel model)
        {
            var dto = new UserDTO
            {
                Email = model.Email,
                Password = model.Password,
                FirstName = model.FirstName,
                LastName = model.LastName,
                AspNetUserId = model.AspnetUserId,
                PhoneNumber = model.PhoneNumber
            };
            return dto;
        }
        internal static UserModel GetUser(UserDTO userDTO)
        {
            var userModel = new UserModel
            {
                Email = userDTO.Email,
                Password = userDTO.Password,
                FirstName = userDTO.FirstName,
                LastName = userDTO.LastName,
                PhoneNumber = userDTO.PhoneNumber
            };
            return userModel;
        }
    }
}
