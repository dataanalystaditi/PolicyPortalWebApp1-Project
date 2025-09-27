<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Unauthorized.aspx.cs" Inherits="PolicyPortalWebApp1.Unauthorized" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Access Denied</title>
    <style>
        body {
            background-color: #f2e6f9;
            font-family: 'Segoe UI', sans-serif;
            text-align: center;
        }
        .unauth-container {
            background: white;
            padding: 30px;
            border-radius: 12px;
            max-width: 500px;
            margin: 100px auto;
            box-shadow: 0 0 12px rgba(0,0,0,0.2);
            border-top: 6px solid #800080;
        }
        .oops {
            font-size: 64px;
            color: #800080;
            font-weight: bold;
        }
        .message {
            margin-top: 20px;
            font-size: 18px;
            color: #800000;
        }
        .actions {
            margin-top: 30px;
        }
        .actions p {
            font-size: 14px;
            margin: 5px;
        }
        .btn-purple {
            background-color: #800080;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 6px;
            display: inline-block;
            margin-top: 15px;
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
        <div class="unauth-container">
            <div class="oops">Ooops!</div>
            <div class="message">You are not authorized to access this page.</div>

            <div class="actions">
                <p>🔐 Try logging in with a different role</p>
                <p>📞 Contact Admin for access</p>
                <a href="Login.aspx" class="btn-purple">Back to Login</a>
            </div>
        </div>

        <div class="footer">
            Created by Aditi Agarwal (aditi.agarwal2@dxc.com)<br />
            © 2025 DXC Technology
        </div>
    </form>
</body>
</html>
