using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace PolicyPortalWebApp1
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Username"] == null || Session["Role"] == null)
            {
                Logger.Write("Session Timed Out - Redirected to Login");
                Response.Redirect("Login.aspx");
                return;
            }

            Logger.Write("Dashboard accessed by " + Session["Username"]);

            if (!IsPostBack)
            {
                lblUser.Text = $"{Session["Username"]} ({Session["Role"]})";
                lblRole.Text = Session["Role"].ToString();

                LoadPolicies();      // Load policies based on role
                LoadMenuItems();     // Populate the menu
            }
        }

        private void LoadPolicies(string policyName = "", string startDate = "")
        {
            string role = Session["Role"].ToString();
            int userId = Convert.ToInt32(Session["UserID"]);

            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Policy_Portal_DB"].ConnectionString))
            using (SqlCommand cmd = new SqlCommand("GetPoliciesByRole", conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Role", role);
                cmd.Parameters.AddWithValue("@UserID", userId);
                cmd.Parameters.AddWithValue("@PolicyName", string.IsNullOrEmpty(policyName) ? (object)DBNull.Value : policyName);
                cmd.Parameters.AddWithValue("@StartDate", string.IsNullOrEmpty(startDate) ? (object)DBNull.Value : startDate);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                rptPolicies.DataSource = dt;
                rptPolicies.DataBind();
            }
        }

        private void LoadMenuItems()
        {
            string role = Session["Role"].ToString();
            DataTable dtMenu = new DataTable();
            dtMenu.Columns.Add("Text");
            dtMenu.Columns.Add("Url");

            dtMenu.Rows.Add("Home", "Default.aspx");

            if (role == "Admin")
            {
                dtMenu.Rows.Add("Insert Policy", "InsertPolicy.aspx");
                dtMenu.Rows.Add("Renewals", "Renewals.aspx");
                dtMenu.Rows.Add("FAQs", "FAQs.aspx");
                dtMenu.Rows.Add("Support", "Support.aspx");
            }
            else if (role == "Underwriter")
            {
                dtMenu.Rows.Add("Renewals", "Renewals.aspx");
                dtMenu.Rows.Add("FAQs", "FAQs.aspx");
                dtMenu.Rows.Add("Support", "Support.aspx");
            }
            else if (role == "Viewer")
            {
                Response.Redirect("Unauthorized.aspx");
                return;
            }

            rptMenuItems.DataSource = dtMenu;
            rptMenuItems.DataBind();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            LoadPolicies(txtPolicyName.Text.Trim(), txtStartDate.Text.Trim());
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            txtPolicyName.Text = "";
            txtStartDate.Text = "";
            LoadPolicies();
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Logger.Write("User logged out: " + Session["Username"]);
            Session.Clear();
            Response.Redirect("Login.aspx");
        }

        protected void btnReports_Click(object sender, EventArgs e)
        {
            Response.Redirect("Reports.aspx");
        }
    }
}
