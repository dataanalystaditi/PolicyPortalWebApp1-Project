using PolicyPortalWebApp1;
using System;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;

namespace PolicyPortalWebApp1
{
    public partial class Login : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session.Clear(); // Clear session on initial load
                lblGreeting.Text = "Greetings of the Day, " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm tt");
                Logger.Write("Login page loaded"/*, "Login"*/);
            }
        }


        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text.Trim();
            string selectedRole = ddlRole.SelectedValue;

            if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(password) || string.IsNullOrEmpty(selectedRole))
            {
                lblMessage.Text = "All fields are required.";
                return;
            }

            string query = "SELECT UserID, Role FROM Users WHERE Username = @Username AND PasswordHash = @Password";

            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Policy_Portal_DB"].ConnectionString))
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@Username", username);
                cmd.Parameters.AddWithValue("@Password", password);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    string dbRole = reader["Role"].ToString();

                    if (dbRole == selectedRole)
                    {
                        Session["Username"] = username;
                        Session["Role"] = dbRole;
                        Session["UserID"] = reader["UserID"].ToString();

                        LogToSessionFile($"Login SUCCESS - User: {username}, Role: {dbRole}");

                        if (dbRole == "Admin" || dbRole == "Underwriter")
                            Response.Redirect("~/Default.aspx");
                        else if (dbRole == "Viewer")
                            Response.Redirect("~/Unauthorized.aspx");
                        else
                            lblMessage.Text = "Selected role does not match your account role.";
                    }
                    else
                    {
                        lblMessage.Text = "Selected role does not match your account role.";
                        LogToSessionFile($"Login FAILED - Role mismatch for User: {username}");
                    }
                }
                else
                {
                    lblMessage.Text = "Invalid username or password.";
                    LogToSessionFile($"Login FAILED - Invalid credentials for User: {username}");
                }
            }
        }

        protected void btnForgotPassword_Click(object sender, EventArgs e)
        {
            Response.Redirect("ForgotPassword.aspx");
        }

        private void LogToSessionFile(string message)
        {
            if (Session["LogFilePath"] != null)
            {
                string logFile = Session["LogFilePath"].ToString();
                File.AppendAllText(logFile, $"[{DateTime.Now:HH:mm:ss}] {message}\n");
            }
        }
    }
}
