using PolicyPortalWebApp1;
using System;

namespace PolicyPortalWebApp1
{
    public partial class Unauthorized : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Username"] == null)
            {
                Logger.Write("Unauthorized page access attempt by unknown user - redirected to login");
                Response.Redirect("~/Login.aspx");
                return;
            }

            Logger.Write("Unauthorized page displayed to " + Session["Username"]/*, "Unauthorized"*/);
        }

    }
}
