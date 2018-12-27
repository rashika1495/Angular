using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace WebApp.Core.Web.Api.Models
{
    public class UserModel
    {
        public string Email { set; get; }
        public string Password { set; get; }
        public string FirstName { set; get; }
        public string LastName { set; get; }
        public string PhoneNumber { get; set; }
        [NotMapped]
        public string AspnetUserId { get; set; }
    }
}
