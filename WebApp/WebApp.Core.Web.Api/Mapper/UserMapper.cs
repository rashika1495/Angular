using WebApp.Core.Repository.DTOs;
using WebApp.Core.Web.Api.Models;

namespace WebApp.Core.Web.Api.Mapper
{
    /// <summary>
    /// Maps the User Model to User DTO
    /// </summary>
    public static class UserMapper
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
