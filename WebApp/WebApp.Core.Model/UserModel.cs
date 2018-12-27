using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text;
using WebApp.Core.Model.Common;

namespace WebApp.Core.Model
{
    public class UserModel : LogAttribute
    {
        public int UserId { set; get; }
        public string Email { set; get; }
        public string Password { set; get; }
        public string FirstName { set; get; }
        public string LastName { set; get; }
        public string PhoneNumber { get; set; }
        [NotMapped]
        public string AspnetUserId { get; set; }
    }
}
