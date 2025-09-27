<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Renewals.aspx.cs" Inherits="PolicyPortalWebApp1.Renewals" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Policy Renewals</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f9ebfe;
            margin: 0;
        }

        .topbar {
            background-color: #6b2384;
            color: white;
            padding: 12px 25px;
            font-size: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .container {
            padding: 30px;
        }

        h2 {
            color: #6b2384;
            margin-bottom: 20px;
        }

        .btn {
            background-color: #6b2384;
            color: #ffffff;
            padding: 6px 14px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
        }

        .gridview {
            margin-top: 20px;
            width: 100%;
            border-collapse: collapse;
        }

        .gridview th, .gridview td {
            padding: 10px;
            border: 1px solid #ccc;
        }

        .gridview th {
            background-color: #d89dec;
            color: #6b2384;
            text-align: left;
        }

        .gridview tr:nth-child(even) {
            background-color: #f9ebfe;
        }

        .gridview tr:nth-child(odd) {
            background-color: #ffffff;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="topbar">
            <span><b>Policy Portal - Renewals</b></span>
            <asp:Button ID="btnBack" runat="server" Text="Back to Dashboard" CssClass="btn" OnClick="btnBack_Click" />
        </div>

        <div class="container">
            <h2>Expiring or Expired Policies</h2>
            <asp:GridView ID="gvRenewals" runat="server" AutoGenerateColumns="False" CssClass="gridview" OnRowCommand="gvRenewals_RowCommand">
                <Columns>
                    <asp:BoundField DataField="PolicyID" HeaderText="Policy ID" />
                    <asp:BoundField DataField="PolicyName" HeaderText="Policy Name" />
                    <asp:BoundField DataField="EndDate" HeaderText="End Date" DataFormatString="{0:dd-MMM-yyyy}" />
                    <asp:BoundField DataField="AssignedTo" HeaderText="Assigned To" />
                    <asp:BoundField DataField="PremiumAmount" HeaderText="Premium Amount" DataFormatString="{0:C}" />
                    <asp:BoundField DataField="Remarks" HeaderText="Remarks" />

                    <asp:TemplateField HeaderText="Action">
                        <ItemTemplate>
                            <asp:Button ID="btnRenew" runat="server" Text="Renew" CommandName="RenewPolicy"
                                CommandArgument='<%# Eval("PolicyID") %>' CssClass="btn"
                                Visible='<%# Session["Role"] != null && Session["Role"].ToString() == "Underwriter" %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </form>
</body>
</html>
