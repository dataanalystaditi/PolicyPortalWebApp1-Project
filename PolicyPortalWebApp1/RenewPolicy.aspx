<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RenewPolicy.aspx.cs" Inherits="PolicyPortalWebApp1.RenewPolicy" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Renew Policy</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f9ebfe;
            margin: 0;
        }

        .container {
            max-width: 600px;
            margin: 40px auto;
            background-color: #ffffff;
            border: 1px solid #d89dec;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(107, 35, 132, 0.2);
        }

        h2 {
            color: #6b2384;
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-top: 15px;
            font-weight: bold;
        }

        input[type="text"], input[type="date"], input[type="number"], textarea {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 6px;
        }

        .btn {
            margin-top: 20px;
            background-color: #6b2384;
            color: #ffffff;
            padding: 10px 18px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            margin-right: 10px;
        }

        .msg {
            color: green;
            margin-top: 10px;
        }

        .error {
            color: red;
            margin-top: 10px;
        }

        .info-label {
            font-weight: normal;
            color: #333;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h2>Renew Policy</h2>

            <asp:Label ID="lblPolicyID" runat="server" CssClass="info-label" /><br />

            <label>Current End Date:</label>
            <asp:Label ID="lblCurrentEndDate" runat="server" CssClass="info-label" />

            <label>New End Date:</label>
            <asp:TextBox ID="txtNewEndDate" runat="server" TextMode="Date"></asp:TextBox>

            <label>Premium Amount:</label>
            <asp:TextBox ID="txtPremiumAmount" runat="server" TextMode="Number"></asp:TextBox>

            <label>Remarks:</label>
            <asp:TextBox ID="txtRemarks" runat="server" TextMode="MultiLine" Rows="4"></asp:TextBox>

            <asp:Button ID="btnSubmit" runat="server" CssClass="btn" Text="Submit Renewal" OnClick="btnSubmit_Click" />
            <asp:Button ID="btnBack" runat="server" CssClass="btn" Text="Back to Renewals" OnClick="btnBack_Click" />

            <br />
            <asp:Label ID="lblMessage" runat="server" CssClass="msg" />
        </div>
    </form>
</body>
</html>
