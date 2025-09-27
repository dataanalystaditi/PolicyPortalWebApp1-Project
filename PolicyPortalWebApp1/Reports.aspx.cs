using PolicyPortalWebApp1;
using iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.tool.xml;
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.DataVisualization.Charting;
using System.Web.UI.WebControls;
using WebListItem = System.Web.UI.WebControls.ListItem;


namespace PolicyPortalWebApp1
{
    public partial class Reports : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Username"] == null || Session["Role"] == null)
            {
                Logger.Write("Session Timed Out - Redirected to Login");
                Response.Redirect("Login.aspx");
                return;
            }

            Logger.Write("Reports page accessed by " + Session["Username"]/*, "Reports"*/);

            if (!IsPostBack)
            {
                LoadPolicyTypes(); // your custom method
                BindReportData();  // your custom method
            }
        }


        private void LoadPolicyTypes()
        {
            string connStr = ConfigurationManager.ConnectionStrings["PolicyPortalConnectionString"].ToString();
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand("SELECT DISTINCT PolicyTypeID, PolicyName FROM PolicyTypes", conn);
                conn.Open();
                ddlPolicyType.DataSource = cmd.ExecuteReader();
                ddlPolicyType.DataTextField = "PolicyName";
                ddlPolicyType.DataValueField = "PolicyTypeID";
                ddlPolicyType.DataBind();
                ddlPolicyType.Items.Insert(0, new WebListItem("-- All --", ""));
            }
        }

        private void BindReportData()
        {
            string connStr = ConfigurationManager.ConnectionStrings["PolicyPortalConnectionString"].ToString();
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand("GetPolicyReportSummary", conn);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@CustomerName", string.IsNullOrEmpty(txtCustomerName.Text) ? (object)DBNull.Value : txtCustomerName.Text);
                cmd.Parameters.AddWithValue("@PolicyType", string.IsNullOrEmpty(ddlPolicyType.SelectedValue) ? (object)DBNull.Value : ddlPolicyType.SelectedValue);
                cmd.Parameters.AddWithValue("@StartDate", string.IsNullOrEmpty(txtStartDate.Text) ? (object)DBNull.Value : Convert.ToDateTime(txtStartDate.Text));
                cmd.Parameters.AddWithValue("@EndDate", string.IsNullOrEmpty(txtEndDate.Text) ? (object)DBNull.Value : Convert.ToDateTime(txtEndDate.Text));

                conn.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvReport.DataSource = dt;
                gvReport.DataBind();

                lblTotalPolicies.Text = dt.Rows.Count.ToString();
                lblTotalPremium.Text = dt.Compute("SUM(PremiumAmount)", "").ToString();

                int uniqueCustomers = dt.DefaultView.ToTable(true, "Name").Rows.Count;
                lblUniqueCustomers.Text = uniqueCustomers.ToString();

                Chart1.DataSource = dt;
                Chart1.DataBind();
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            BindReportData();
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            // Redirect everyone to the unified role-based dashboard
            Response.Redirect("~/Default.aspx");
        }



        protected void btnExportExcel_Click(object sender, EventArgs e)
        {
            BindReportData(); // reload data

            if (gvReport.Rows.Count == 0)
            {
                Response.Write("<script>alert('No data to export.');</script>");
                return;
            }

            Response.Clear();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachment;filename=PolicyReport.xls"); // 🟢 use .xls
            Response.Charset = "";
            Response.ContentType = "application/vnd.ms-excel"; // 🟢 correct for HTML-based Excel

            StringWriter sw = new StringWriter();
            HtmlTextWriter hw = new HtmlTextWriter(sw);

            gvReport.AllowPaging = false;
            gvReport.DataBind();
            gvReport.RenderControl(hw);

            Response.Output.Write(sw.ToString());
            Response.Flush();
            Response.End();
        }


        public override void VerifyRenderingInServerForm(Control control)
        {
        }

        protected void btnExportToPDF_Click(object sender, EventArgs e)
        {
            BindReportData();

            if (gvReport.Rows.Count == 0)
            {
                Response.Write("<script>alert('No data to export.');</script>");
                return;
            }

            Response.ContentType = "application/pdf";
            Response.AddHeader("content-disposition", "attachment;filename=PolicyReport.pdf");
            Response.Cache.SetCacheability(HttpCacheability.NoCache);

            using (MemoryStream ms = new MemoryStream())
            {
                Document pdfDoc = new Document(PageSize.A4, 10f, 10f, 20f, 10f);
                PdfWriter writer = PdfWriter.GetInstance(pdfDoc, ms);
                pdfDoc.Open();

                Paragraph header = new Paragraph("Policy Portal", FontFactory.GetFont("Arial", 18, Font.BOLD, BaseColor.DARK_GRAY));
                header.Alignment = Element.ALIGN_LEFT;
                header.SpacingAfter = 10f;
                pdfDoc.Add(header);

                Paragraph title = new Paragraph("Policy Report Summary", FontFactory.GetFont("Arial", 16, Font.BOLD, new BaseColor(128, 0, 128)));
                title.Alignment = Element.ALIGN_CENTER;
                title.SpacingAfter = 20f;
                pdfDoc.Add(title);

                PdfContentByte cb = writer.DirectContentUnder;
                BaseFont bf = BaseFont.CreateFont();
                cb.BeginText();
                cb.SetFontAndSize(bf, 50);
                cb.SetColorFill(new BaseColor(230, 230, 230));
                cb.ShowTextAligned(PdfContentByte.ALIGN_CENTER, "Confidential", 300, 400, 45);
                cb.EndText();

                gvReport.AllowPaging = false;
                gvReport.DataBind();
                StringWriter sw = new StringWriter();
                HtmlTextWriter hw = new HtmlTextWriter(sw);
                gvReport.RenderControl(hw);
                StringReader sr = new StringReader(sw.ToString());

                XMLWorkerHelper.GetInstance().ParseXHtml(writer, pdfDoc, sr);

                pdfDoc.NewPage();
                using (MemoryStream chartStream = new MemoryStream())
                {
                    Chart1.SaveImage(chartStream, ChartImageFormat.Png);
                    iTextSharp.text.Image chartImage = iTextSharp.text.Image.GetInstance(chartStream.ToArray());
                    chartImage.Alignment = Element.ALIGN_CENTER;
                    chartImage.ScaleToFit(500f, 300f);
                    pdfDoc.Add(chartImage);
                }

                pdfDoc.Close();

                byte[] bytes = ms.ToArray();
                Response.OutputStream.Write(bytes, 0, bytes.Length);
                Response.Flush();
                Response.End();
            }
        }
    }
}
