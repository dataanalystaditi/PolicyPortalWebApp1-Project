<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ForgotPassword.aspx.cs" Inherits="PolicyPortalWebApp1.ForgotPassword" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Forgot Password</title>
    <style>
        body {
            background-color: #f3e6ff;
            font-family: 'Segoe UI', sans-serif;
        }

        .container {
            max-width: 400px;
            margin: 100px auto;
            padding: 30px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }

        h2 {
            color: #800080;
            text-align: center;
        }

        label, input, button {
            display: block;
            width: 100%;
            margin-bottom: 15px;
        }

        .btn-primary {
            background-color: #800080;
            color: white;
            border: none;
            padding: 10px;
            border-radius: 6px;
            cursor: pointer;
        }

        .back-link {
            text-align: center;
            margin-top: 20px;
        }

        .back-link a {
            color: #800080;
            text-decoration: none;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h2>Forgot Password</h2>

            <asp:Label ID="lblEmail" runat="server" Text="Enter your registered Email ID"></asp:Label>
            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control"></asp:TextBox>

            <asp:Button ID="btnReset" runat="server" Text="Send Reset Link" CssClass="btn-primary" OnClick="btnReset_Click" />

            <asp:Label ID="lblMessage" runat="server" ForeColor="Red" />

            <div class="back-link">
                <a href="Login.aspx">Back to Login</a>
            </div>
        </div>
    </form>
</body>
</html>
