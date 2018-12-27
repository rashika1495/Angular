using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using WebApp.Core.Interface.Interfaces;
using WebApp.Core.Model;
using WebApp.Core.Model.Common;

namespace WebApp.Core.Web.Api.Controllers
{
    //[Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class UserController : ControllerBase
    {
        private readonly IUserRepository _iUserRepository;
        private readonly UserManager<IdentityUser> _userManager;
        public UserController(IUserRepository iUserRepository,
                              UserManager<IdentityUser> userManager )
        {
            _iUserRepository = iUserRepository;
            _userManager = userManager;
        }
        /// <summary>
        /// API to add user
        /// </summary>
        /// <param name="model">The model for taking request.</param>
        /// <returns></returns>
        [HttpPost("Add")]
        public async Task<IActionResult> AddUser([FromBody]UserModel model)
        {
            ResponseEntity responseEntity = new ResponseEntity();
            try
            {
                var user = new IdentityUser
                {
                    Email = model.Email,
                    PhoneNumber = model.PhoneNumber,
                    UserName = model.Email
                };
                var result = await _userManager.CreateAsync(user, model.Password);
                if (result.Succeeded)
                {
                    model.AspnetUserId = user.Id;                  
                    responseEntity = _iUserRepository.AddUserAsync(model);
                    if (responseEntity.IsValid)
                        return Common.GetResponse("Success", model, HttpStatusCode.OK);
                    else
                        return Common.GetResponse("Error", null, HttpStatusCode.OK);
                }
                return Common.GetResponse("Error", result.ToString(), HttpStatusCode.OK);
            }
            catch (Exception ex)
            {
                return Common.GetResponse("Error", ex.ToString(), HttpStatusCode.OK);
            }
        }

        /// <summary>
        /// API to get users
        /// </summary>
        /// <param name="filter Model">The filter model for taking request.</param>
        /// <returns></returns>
        [HttpPost("Details")]
        public IActionResult GetUsers([FromBody] FilterModel filterModel)
        {
            try
            {  
                if(filterModel==null)
                    return Common.GetResponse("Error", filterModel, HttpStatusCode.BadRequest);
                var result = _iUserRepository.GetUsers(filterModel);
                return Common.GetResponse("Success", result, HttpStatusCode.OK);
            }
            catch (Exception ex)
            {
                return Common.GetResponse("Error", ex.ToString(), HttpStatusCode.InternalServerError);
            }
        }
    }
}