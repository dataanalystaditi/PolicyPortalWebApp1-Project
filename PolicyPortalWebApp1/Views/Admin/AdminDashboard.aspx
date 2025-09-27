<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminDashboard.aspx.cs" Inherits="PolicyPortalWebApp1.Views.Admin.AdminDashboard" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Admin Dashboard</title>
    <style>
        body {
            font-family: Arial;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        .dashboard-container {
            max-width: 800px;
            margin: 50px auto;
            padding: 20px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 0 10px #ccc;
        }

        .welcome-text {
            font-size: 20px;
            font-weight: bold;
            color: #004080;
        }

        .button-container {
            margin-top: 20px;
        }

        .btn-action {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 10px 15px;
            margin-right: 10px;
            font-weight: bold;
            cursor: pointer;
        }

        .btn-action:hover {
            background-color: #0056b3;
        }

        .logout-button {
            background-color: #cc0000;
        }

        .logout-button:hover {
            background-color: #990000;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="dashboard-container">
            <asp:Label ID="lblWelcome" runat="server" CssClass="welcome-text" Text="Welcome, Admin!" />

            <div class="button-container">
                <asp:Button 
                    ID="btnLogout" 
                    runat="server" 
                    Text="Logout" 
                    CssClass="btn-action logout-button" 
                    OnClick="btnLogout_Click" />

                <asp:Button 
                    ID="btnReports" 
                    runat="server" 
                    Text="📊 View Reports" 
                    PostBackUrl="~/Reports.aspx" 
                    CssClass="btn-action" />
            </div>
        </div>
    </form>
</body>
</html>
