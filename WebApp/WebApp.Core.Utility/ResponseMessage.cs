using System;
using System.Collections.Generic;
using System.Text;

namespace WebApp.Core.Utility
{
    public static class ResponseMessage
    {
        public static string INVALID_PASSWORD = "You have entered an invalid password.";
        public static string PROFILE_UPDATED = "Profile updated successfully.";
        public static string PROFILE_NOT_UPDATED = "Profile not updated.";
        public static string PASSWORD_CHANGED = "Password changed successfully.";
        public static string PASSWORD_NOT_CHANGED = "Password not changed.";
        public static string DATA_SAVED = "Data saved successfully.";
        public static string DATA_NOT_SAVED = "Data not saved.";
        public static string LOGOUT_SUCCESS = "User logged out successfully.";
        public static string LOGOUT_UNSUCCESS = "Unable to logout.";
        public static string EXCEPTION_OCCURED = "We have encountered an error. Please try after some time.";
        public static string UNATHORIZED_REQUEST = "It seems that you have logged in from some other device.";
        public static string LOGIN_FAILED = "Invalid credentials.";
        public static string LOGIN_SUCCESS = "User login successfully.";

        public static string PROFILE_CREATED = "Profile created successfully.";
        public static string DATA_NOT_FOUND = "Sorry! data not found.";
        public static string DATA_FOUND = "data found.";
        public static string INTERNAL_SERVER_ERROR = "Internal Server Error.";

        public static bool VALID = true;
        public static bool NOT_VALID = true;

    }
}
