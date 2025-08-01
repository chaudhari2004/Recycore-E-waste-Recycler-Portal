<%@ page import="java.sql.*" %>
<%@ page import="ewasteRecycler.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String requestId = request.getParameter("requestId");
    String action = request.getParameter("action");

    if (requestId != null && action != null) {
        try {
            Connection conn = DbConnection.Connect();
            String newStatus = action.equals("approve") ? "Approved" : "Disapproved";
            PreparedStatement pst = conn.prepareStatement("UPDATE pickup_requests SET status = ? WHERE id = ?");
            pst.setString(1, newStatus);
            pst.setInt(2, Integer.parseInt(requestId));
            pst.executeUpdate();
            conn.close();
            response.sendRedirect("user-view-pickup.jsp");
            return;
        } catch (Exception e) {
            out.println("<script>alert('Status update failed: " + e.getMessage() + "');</script>");
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Recycler Panel - Pickup Requests</title>
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #0f172a;
            color: #fff;
        }
        .container {
            max-width: 1100px;
            margin: auto;
            padding: 40px;
        }
        h1 {
            text-align: center;
            font-size: 2.5rem;
            color: #38bdf8;
            margin-bottom: 2rem;
        }
        .btn-back {
            background-color: #3b82f6;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 6px;
            font-weight: bold;
            display: inline-block;
            margin-bottom: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            color: white;
        }
        th, td {
            padding: 1rem;
            text-align: left;
            border: 1px solid #334155;
        }
        th {
            background-color: #1e293b;
        }
        .btn {
            padding: 5px 10px;
            border: none;
            border-radius: 6px;
            font-weight: bold;
            cursor: pointer;
            color: #fff;
        }
        .approve-btn {
            background-color: #22c55e;
        }
        .reject-btn {
            background-color: #ef4444;
        }
        .footer {
            text-align: center;
            margin-top: 3rem;
            font-size: 0.9rem;
            opacity: 0.7;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Pickup Requests</h1>

    

    <table>
        <thead>
            <tr>
                <th>Request ID</th>
                <th>User ID</th>
                <th>Item Type</th>
                <th>Quantity</th>
                <th>Pickup Date</th>
                <th>Status</th>
            </tr>
        </thead>
        <tbody>
        <%
            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ewastedb", "root", "");
                Statement stmt = con.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT * FROM pickup_requests");

                while (rs.next()) {
                    int id = rs.getInt("id");
        %>
        <tr>
            <td><%= id %></td>
            <td><%= rs.getInt("userid") %></td>
            <td><%= rs.getString("itemtype") %></td>
            <td><%= rs.getInt("quantity") %></td>
            <td><%= rs.getString("pickupDate") %></td>
            <td>
                <%= rs.getString("status") %>
                <form method="post" style="display:inline;">
                    <input type="hidden" name="requestId" value="<%= id %>">
                    <button type="submit" name="action" value="approve" class="btn approve-btn">Approve</button>
                    <button type="submit" name="action" value="reject" class="btn reject-btn">Disapprove</button>
                </form>
            </td>
        </tr>
        <%
                }
                con.close();
            } catch (Exception e) {
        %>
        <tr>
            <td colspan="6" style="text-align:center; color: red;">Error loading pickup requests: <%= e.getMessage() %></td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>

    <div class="footer">
        &copy; 2025 Recycore | Recycler Panel
    </div>
</div>
</body>
</html>
