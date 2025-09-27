<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="PolicyPortalWebApp1.Login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login - Policy Portal</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(to bottom right, #e0ccf7, #f9ebfe);
            margin: 0;
        }

        .topbar {
            background-color: #6b2384;
            color: white;
            padding: 10px 20px;
            font-size: 18px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .login-box {
            max-width: 400px;
            margin: 60px auto;
            padding: 30px 40px;
            background-color: #f7eaff;
            border: 1px solid #d4b0ff;
            border-radius: 15px;
            box-shadow: 0 0 10px #e0ccf7;
        }

        .login-box h2 {
            color: #6b2384;
            text-align: center;
            margin-bottom: 25px;
        }

        label {
            font-weight: bold;
            color: #6b2384;
        }

        input[type="text"], input[type="password"], select {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            margin-bottom: 15px;
            border-radius: 6px;
            border: 1px solid #e0ccf7;
        }

        .btn {
            width: 100%;
            background-color: #6b2384;
            color: white;
            padding: 10px;
            font-weight: bold;
            border-radius: 6px;
            border: none;
            cursor: pointer;
        }

        .btn:hover {
            background-color: #4e1765;
        }

        .message {
            color: red;
            text-align: center;
            margin-bottom: 10px;
        }

        .footer {
            background-color: #e0d6f5;
            text-align: center;
            padding: 15px;
            font-size: 13px;
            color: #6b2384;
        }

    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="topbar">
    <div>Policy Portal</div>
    <div>
        <asp:Label ID="lblGreeting" runat="server" />
    </div>
        </div>

        <div class="login-box">
            <h2>Login</h2>

            <asp:Label ID="lblMessage" runat="server" CssClass="message" />

            <label for="txtUsername">Username:</label>
            <asp:TextBox ID="txtUsername" runat="server" />

            <label for="txtPassword">Password:</label>
            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" />

            <label for="ddlRole">Select Role:</label>
            <asp:DropDownList ID="ddlRole" runat="server">
                <asp:ListItem Text="-- Select Role --" Value="" />
                <asp:ListItem Text="Admin" Value="Admin" />
                <asp:ListItem Text="Underwriter" Value="Underwriter" />
                <asp:ListItem Text="Viewer" Value="Viewer" />
            </asp:DropDownList>

            <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btn" OnClick="btnLogin_Click" />

            <asp:Button ID="btnForgotPassword" runat="server" Text="Forgot Password?" CssClass="btn" OnClick="btnForgotPassword_Click" Style="margin-top: 10px; background-color: #d89dec; color: #6b2384;" />
        </div>

        <div class="footer">
            Created by Aditi Agarwal (aditi.agarwal2@dxc.com)<br />
            © 2025 DXC Technology
        </div>
    </form>
</body>
</html>
