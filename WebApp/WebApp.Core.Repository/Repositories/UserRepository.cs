using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using WebApp.Core.DAL.DAL;
using WebApp.Core.Interface.Interfaces;
using WebApp.Core.Model;
using WebApp.Core.Model.Common;
using WebApp.Core.Repository.DTOs;
using WebApp.Core.Repository.Helper;
using WebApp.Core.Utility;

namespace WebApp.Core.Repository.Repositories
{
    public class UserRepository : IUserRepository
    {
        private string connectionString = string.Empty;
        private readonly IConfiguration _configuration;
        private const string ADD_USER = "Usp_insertUser";
        private const string GET_ALL_USER = "Usp_get_user";
        public UserRepository(IConfiguration configuration)
        {
            _configuration = configuration;
            connectionString = _configuration.GetConnectionString("DefaultConnection");
        }
        /// <summary>
        /// Adds the user to the database
        /// </summary>
        /// <param name="userDTO">The user data transfer object.</param>
        /// <returns></returns>
        public ResponseEntity AddUserAsync(UserModel userModel)
        {
            // mapping from model to DTO//
            var userDTO = UserHelper.AddUser(userModel);
            ResponseEntity responseEntity = new ResponseEntity();
            bool IsInserted = false;
            ErrorMessage error = new ErrorMessage();
            SqlParameter[] sqlParameter = new SqlParameter[6];
            sqlParameter[0] = new SqlParameter("@AspnetUserId", userDTO.AspNetUserId);
            sqlParameter[1] = new SqlParameter("@Email", userDTO.Email);
            sqlParameter[2] = new SqlParameter("@FirstName", userDTO.FirstName);
            sqlParameter[3] = new SqlParameter("@LastName", userDTO.LastName);
            sqlParameter[4] = new SqlParameter("@PhoneNumber", userDTO.PhoneNumber);
            sqlParameter[5] = new SqlParameter("@Password", userDTO.Password);           
            try
            {  
                using (SqlConnection sqlConn = new SqlConnection(connectionString))
                {                 
                    SQLHelper.ExecuteNonQuery(sqlConn, ADD_USER, sqlParameter);
                    IsInserted = true;                   
                    responseEntity.IsValid = IsInserted;                   
                }
            }
            catch (Exception ex)
            {
                responseEntity.Message = error.FillErrorMessage(ResponseMessage.INTERNAL_SERVER_ERROR, StatusCodes.Status500InternalServerError.ToString(), "", ex);
            }
            finally
            {               
            }
            return responseEntity;
        }
        public List<UserModel> GetUsers(FilterModel filterModel)
        {
            // mapping from filter model to filter DTO//
            var filterDTO = FilterHelper.GetFilter(filterModel);            
            List<UserModel> usersModels = new List<UserModel>();
            ErrorMessage error = new ErrorMessage();
            try
            {
                SqlParameter[] sqlParameter = new SqlParameter[3];
                sqlParameter[0] = new SqlParameter("@PageNumber", filterDTO.PageNumber);
                sqlParameter[1] = new SqlParameter("@PageSize", filterDTO.PageSize);
                sqlParameter[2] = new SqlParameter("@SearchText", filterDTO.SearchText);
                var dataSetResult=SQLHelper.ExecuteDataset(connectionString, GET_ALL_USER, sqlParameter);
                DataTable dt = new DataTable();
                dt = dataSetResult.Tables[0];
                if(dt !=null && dt.Rows.Count>0)
                {
                    for(int i=0;i<dt.Rows.Count;i++)
                    {
                        UserModel userModel = new UserModel();
                        userModel.AspnetUserId= Convert.ToString(dt.Rows[i]["AspnetUserId"]);
                        userModel.LastName = Convert.ToString(dt.Rows[i]["LastName"]);
                        userModel.Email = Convert.ToString(dt.Rows[i]["Email"]);
                        userModel.Password = Convert.ToString(dt.Rows[i]["Password"]);
                        userModel.FirstName = Convert.ToString(dt.Rows[i]["FirstName"]);
                        userModel.PhoneNumber = Convert.ToString(dt.Rows[i]["PhoneNumber"]);
                        userModel.UserId = Convert.ToInt32(dt.Rows[i]["Id"]);
                        usersModels.Add(userModel);
                    }
                }                
            }
            catch(Exception ex)
            {
                // need to save log here //
                var messageModel = new UserModel();
                messageModel.Message = error.FillErrorMessage(ResponseMessage.INTERNAL_SERVER_ERROR, StatusCodes.Status500InternalServerError.ToString(), "", ex);
                usersModels.Add(messageModel);
            }
            finally
            {
            }
            return usersModels;
        }
        
    }
}
