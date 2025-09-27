using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace PolicyPortalWebApp1
{
    public class PolicyManager
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["Policy_Portal_DB"].ConnectionString;

        public int InsertPolicy(int customerId, int policyTypeId, DateTime startDate, DateTime endDate, decimal premiumAmount, int createdBy)
        {
            int newPolicyId = 0;

            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Policy_Portal_DB"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand("InsertPolicyDetails", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@CustomerID", customerId);
                    cmd.Parameters.AddWithValue("@PolicyTypeID", policyTypeId);
                    cmd.Parameters.AddWithValue("@StartDate", startDate);
                    cmd.Parameters.AddWithValue("@EndDate", endDate);
                    cmd.Parameters.AddWithValue("@PremiumAmount", premiumAmount);
                    cmd.Parameters.AddWithValue("@CreatedBy", createdBy); // added

                    SqlParameter outputId = new SqlParameter("@NewPolicyID", SqlDbType.Int)
                    {
                        Direction = ParameterDirection.Output
                    };
                    cmd.Parameters.Add(outputId);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                    newPolicyId = Convert.ToInt32(outputId.Value);
                }
            }

            return newPolicyId;
        }

    }
}
