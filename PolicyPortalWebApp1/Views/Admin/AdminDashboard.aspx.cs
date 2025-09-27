using System;
using System.Web.UI;

namespace PolicyPortalWebApp1.Views.Admin
{
    public partial class AdminDashboard : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Check if the user is authenticated and has role
                if (Session["Username"] == null || Session["Role"] == null)
                {
                    Response.Redirect("~/Login.aspx");
                    return;
                }

                // Only allow Admins to access this page
                if (Session["Role"].ToString() != "Admin")
                {
                    Response.Redirect("~/Unauthorized.aspx");
                    return;
                }

                // Display welcome message
                lblWelcome.Text = "Welcome, Admin " + Session["Username"];
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            // Clear session and redirect to login
            Session.Clear();
            Session.Abandon();
            Response.Redirect("~/Login.aspx");
        }
    }
}
