<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="PolicyPortalWebApp1._Default" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Policy Dashboard</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />

    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f3f0ff;
            margin: 0;
            padding: 0;
        }

        .topbar {
            background-color: #6b2384;
            color: white;
            padding: 10px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .topbar span {
            font-size: 18px;
            font-weight: bold;
        }

        .btn {
            background-color: white;
            color: #6b2384;
            font-weight: bold;
            padding: 8px 16px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
        }

        .icon-button {
            font-size: 20px;
            background: transparent;
            border: none;
            color: white;
            margin-left: 12px;
            cursor: pointer;
            text-decoration: none;
        }

        .icon-button i {
            transition: color 0.3s;
        }

        .icon-button:hover i {
            color: #ccc;
        }

        .search-bar {
            background-color: #ede3ff;
            padding: 15px 20px;
            display: flex;
            gap: 10px;
        }

        .search-bar input {
            padding: 8px;
            border-radius: 8px;
            border: 1px solid #aaa;
            width: 220px;
        }

        .dashboard-title {
            font-size: 20px;
            color: #6b2384;
            font-weight: bold;
            margin: 20px;
        }

        .grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(230px, 1fr));
            gap: 20px;
            padding: 0 20px 40px;
        }

        .card {
            background-color: white;
            border: 2px solid #a076cc;
            border-radius: 12px;
            padding: 15px;
            box-shadow: 0 0 8px rgba(160, 118, 204, 0.2);
        }

        .footer {
            background-color: #e0d6f5;
            text-align: center;
            padding: 15px;
            font-size: 13px;
            color: #6b2384;
        }

        .menu-overlay {
            position: fixed;
            top: 0;
            right: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(30, 15, 60, 0.95);
            color: white;
            z-index: 999;
            display: none;
            justify-content: center;
            align-items: center;
        }

        .menu-content {
            background-color: #fff;
            padding: 40px;
            border-radius: 10px;
            width: 300px;
            color: #6b2384;
            text-align: center;
            box-shadow: 0 0 15px rgba(255, 255, 255, 0.2);
            position: relative;
        }

        .menu-content .close-btn {
            background: transparent;
            border: none;
            font-size: 26px;
            color: #6b2384;
            position: absolute;
            top: 20px;
            right: 20px;
            cursor: pointer;
        }

        .overlay-menu-item {
            margin: 15px 0;
        }

        .overlay-menu-item a {
            text-decoration: none;
            font-size: 18px;
            color: #6b2384;
            font-weight: bold;
        }

        .overlay-menu-item a:hover {
            color: #a076cc;
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">

        <!-- Top bar -->
        <div class="topbar">
            <span>Policy Portal</span>
            <div>
                <asp:Label ID="lblUser" runat="server" />
                &nbsp;
                <asp:LinkButton ID="btnReports" runat="server" OnClick="btnReports_Click" CssClass="icon-button" ToolTip="Reports">
                    <i class="fas fa-file-download"></i>
                </asp:LinkButton>
                <button type="button" class="btn" onclick="toggleMenu()">☰</button>
                <asp:Button ID="btnLogout" runat="server" Text="Logout" CssClass="btn" OnClick="btnLogout_Click" />
            </div>
        </div>

        <!-- Overlay Menu -->
        <div id="menuOverlay" class="menu-overlay">
            <div class="menu-content">
                <button type="button" class="close-btn" onclick="toggleMenu()">×</button>
                <asp:Repeater ID="rptMenuItems" runat="server">
                    <ItemTemplate>
                        <div class="overlay-menu-item">
                            <a href='<%# Eval("Url") %>'><%# Eval("Text") %></a>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>

        <!-- Search Bar -->
        <div class="search-bar">
            <asp:TextBox ID="txtPolicyName" runat="server" placeholder="Search by Policy Name" />
            <asp:TextBox ID="txtStartDate" runat="server" placeholder="Search by Start Date (yyyy-mm-dd)" />
            <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn" OnClick="btnSearch_Click" />
            <asp:Button ID="btnReset" runat="server" Text="Reset" CssClass="btn" OnClick="btnReset_Click" />
        </div>

        <!-- Dashboard Title -->
        <div class="dashboard-title">
            Policies Based on <asp:Label ID="lblRole" runat="server" />
        </div>

        <!-- Grid of Policies -->
        <div class="grid">
            <asp:Repeater ID="rptPolicies" runat="server">
                <ItemTemplate>
                    <div class="card">
                        <b>PolicyName:</b> <%# Eval("PolicyName") %><br />
                        <b>PolicyID:</b> <%# Eval("PolicyID") %><br />
                        <b>PremiumAmount:</b> ₹<%# Eval("PremiumAmount") %><br />
                        <b>StartDate:</b> <%# Eval("StartDate", "{0:dd-MMM-yyyy}") %><br />
                        <b>EndDate:</b> <%# Eval("EndDate", "{0:dd-MMM-yyyy}") %><br />
                        <b>Assigned To:</b> <%# Eval("AssignedTo") %><br />
                        <b>Renewed On:</b> <%# Eval("RenewedOn", "{0:dd-MMM-yyyy}") %>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>

        <!-- Footer -->
        <div class="footer">
            Created by Aditi Agarwal (aditi.agarwal2@dxc.com)<br />
            © 2025 DXC Technology
        </div>
    </form>

    <script type="text/javascript">
        function toggleMenu() {
            var menu = document.getElementById("menuOverlay");
            menu.style.display = (menu.style.display === "flex") ? "none" : "flex";
        }
    </script>
</body>
</html>
