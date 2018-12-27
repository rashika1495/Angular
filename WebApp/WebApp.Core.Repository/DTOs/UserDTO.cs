using System;
using System.Collections.Generic;
using System.Text;

namespace WebApp.Core.Repository.DTOs
{
    public class UserDTO
    {
        public string Email { set; get; }
        public string Password { set; get; }
        public string FirstName { set; get; }
        public string LastName { set; get; }
        public string AspNetUserId { set; get; }
        public string PhoneNumber { get; set; }
    }
}
