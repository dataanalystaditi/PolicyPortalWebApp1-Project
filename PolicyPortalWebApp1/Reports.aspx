<%@ Register Assembly="System.Web.DataVisualization" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>
<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Reports.aspx.cs" Inherits="PolicyPortalWebApp1.Reports" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Policy Report Summary</title>
    <style>
        body {
            background-color: #f5edfc;
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
        }

        .page-title {
            color: #6f2dbd;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
        }

        .btn-primary {
            background-color: #6b2384;
            color: white;
            border: none;
            padding: 10px 16px;
            border-radius: 6px;
            cursor: pointer;
        }

        .btn-primary:hover {
            background-color: #53159c;
        }

        .stats-container {
            display: flex;
            justify-content: center;
            gap: 30px;
            margin-bottom: 30px;
        }

        .stat-card {
            background-color: white;
            padding: 20px 40px;
            border-radius: 15px;
            box-shadow: 2px 2px 12px rgba(0,0,0,0.1);
            text-align: center;
        }

        .filters {
            display: flex;
            gap: 10px;
            justify-content: center;
            margin-bottom: 20px;
        }

        .form-control {
            padding: 8px;
            border-radius: 6px;
            border: 1px solid #ccc;
            min-width: 140px;
        }

        .report-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        .report-table th {
            background-color: #6b2384;
            color: white;
            padding: 10px;
        }

        .report-table td {
            padding: 10px;
            border: 1px solid #ccc;
            text-align: center;
        }

        .report-table tr:nth-child(even) {
            background-color: #f9f3fd;
        }

        .actions {
            text-align: right;
            margin-top: 20px;
        }

        .chart-container {
            margin-top: 40px;
            text-align: center;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="header">
            <h2 class="page-title"><b>Policy Report Summary</b></h2>
            <asp:Button ID="btnBack" runat="server" Text="← Back to Dashboard" CssClass="btn-primary" OnClick="btnBack_Click" />
        </div>

        <div class="stats-container">
            <div class="stat-card">
                <h4>Total Policies</h4>
                <h2><asp:Label ID="lblTotalPolicies" runat="server" Text="0" /></h2>
            </div>
            <div class="stat-card">
                <h4>Total Premium</h4>
                <h2>₹<asp:Label ID="lblTotalPremium" runat="server" Text="0" /></h2>
            </div>
            <div class="stat-card">
                <h4>Unique Customers</h4>
                <h2><asp:Label ID="lblUniqueCustomers" runat="server" Text="0" /></h2>
            </div>
        </div>

        <div class="filters">
            <asp:TextBox ID="txtCustomerName" runat="server" CssClass="form-control" Placeholder="Customer Name" />
            <asp:DropDownList ID="ddlPolicyType" runat="server" CssClass="form-control" />
            <asp:TextBox ID="txtStartDate" runat="server" CssClass="form-control" TextMode="Date" />
            <asp:TextBox ID="txtEndDate" runat="server" CssClass="form-control" TextMode="Date" />
            <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn-primary" OnClick="btnSearch_Click" />
        </div>

        <asp:GridView ID="gvReport" runat="server" AutoGenerateColumns="true" CssClass="report-table" />

        <div class="actions">
<asp:Button ID="btnExportExcel" runat="server" Text="Export to Excel" CssClass="btn-primary" OnClick="btnExportExcel_Click" />
<asp:Button ID="btnExportPDF" runat="server" Text="Export to PDF" CssClass="btn-primary" OnClick="btnExportToPDF_Click" />
        </div>

        <div class="chart-container">
            <asp:Chart ID="Chart1" runat="server" Width="900px" Height="400px" Palette="BrightPastel">
                <Titles>
                    <asp:Title Text="Premium Distribution by Customer" Font="Arial, 12pt, style=Bold" />
                </Titles>
                <ChartAreas>
                    <asp:ChartArea Name="ChartArea1">
                        <Area3DStyle Enable3D="True" />
                    </asp:ChartArea>
                </ChartAreas>
                <Series>
                    <asp:Series Name="Premiums" ChartType="Pie" ChartArea="ChartArea1"
                                XValueMember="Name" YValueMembers="PremiumAmount">
                    </asp:Series>
                </Series>
            </asp:Chart>
        </div>
    </form>
</body>
</html>
