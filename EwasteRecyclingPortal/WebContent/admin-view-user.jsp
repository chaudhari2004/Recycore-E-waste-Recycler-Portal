<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Admin Panel - View All Users</title>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
      font-family: 'Poppins', sans-serif;
    }

    body {
      background: linear-gradient(to right, #0f2027, #203a43, #2c5364);
      color: white;
      padding: 40px;
    }

    .container {
      max-width: 1100px;
      margin: auto;
      background: rgba(255, 255, 255, 0.1);
      backdrop-filter: blur(12px);
      -webkit-backdrop-filter: blur(12px);
      padding: 30px;
      border-radius: 20px;
      box-shadow: 0 8px 30px rgba(0, 0, 0, 0.3);
    }

    h2 {
      text-align: center;
      font-size: 30px;
      margin-bottom: 25px;
      color: #ffffff;
      text-shadow: 1px 1px 3px #000;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      background-color: rgba(255, 255, 255, 0.05);
      border-radius: 10px;
      overflow: hidden;
    }

    th, td {
      padding: 14px 18px;
      text-align: center;
      border-bottom: 1px solid rgba(255, 255, 255, 0.1);
      color: #ffffff;
    }

    th {
      background-color: rgba(0, 255, 255, 0.1);
      text-transform: uppercase;
      font-size: 14px;
      letter-spacing: 1px;
    }

    tr:hover {
      background-color: rgba(255, 255, 255, 0.1);
      transition: background 0.3s ease;
    }

    .btn {
      display: inline-block;
      margin-top: 25px;
      background-color: #00c9a7;
      padding: 12px 25px;
      color: white;
      border: none;
      border-radius: 8px;
      text-decoration: none;
      font-weight: 600;
      transition: background-color 0.3s ease;
    }

    .btn:hover {
      background-color: #00a087;
    }

    .error-msg {
      margin-top: 20px;
      background-color: #ff4d4d;
      padding: 12px;
      color: white;
      border-radius: 8px;
      text-align: center;
    }

    @media screen and (max-width: 768px) {
      table, th, td {
        font-size: 12px;
        padding: 8px;
      }

      .container {
        padding: 20px;
      }
    }
  </style>
</head>
<body>

  <div class="container">
    <h2>👤 All Registered Users</h2>

    <%
      Connection con = null;
      PreparedStatement ps = null;
      ResultSet rs = null;

      try {
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ewastedb", "root", "");

        String query = "SELECT * FROM user";
        ps = con.prepareStatement(query);
        rs = ps.executeQuery();
    %>

    <table>
      <tr>
        <th>User ID</th>
        <th>Name</th>
        <th>Email</th>
        <th>Contact</th>
        <th>Address</th>
        <th>Password</th>
      </tr>

    <%
      while (rs.next()) {
    %>
      <tr>
        <td><%= rs.getInt("id") %></td>
        <td><%= rs.getString("name") %></td>
        <td><%= rs.getString("email") %></td>
        <td><%= rs.getString("contact") %></td>
        <td><%= rs.getString("address") %></td>
        <td><%= rs.getString("password") %></td>
      </tr>
    <%
      }
    %>
    </table>

    <%
      } catch (Exception e) {
    %>
      <div class="error-msg">⚠️ Error: <%= e.getMessage() %></div>
    <%
      } finally {
        try {
          if (rs != null) rs.close();
          if (ps != null) ps.close();
          if (con != null) con.close();
        } catch (SQLException e) {
    %>
      <div class="error-msg">⚠️ Closing error: <%= e.getMessage() %></div>
    <%
        }
      }
    %>

    <a href="admin-panel.html" class="btn">← Back to Admin Dashboard</a>
  </div>

</body>
</html>
