package ewasteRecycler;

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class RecyclerLogin extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            Connection con = DbConnection.Connect();
            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM recyler WHERE remail = ? AND rpassword = ?"
            );
            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                // Set session
                HttpSession session = request.getSession();
                session.setAttribute("recyclerId", rs.getInt("rid"));
                session.setAttribute("recyclerName", rs.getString("rname"));

                response.sendRedirect("recycler-dashboard.html");
            } else {
                PrintWriter out = response.getWriter();
                out.println("<h3 style='color:red;'>Invalid email or password!</h3>");
                out.println("<a href='recycler-login.html'>Try Again</a>");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
