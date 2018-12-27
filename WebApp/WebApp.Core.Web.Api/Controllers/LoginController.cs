using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Net;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Tokens;
using WebApp.Core.Model;


namespace WebApp.Core.Web.Api.Controllers
{
    [AllowAnonymous]
    [Route("api/[controller]")]
    [ApiController]
    public class LoginController : ControllerBase
    {
        private readonly IConfiguration _configuration;
        private readonly SignInManager<IdentityUser> _signInManager;
        private readonly UserManager<IdentityUser> _userManager;
        public LoginController(IConfiguration configuration, 
                               UserManager<IdentityUser> userManager, 
                               SignInManager<IdentityUser> signInManager)
        {
            _configuration = configuration;
            _userManager = userManager;
            _signInManager = signInManager;
        }

        /// <summary>
        /// API to generate JWT Token and Login User
        /// </summary>
        /// <param name="model">Model for getting username and password in request.</param>
        /// <returns></returns>
        [HttpPost]
        [Route("Login")]
        public async Task<IActionResult> Login ([FromBody]LoginModel model)
        {
            string tokenKey = string.Empty;
            if (ModelState.IsValid)
            {
                var user = await _userManager.FindByEmailAsync(model.Email);
                if (user != null)
                {
                    var result = await _signInManager.CheckPasswordSignInAsync(user, model.Password, false);
                    if (result.Succeeded)
                    {
                        var tokenHandler = new JwtSecurityTokenHandler();
                        var key = Encoding.ASCII.GetBytes(_configuration["JWTSecretKey"]);
                        var tokenDescriptor = new SecurityTokenDescriptor
                        {
                            Subject = new ClaimsIdentity(new Claim[]
                            {
                                new Claim(ClaimTypes.Email, user.Email.ToString())
                            }),
                            Expires = DateTime.UtcNow.AddHours(10),
                            SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(key), SecurityAlgorithms.HmacSha256Signature)
                        };
                        var token = tokenHandler.CreateToken(tokenDescriptor);
                        tokenKey = tokenHandler.WriteToken(token);
                        var dto = new JwtModel
                        {
                            StatusCode = (int)HttpStatusCode.OK,
                            Token = tokenKey,
                            Data = null
                        };
                        return Common.GetResponse("Success", dto, HttpStatusCode.OK);
                    }                    
                    return Common.GetResponse("Error", result.ToString(), HttpStatusCode.OK);
                }
                else
                    return Common.GetResponse("User doesn't exists", null, HttpStatusCode.OK);
            }
            return Common.GetResponse("Error.", "Please provide email and password", HttpStatusCode.OK);
        }
    }
}
