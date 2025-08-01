<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="ewasteRecycler.*" %>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>View Recyclers | Admin Panel</title>
  <style>
    body {
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background: linear-gradient(to right, #0f2027, #203a43, #2c5364);
      margin: 0;
      padding: 20px;
      color: white;
    }

    h2 {
      text-align: center;
      margin-bottom: 30px;
      font-size: 28px;
      color: #fff;
    }

    .container {
      max-width: 1000px;
      margin: auto;
      background: rgba(255, 255, 255, 0.1);
      padding: 20px;
      border-radius: 15px;
      box-shadow: 0 0 20px rgba(0, 0, 0, 0.4);
    }

    table {
      width: 100%;
      border-collapse: collapse;
      margin-top: 10px;
    }

    th, td {
      padding: 12px 15px;
      text-align: left;
      border-bottom: 1px solid #ddd;
      color: #fff;
    }

    th {
      background-color: rgba(0, 255, 255, 0.1);
      text-transform: uppercase;
    }

    tr:hover {
      background-color: rgba(255, 255, 255, 0.1);
    }

    a.delete-btn {
      color: #ff4d4d;
      text-decoration: none;
      font-weight: bold;
      padding: 6px 10px;
      border: 1px solid #ff4d4d;
      border-radius: 5px;
      transition: 0.3s;
    }

    a.delete-btn:hover {
      background-color: #ff4d4d;
      color: white;
    }

    .back-link {
      display: inline-block;
      margin-top: 20px;
      color: #ccc;
      text-decoration: none;
      font-size: 14px;
      transition: color 0.3s;
    }

    .back-link:hover {
      color: #fff;
    }

    .error-msg {
      background: #ff4d4d;
      color: white;
      padding: 10px;
      border-radius: 5px;
      margin-top: 15px;
    }

  </style>
</head>
<body>

  <div class="container">
    <h2> Registered Recyclers</h2>

    <table>
      <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Contact</th>
        <th>Location</th>
        <th>Email</th>
        <th>Password</th>
        <th>Action</th>
      </tr>

      <%
        try {
          Class.forName("com.mysql.jdbc.Driver");
          Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ewastedb", "root", "");
          PreparedStatement pstmt = con.prepareStatement("SELECT * FROM recyler");
          ResultSet rs = pstmt.executeQuery();

          while (rs.next()) {
      %>
      <tr>
        <td><%= rs.getInt("rid") %></td>
        <td><%= rs.getString("rname") %></td>
        <td><%= rs.getString("rcontact") %></td>
        <td><%= rs.getString("rlocation") %></td>
        <td><%= rs.getString("remail") %></td>
        <td><%= rs.getString("rpassword") %></td>
        <td><a class="delete-btn" href="Recycler-Delete.jsp?rid=<%= rs.getInt("rid") %>">Delete</a></td>
      </tr>
      <%
          }

        } catch (Exception e) {
      %>
        <tr>
          <td colspan="7" class="error-msg">Error: <%= e.getMessage() %></td>
        </tr>
      <%
        }
      %>
    </table>

    <a href="admin-panel.html" class="back-link">Back to Admin Dashboard</a>
  </div>

</body>
</html>
