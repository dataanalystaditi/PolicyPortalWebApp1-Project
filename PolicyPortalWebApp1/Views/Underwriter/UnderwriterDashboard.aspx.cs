using System;
using System.Web.UI;

namespace PolicyPortalWebApp1.Views.Underwriter
{
    public partial class UnderwriterDashboard : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Check if the user is authenticated
                if (Session["Username"] == null || Session["Role"] == null)
                {
                    Response.Redirect("~/Login.aspx");
                    return;
                }

                // Only allow users with 'Underwriter' role
                if (Session["Role"].ToString() != "Underwriter")
                {
                    Response.Redirect("~/Unauthorized.aspx");
                    return;
                }

                // Display welcome message
                lblWelcome.Text = "Welcome, Underwriter " + Session["Username"];
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("~/Login.aspx");
        }
    }
}
