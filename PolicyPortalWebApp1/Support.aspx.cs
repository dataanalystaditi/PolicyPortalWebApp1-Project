using PolicyPortalWebApp1;
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace PolicyPortalWebApp1
{
    public partial class Support : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Username"] == null)
            {
                Logger.Write("Session Timed Out - Redirected to Login");
                Response.Redirect("Login.aspx");
                return;
            }

            Logger.Write("Support page accessed by " + Session["Username"]/*, "Support"*/);
        }


        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("Default.aspx");
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string name = txtName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string subject = txtSubject.Text.Trim();
            string message = txtMessage.Text.Trim();

            string connStr = ConfigurationManager.ConnectionStrings["PolicyPortalConnectionString"].ToString();

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand("InsertFeedback", conn);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@Name", name);
                cmd.Parameters.AddWithValue("@Email", email);
                cmd.Parameters.AddWithValue("@Subject", subject);
                cmd.Parameters.AddWithValue("@Message", message);

                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();

                lblStatus.Text = "✅ Thank you for your feedback! Our support team will contact you shortly.";
                lblStatus.ForeColor = System.Drawing.Color.Green;
            }

            // Optionally clear fields
            txtName.Text = txtEmail.Text = txtSubject.Text = txtMessage.Text = "";
        }

    }
}
