using PolicyPortalWebApp1;
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PolicyPortalWebApp1
{
    public partial class Renewals : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Username"] == null || Session["Role"] == null || Session["UserID"] == null)
            {
                Logger.Write("Session Timed Out - Redirected to Login");
                Response.Redirect("Login.aspx");
                return;
            }

            Logger.Write("Renewals page accessed by " + Session["Username"]/*, "Renewals"*/);

            if (!IsPostBack)
            {
                LoadRenewals(); // your custom method
            }
        }


        private void LoadRenewals()
        {
            string role = Session["Role"].ToString();
            int userId = Convert.ToInt32(Session["UserID"]);
            string connStr = ConfigurationManager.ConnectionStrings["PolicyPortalConnectionString"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand("GetRenewalPolicies", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@UserID", userId);
                cmd.Parameters.AddWithValue("@Role", role);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvRenewals.DataSource = dt;
                gvRenewals.DataBind();
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("Default.aspx");
        }

        protected void gvRenewals_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "RenewPolicy")
            {
                int policyId = Convert.ToInt32(e.CommandArgument);
                Response.Redirect("RenewPolicy.aspx?PolicyID=" + policyId);
            }
        }
    }
}
