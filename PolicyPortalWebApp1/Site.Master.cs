using System;

namespace PolicyPortalWebApp1
{
    public partial class Site : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Redirect to login if session is missing
            if (Session["Username"] == null || Session["Role"] == null)
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            // Show welcome message
            lblUser.Text = $"Welcome, {Session["Username"]} ({Session["Role"]})";
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("~/Login.aspx");
        }

    }
}
