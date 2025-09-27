using PolicyPortalWebApp1;
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace PolicyPortalWebApp1
{
    public partial class InsertPolicy : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Username"] == null)
            {
                Logger.Write("Session Timed Out - Redirected to Login");
                Response.Redirect("Login.aspx");
                return;
            }

            Logger.Write("Insert Policy page opened by " + Session["Username"]/*, "InsertPolicy"*/);
        }


        protected void btnInsert_Click(object sender, EventArgs e)
        {
            lblMessage.Text = "";
            string connStr = ConfigurationManager.ConnectionStrings["PolicyPortalConnectionString"].ToString();

            int policyId;
            if (!int.TryParse(txtPolicyID.Text.Trim(), out policyId) || txtPolicyID.Text.Trim().Length != 5)
            {
                lblMessage.Text = "<span style='color:red;'>❌ Policy ID must be a 5-digit number.</span>";
                return;
            }

            DateTime startDate, endDate;
            if (!DateTime.TryParse(txtStartDate.Text.Trim(), out startDate) ||
                !DateTime.TryParse(txtEndDate.Text.Trim(), out endDate))
            {
                lblMessage.Text = "<span style='color:red;'>❌ Please enter valid Start Date and End Date.</span>";
                return;
            }

            if (endDate <= startDate)
            {
                lblMessage.Text = "<span style='color:red;'>❌ End Date must be later than Start Date.</span>";
                return;
            }

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();

                // Check if Policy ID already exists
                SqlCommand checkCmd = new SqlCommand("SELECT COUNT(*) FROM Policies WHERE PolicyID = @PolicyID", conn);
                checkCmd.Parameters.AddWithValue("@PolicyID", policyId);
                int count = (int)checkCmd.ExecuteScalar();

                SqlCommand cmd;
                if (count == 0)
                {
                    // INSERT
                    cmd = new SqlCommand("INSERT INTO Policies (PolicyID, CustomerID, PolicyTypeID, StartDate, EndDate, PremiumAmount, PolicyName, AssignedTo, CreatedBy) VALUES (@PolicyID, @CustomerID, @PolicyTypeID, @StartDate, @EndDate, @PremiumAmount, @PolicyName, @AssignedTo, @CreatedBy)", conn);
                    lblMessage.Text = "<span style='color:green;'>✅ Policy inserted successfully.</span>";
                }
                else
                {
                    // UPDATE
                    cmd = new SqlCommand("UPDATE Policies SET CustomerID=@CustomerID, PolicyTypeID=@PolicyTypeID, StartDate=@StartDate, EndDate=@EndDate, PremiumAmount=@PremiumAmount, PolicyName=@PolicyName, AssignedTo=@AssignedTo WHERE PolicyID = @PolicyID", conn);
                    lblMessage.Text = "<span style='color:green;'>✅ Policy updated successfully.</span>";
                }

                cmd.Parameters.AddWithValue("@PolicyID", policyId);
                cmd.Parameters.AddWithValue("@CustomerID", txtCustomerID.Text.Trim());
                cmd.Parameters.AddWithValue("@PolicyTypeID", txtPolicyTypeID.Text.Trim());
                cmd.Parameters.AddWithValue("@StartDate", startDate);
                cmd.Parameters.AddWithValue("@EndDate", endDate);
                cmd.Parameters.AddWithValue("@PremiumAmount", txtPremiumAmount.Text.Trim());
                cmd.Parameters.AddWithValue("@PolicyName", txtPolicyName.Text.Trim());
                cmd.Parameters.AddWithValue("@AssignedTo", txtAssignedTo.Text.Trim());
                cmd.Parameters.AddWithValue("@CreatedBy", Session["UserID"]);

                cmd.ExecuteNonQuery();
            }
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            txtCustomerID.Text = txtPolicyTypeID.Text = txtStartDate.Text = txtEndDate.Text =
            txtPremiumAmount.Text = txtPolicyID.Text = txtPolicyName.Text = txtAssignedTo.Text = "";
            lblMessage.Text = "";
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("Default.aspx");
        }

        protected void txtPolicyTypeID_TextChanged(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["PolicyPortalConnectionString"].ToString();
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand("SELECT PolicyName FROM PolicyTypes WHERE PolicyTypeID = @PTID", conn);
                cmd.Parameters.AddWithValue("@PTID", txtPolicyTypeID.Text.Trim());
                conn.Open();
                object result = cmd.ExecuteScalar();
                if (result != null)
                {
                    txtPolicyName.Text = result.ToString();
                }
                else
                {
                    txtPolicyName.Text = "";
                    lblMessage.Text = "<span style='color:red;'>❌ Invalid Policy Type ID.</span>";
                }
            }
        }
    }
}
