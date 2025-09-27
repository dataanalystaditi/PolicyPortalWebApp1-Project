<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="InsertPolicy.aspx.cs" Inherits="PolicyPortalWebApp1.InsertPolicy" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Insert New Policy</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f9ebfe;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 70%;
            margin: 60px auto;
            padding: 30px 40px;
            background-color: #f7eaff;
            border: 2px solid #d4b0ff;
            border-radius: 20px;
        }

        h2 {
            color: #6b2384;
            text-align: center;
            margin-top: 0;
        }

        .top-right-button {
            text-align: right;
            margin-bottom: 10px;
        }

        .top-right-button input {
            background-color: #6b2384;
            color: white;
            padding: 7px 15px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-weight: bold;
        }

        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px 30px;
            margin-top: 20px;
        }

        .form-grid label {
            font-weight: bold;
            color: #4a0072;
        }

        .form-grid input[type="text"],
        .form-grid input[type="date"] {
            padding: 6px;
            width: 100%;
            border-radius: 6px;
            border: 1px solid #ccc;
        }

        .button-container {
            text-align: center;
            margin-top: 25px;
        }

        .action-button {
            background-color: #6b2384;
            color: white;
            padding: 10px 18px;
            margin: 5px;
            border: none;
            border-radius: 6px;
            font-weight: bold;
            cursor: pointer;
        }

        .footer {
            background-color: #e0d6f5;
            text-align: center;
            padding: 15px;
            font-size: 13px;
            color: #6b2384;
        }

        .success {
            color: green;
            font-weight: bold;
        }

        .error {
            color: red;
            font-weight: bold;
        }
    </style>

    <script type="text/javascript">
        function fillPolicyName() {
            var typeId = document.getElementById('<%= txtPolicyTypeID.ClientID %>').value;
            var nameBox = document.getElementById('<%= txtPolicyName.ClientID %>');
            switch (typeId) {
                case "1": nameBox.value = "Life Insurance"; break;
                case "2": nameBox.value = "Health Insurance"; break;
                case "3": nameBox.value = "Vehicle Insurance"; break;
                case "4": nameBox.value = "Travel Insurance"; break;
                case "5": nameBox.value = "Home Insurance"; break;
                default: nameBox.value = "";
            }
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="top-right-button">
                <asp:Button ID="btnBack" runat="server" Text="Back to Dashboard" OnClick="btnBack_Click" />
            </div>

            <h2>Insert New Policy</h2>

            <div class="form-grid">
                <div>
                    <label for="txtCustomerID">Customer ID:</label>
                    <asp:TextBox ID="txtCustomerID" runat="server" />
                </div>

                <div>
                    <label for="txtPolicyID">Policy ID:</label>
                    <asp:TextBox ID="txtPolicyID" runat="server" />
                </div>

                <div>
                    <label for="txtPolicyTypeID">Policy Type ID:</label>
                    <asp:TextBox ID="txtPolicyTypeID" runat="server" AutoPostBack="true" OnTextChanged="txtPolicyTypeID_TextChanged" onkeyup="fillPolicyName()" />
                </div>

                <div>
                    <label for="txtPolicyName">Policy Name:</label>
                    <asp:TextBox ID="txtPolicyName" runat="server" ReadOnly="true" />
                </div>

                <div>
                    <label for="txtStartDate">Start Date (YYYY-MM-DD):</label>
                    <asp:TextBox ID="txtStartDate" runat="server" TextMode="Date" />
                </div>

                <div>
                    <label for="txtEndDate">End Date (YYYY-MM-DD):</label>
                    <asp:TextBox ID="txtEndDate" runat="server" TextMode="Date" />
                </div>

                <div>
                    <label for="txtPremiumAmount">Premium Amount:</label>
                    <asp:TextBox ID="txtPremiumAmount" runat="server" />
                </div>

                <div>
                    <label for="txtAssignedTo">Assigned To (User ID):</label>
                    <asp:TextBox ID="txtAssignedTo" runat="server" />
                </div>
            </div>

            <div class="button-container">
                <asp:Button ID="btnInsert" runat="server" Text="Insert Policy" CssClass="action-button" OnClick="btnInsert_Click" />
                <asp:Button ID="btnClear" runat="server" Text="Clear Response" CssClass="action-button" OnClick="btnClear_Click" />
            </div>

            <br />
            <asp:Label ID="lblMessage" runat="server" EnableViewState="false" />
        </div>

        <div class="footer">
            Created by Aditi Agarwal (aditi.agarwal2@dxc.com)<br />
            © 2025 DXC Technology
        </div>
    </form>
</body>
</html>
