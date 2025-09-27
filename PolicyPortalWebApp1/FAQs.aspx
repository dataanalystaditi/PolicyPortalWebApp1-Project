<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FAQs.aspx.cs" Inherits="PolicyPortalWebApp1.FAQs" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>FAQs - Policy Portal</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f9ebfe;
            margin: 0;
            padding: 0;
        }

        .topbar {
            background-color: #6b2384;
            color: white;
            padding: 15px 25px;
            font-size: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .accordion-container {
            width: 80%;
            margin: 40px auto;
            background-color: #ffffff;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 0 12px rgba(0, 0, 0, 0.1);
        }

        h2 {
            color: #6b2384;
            text-align: center;
        }

        .accordion {
            background-color: #d89dec;
            color: #000;
            cursor: pointer;
            padding: 14px;
            margin-bottom: 8px;
            width: 100%;
            text-align: left;
            border: none;
            outline: none;
            border-radius: 6px;
            font-weight: bold;
            transition: background-color 0.3s ease;
        }

        .accordion:hover {
            background-color: #c47fe3;
        }

        .panel {
            padding: 0 15px;
            background-color: #f9ebfe;
            display: none;
            overflow: hidden;
            border-left: 4px solid #6b2384;
            margin-bottom: 15px;
            border-radius: 0 0 6px 6px;
        }

        .footer {
            background-color: #e0d6f5;
            text-align: center;
            padding: 15px;
            font-size: 13px;
            color: #6b2384;
        }        }
    </style>
    <script>
        function toggleAccordion(index) {
            var panels = document.getElementsByClassName("panel");
            var accs = document.getElementsByClassName("accordion");

            if (panels[index].style.display === "block") {
                panels[index].style.display = "none";
            } else {
                for (var i = 0; i < panels.length; i++) {
                    panels[i].style.display = "none";
                }
                panels[index].style.display = "block";
            }
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="topbar">
            <span><b>Policy Portal - FAQs</b></span>
            <asp:Button ID="btnBack" runat="server" Text="Back to Dashboard" OnClick="btnBack_Click" CssClass="btn" />
        </div>

        <div class="accordion-container">
            <h2>Frequently Asked Questions</h2>

            <button type="button" class="accordion" onclick="toggleAccordion(0)">What is a policy portal?</button>
            <div class="panel">A policy portal is a centralized web application where users can create, manage, renew, and track insurance policies based on roles.</div>

            <button type="button" class="accordion" onclick="toggleAccordion(1)">Who can insert a new policy?</button>
            <div class="panel">Only Admin users are allowed to insert new policies through the Insert Policy page.</div>

            <button type="button" class="accordion" onclick="toggleAccordion(2)">Who can renew a policy?</button>
            <div class="panel">Only Underwriters can renew assigned policies if they are near expiration.</div>

            <button type="button" class="accordion" onclick="toggleAccordion(3)">What are the different roles?</button>
            <div class="panel">The portal supports Admin (insert/manage), Underwriter (renew/track), and Viewer (read-only access).</div>

            <button type="button" class="accordion" onclick="toggleAccordion(4)">What happens if I enter a duplicate Policy ID?</button>
            <div class="panel">If a Policy ID already exists, the existing policy will be updated instead of inserted again.</div>

            <button type="button" class="accordion" onclick="toggleAccordion(5)">How to export reports?</button>
            <div class="panel">Go to the Reports page and click the Export to Excel or Export to PDF button after applying any filters.</div>
        </div>

        <div class="footer">
            Created by Aditi Agarwal (aditi.agarwal2@dxc.com)<br />
            © 2025 DXC Technology
        </div>
    </form>
</body>
</html>
