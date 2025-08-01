<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <title>Admin - View Pickup Requests</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      padding: 20px;
      background-color: #f0f0f0;
    }
    h2 {
      color: #2c3e50;
    }
    table {
      width: 100%;
      border-collapse: collapse;
      background-color: white;
      margin-top: 20px;
      box-shadow: 0 0 10px rgba(0,0,0,0.1);
    }
    th, td {
      padding: 10px;
      border: 1px solid #ccc;
      text-align: center;
    }
    th {
      background-color: #34495e;
      color: white;
    }
    .status-pending {
      color: orange;
      font-weight: bold;
    }
    .status-approved {
      color: green;
      font-weight: bold;
    }
    .status-disapproved {
      color: red;
      font-weight: bold;
    }
    .btn {
      margin-top: 20px;
      padding: 10px 20px;
      background-color: #3498db;
      color: white;
      text-decoration: none;
      border-radius: 5px;
      display: inline-block;
    }
    .btn:hover {
      background-color: #2980b9;
    }
  </style>
</head>
<body>

<h2>All Pickup Requests (with User Name)</h2>

<%
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ewastedb", "root", "");

        String query = "";

        ps = con.prepareStatement(query);
        rs = ps.executeQuery();
%>

<table>
  <tr>
    <th>Request ID</th>
    <th>User Name</th>
    <th>Item Type</th>
    <th>Quantity</th>
    <th>Pickup Date</th>
    <th>Status</th>
  </tr>

<%
    boolean hasData = false;
    while (rs.next()) {
        hasData = true;
        String status = rs.getString("status");
        String cssClass = "status-pending";
        if ("Approved".equalsIgnoreCase(status)) cssClass = "status-approved";
        else if ("Disapproved".equalsIgnoreCase(status)) cssClass = "status-disapproved";
%>
  <tr>
    <td><%= rs.getInt("id") %></td>
    <td><%= rs.getString("name") %></td>
    <td><%= rs.getString("itemtype") %></td>
    <td><%= rs.getInt("quantity") %></td>
    <td><%= rs.getString("pickupDate") %></td>
    <td class="<%= cssClass %>"><%= status %></td>
  </tr>
<%
    }

    if (!hasData) {
%>
  <tr>
    <td colspan="6">No pickup requests found.</td>
  </tr>
<%
    }

    } catch (Exception e) {
        out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
    } finally {
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            out.println("<p style='color:red;'>DB Close Error: " + e.getMessage() + "</p>");
        }
    }
%>

</table>

<a href="admin-dashboard.html" class="btn">⬅ Back to Dashboard</a>

</body>
</html>
