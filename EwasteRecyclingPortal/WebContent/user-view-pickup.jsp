<%@ page import="java.sql.*" %>
<%@ page import="ewasteRecycler.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Handle Approve/Disapprove actions
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
            response.sendRedirect("pickup-status.jsp"); // Refresh page after update
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
            font-family: 'Segoe UI', sans-serif;
            background: #0f172a;
            color: white;
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

        table {
            width: 100%;
            border-collapse: collapse;
            color: white;
        }

        th, td {
            padding: 12px;
            border: 1px solid #334155;
        }

        th {
            background-color: #1e293b;
        }

        .btn {
            padding: 6px 12px;
            border: none;
            border-radius: 5px;
            font-weight: bold;
            color: white;
            cursor: pointer;
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
            <th>Status & Actions</th>
        </tr>
        </thead>
        <tbody>
       <tbody>
<%
    boolean hasData = false;
    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ewastedb", "root", "");
        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT * FROM pickup_requests");

        while (rs.next()) {
            hasData = true;
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
        if (!hasData) {
%>
<tr>
    <td colspan="6" style="text-align:center; color:#ccc;">No pickup requests found.</td>
</tr>
<%
        }
        con.close();
    } catch (Exception e) {
%>
<tr>
    <td colspan="6" style="text-align:center; color:red;">Error loading pickup requests: <%= e.getMessage() %></td>
</tr>
<%
    }
%>
</tbody>
