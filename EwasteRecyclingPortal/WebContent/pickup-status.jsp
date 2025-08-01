<%@ page import="java.sql.*" %>
<%@ page import="ewasteRecycler.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Pickup Request Status</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: #f1f5f9;
            padding: 30px;
            margin: 0;
        }

        h1 {
            text-align: center;
            color: #0f172a;
            margin-bottom: 30px;
        }

        .status-section {
            margin-bottom: 40px;
        }

        h2 {
            color: #1e40af;
            border-left: 4px solid #1d4ed8;
            padding-left: 10px;
            margin-bottom: 15px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 10px;
        }

        th, td {
            border: 1px solid #cbd5e1;
            padding: 10px;
            text-align: left;
        }

        th {
            background-color: #e2e8f0;
        }

        .no-data {
            text-align: center;
            color: #64748b;
            font-style: italic;
        }

        .footer {
            text-align: center;
            margin-top: 40px;
            color: #94a3b8;
            font-size: 0.9rem;
        }

        .back-btn {
            display: inline-block;
            margin-bottom: 30px;
            background-color: #1d4ed8;
            color: white;
            padding: 10px 18px;
            text-decoration: none;
            border-radius: 5px;
            font-weight: bold;
        }
    </style>
</head>
<body>

    <h1>Your Pickup Request Status</h1>
    <div style="text-align:center;">
       

<%
    Connection conn = null;
    try {
        conn = DbConnection.Connect();
        String[] statuses = {"Pending", "Approved", "Disapproved"};

        for (String status : statuses) {
%>
    <div class="status-section">
        <h2><%= status %> Requests</h2>
        <table>
            <thead>
                <tr>
                    <th>Request ID</th>
                    <th>User ID</th>
                    <th>Item Type</th>
                    <th>Quantity</th>
                    <th>Pickup Date</th>
                </tr>
            </thead>
            <tbody>
            <%
                PreparedStatement ps = conn.prepareStatement(
                    "SELECT * FROM pickup_requests WHERE status = ?"
                );
                ps.setString(1, status);
                ResultSet rs = ps.executeQuery();

                boolean hasData = false;
                while (rs.next()) {
                    hasData = true;
            %>
                <tr>
                    <td><%= rs.getInt("id") %></td>
                    <td><%= rs.getInt("userid") %></td>
                    <td><%= rs.getString("itemtype") %></td>
                    <td><%= rs.getInt("quantity") %></td>
                    <td><%= rs.getString("pickupDate") %></td>
                </tr>
            <%
                }
                if (!hasData) {
            %>
                <tr>
                    <td colspan="5" class="no-data">No <%= status %> requests found.</td>
                </tr>
            <%
                }
                rs.close();
                ps.close();
            %>
            </tbody>
        </table>
    </div>
<%
        } // end for loop
        conn.close();
    } catch (Exception e) {
%>
    <p style="color:red; text-align:center;">Error: <%= e.getMessage() %></p>
<%
    }
%>

    <div class="footer">
        &copy; 2025 Recycore | Pickup Status Panel
    </div>
</body>
</html>
