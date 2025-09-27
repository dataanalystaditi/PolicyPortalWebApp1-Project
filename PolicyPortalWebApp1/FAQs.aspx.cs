using PolicyPortalWebApp1;
using System;
using System.Web.UI;

namespace PolicyPortalWebApp1
{
    public partial class FAQs : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Username"] == null)
            {
                Logger.Write("Session Timed Out - Redirected to Login");
                Response.Redirect("Login.aspx");
                return;
            }

            Logger.Write("FAQs page accessed by " + Session["Username"]/*, "FAQs"*/);
        }


        protected void btnBack_Click(object sender, EventArgs e)
        {
            string role = Session["Role"].ToString();
            if (role == "Admin")
                Response.Redirect("Default.aspx");
            else if (role == "Underwriter")
                Response.Redirect("Default.aspx");
        }
    }
}
