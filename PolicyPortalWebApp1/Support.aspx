<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Support.aspx.cs" Inherits="PolicyPortalWebApp1.Support" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Support - Policy Portal</title>
    <style>
        body {
            background-color: #f9ebfe;
            font-family: 'Segoe UI', sans-serif;
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

        .container {
            margin: 40px auto;
            max-width: 750px;
            padding: 30px;
            background-color: #ffffff;
            border-radius: 12px;
            border: 2px solid #d89dec;
            color: #333;
        }

        h2 {
            color: #6b2384;
        }

        ul {
            line-height: 1.8;
            padding-left: 20px;
        }

        .btn, .btnSubmit {
            background-color: #6b2384;
            color: white;
            padding: 8px 16px;
            border: none;
            border-radius: 6px;
            font-weight: bold;
            cursor: pointer;
        }

        .form-field {
            margin-bottom: 15px;
        }

        .form-field label {
            display: block;
            margin-bottom: 6px;
            font-weight: bold;
        }

        .form-field input, .form-field textarea {
            width: 100%;
            padding: 8px;
            border-radius: 6px;
            border: 1px solid #ccc;
        }

        .success {
            color: green;
            margin-top: 15px;
            font-weight: bold;
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
        <!-- Topbar -->
        <div class="topbar">
            <span>Policy Portal - Support</span>
            <asp:Button ID="btnBack" runat="server" Text="Back to Dashboard" CssClass="btn" OnClick="btnBack_Click" />
        </div>

        <div class="container">
            <h2>Need Help?</h2>
            <ul>
                <li><strong>Email:</strong> support@policyportal.com</li>
                <li><strong>Phone:</strong> +91-9876543210</li>
                <li><strong>Support Hours:</strong> 9 AM – 6 PM IST, Mon–Fri</li>
            </ul>

            <h2 style="margin-top:40px;">Contact Us / Feedback</h2>
            <div class="form-field">
                <label for="txtName">Your Name:</label>
                <asp:TextBox ID="txtName" runat="server" />
            </div>
            <div class="form-field">
                <label for="txtEmail">Your Email:</label>
                <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" />
            </div>
            <div class="form-field">
                <label for="txtSubject">Subject:</label>
                <asp:TextBox ID="txtSubject" runat="server" />
            </div>
            <div class="form-field">
                <label for="txtMessage">Message:</label>
                <asp:TextBox ID="txtMessage" runat="server" TextMode="MultiLine" Rows="4" />
            </div>
            <asp:Button ID="btnSubmit" runat="server" Text="Submit Feedback" CssClass="btnSubmit" OnClick="btnSubmit_Click" />
            <br />
            <asp:Label ID="lblStatus" runat="server" CssClass="success" />
        </div>
        <div class="footer">
            Created by Aditi Agarwal (aditi.agarwal2@dxc.com)<br />
            © 2025 DXC Technology
        </div>
    </form>
</body>
</html>
