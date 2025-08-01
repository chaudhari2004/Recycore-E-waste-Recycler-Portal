<%@ page import="java.sql.*" %>
<%@ page import="ewasteRecycler.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Check if recycler is logged in
    Integer rid = (Integer) session.getAttribute("recyclerId");
    if (rid == null) {
        response.sendRedirect("recycler-login.jsp");
        return;
    }

    String rname = "", rcontact = "", rlocation = "", remail = "";

    try {
        Connection conn = DbConnection.Connect();
        PreparedStatement pst = conn.prepareStatement("SELECT * FROM recyler WHERE rid = ?");
        pst.setInt(1, rid);
        ResultSet rs = pst.executeQuery();

        if (rs.next()) {
            rname = rs.getString("rname");
            rcontact = rs.getString("rcontact");
            rlocation = rs.getString("rlocation");
            remail = rs.getString("remail");
        }
        conn.close();
    } catch (Exception e) {
        out.println("<p style='color:red;'>Error loading profile: " + e.getMessage() + "</p>");
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Recycler Profile</title>
    <style>
        body {
            background-color: #f8fafc;
            font-family: 'Segoe UI', sans-serif;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 700px;
            margin: 50px auto;
            background-color: #ffffff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 2px 10px rgba(0, 0, 0, 0.1);
        }

        h1 {
            text-align: center;
            color: #1e3a8a;
            margin-bottom: 30px;
        }

        .profile-info {
            font-size: 1.1rem;
            line-height: 2;
        }

        .label {
            font-weight: bold;
            color: #0f172a;
        }

        .footer {
            text-align: center;
            margin-top: 40px;
            color: #64748b;
        }

        .btn-back {
            display: inline-block;
            margin-top: 20px;
            background-color: #1d4ed8;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 6px;
            font-weight: bold;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>My Profile</h1>

    <div class="profile-info">
        <p><span class="label">Name:</span> <%= rname %></p>
        <p><span class="label">Email:</span> <%= remail %></p>
        <p><span class="label">Contact:</span> <%= rcontact %></p>
        <p><span class="label">Location:</span> <%= rlocation %></p>
    </div>

    <div style="text-align:center;">
        <a href="recycler-dashboard.html" class="btn-back">← Back to Dashboard</a>
    </div>
</div>

<div class="footer">
    &copy; 2025 Recycore | Recycler Profile
</div>
</body>
</html>
