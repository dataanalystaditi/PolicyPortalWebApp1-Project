using PolicyPortalWebApp1;
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace PolicyPortalWebApp1
{
    public partial class RenewPolicy : Page
    {
        protected DateTime currentEndDate;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Username"] == null)
            {
                Logger.Write("Session Timed Out - Redirected to Login");
                Response.Redirect("Login.aspx");
                return;
            }

            Logger.Write("RenewPolicy page accessed by " + Session["Username"]/*, "RenewPolicy"*/);

            if (!IsPostBack)
            {
                if (Request.QueryString["PolicyID"] != null)
                {
                    int policyId = Convert.ToInt32(Request.QueryString["PolicyID"]);
                    LoadPolicyDetails(policyId);
                }
                else
                {
                    Logger.Write("No PolicyID provided in RenewPolicy.aspx");
                }
            }
        }



        private void LoadPolicyDetails(int policyId)
        {
            string connStr = ConfigurationManager.ConnectionStrings["PolicyPortalConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand("SELECT EndDate, PremiumAmount FROM Policies WHERE PolicyID = @PolicyID", conn);
                cmd.Parameters.AddWithValue("@PolicyID", policyId);
                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    currentEndDate = Convert.ToDateTime(reader["EndDate"]);
                    lblCurrentEndDate.Text = currentEndDate.ToString("dd-MMM-yyyy");
                    txtPremiumAmount.Text = reader["PremiumAmount"].ToString();
                    lblPolicyID.Text = "Policy ID: " + policyId;
                }
                else
                {
                    lblMessage.Text = "Policy not found.";
                    lblMessage.CssClass = "error";
                }
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            int policyId;
            if (!int.TryParse(Request.QueryString["PolicyID"], out policyId))
            {
                lblMessage.Text = "Invalid Policy ID.";
                lblMessage.CssClass = "error";
                return;
            }

            DateTime newEndDate;
            if (!DateTime.TryParse(txtNewEndDate.Text, out newEndDate))
            {
                lblMessage.Text = "Please enter a valid new End Date.";
                lblMessage.CssClass = "error";
                return;
            }

            decimal newPremium;
            if (!decimal.TryParse(txtPremiumAmount.Text, out newPremium))
            {
                lblMessage.Text = "Invalid premium amount.";
                lblMessage.CssClass = "error";
                return;
            }

            if (newEndDate <= DateTime.Parse(lblCurrentEndDate.Text))
            {
                lblMessage.Text = "New End Date must be later than the current End Date.";
                lblMessage.CssClass = "error";
                return;
            }

            string remarks = txtRemarks.Text;
            int renewedBy = Convert.ToInt32(Session["UserID"]);

            string connStr = ConfigurationManager.ConnectionStrings["PolicyPortalConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand("RenewPolicy", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@PolicyID", policyId);
                cmd.Parameters.AddWithValue("@NewEndDate", newEndDate);
                cmd.Parameters.AddWithValue("@NewPremiumAmount", newPremium);
                cmd.Parameters.AddWithValue("@Remarks", remarks);
                cmd.Parameters.AddWithValue("@RenewedBy", renewedBy);

                try
                {
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    lblMessage.Text = "Policy renewed successfully.";
                    lblMessage.CssClass = "msg";
                }
                catch (SqlException ex)
                {
                    lblMessage.Text = "Error: " + ex.Message;
                    lblMessage.CssClass = "error";
                }
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("Renewals.aspx");
        }

    }
}
