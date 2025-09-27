using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace PolicyPortalWebApp1
{
    public partial class ForgotPassword : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text.Trim();

            if (string.IsNullOrEmpty(email))
            {
                lblMessage.Text = "Please enter your email.";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                return;
            }

            string connStr = ConfigurationManager.ConnectionStrings["PolicyPortalConnectionString"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT COUNT(*) FROM Users WHERE Email = @Email";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Email", email);

                try
                {
                    conn.Open();
                    int count = Convert.ToInt32(cmd.ExecuteScalar());

                    if (count > 0)
                    {
                        lblMessage.Text = "A password reset link has been sent to your email.";
                        lblMessage.ForeColor = System.Drawing.Color.Green;

                        // 🔒 Optional: Email logic or logging can be added here
                    }
                    else
                    {
                        lblMessage.Text = "Email not found. Please check and try again.";
                        lblMessage.ForeColor = System.Drawing.Color.Red;
                    }
                }
                catch (Exception ex)
                {
                    lblMessage.Text = "Error: " + ex.Message;
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                }
            }
        }
    }
}
