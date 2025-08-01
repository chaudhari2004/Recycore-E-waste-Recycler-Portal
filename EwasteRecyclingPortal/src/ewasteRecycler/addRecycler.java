package ewasteRecycler;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.http.*;

public class addRecycler extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public addRecycler() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int rid = Integer.parseInt(request.getParameter("rid"));
        String rname = request.getParameter("rname");
        String rcontact = request.getParameter("rcontact");
        String rlocation = request.getParameter("rlocation");
      
        String remail = request.getParameter("remail");
        String rpassword = request.getParameter("rpassword");


        try {
            Connection con = DbConnection.Connect(); // Make sure you have this class
            PreparedStatement ps = con.prepareStatement("INSERT INTO recyler VALUES (?, ?, ?, ?, ?, ?)");

            ps.setInt(1, rid);
            ps.setString(2, rname);
            ps.setString(3,  rcontact);
            ps.setString(4, rlocation);
            ps.setString(5, remail);
            ps.setString(6, rpassword);

            int result = ps.executeUpdate();

            if (result > 0) {
                response.getWriter().println("<h2>✅ Recycler Added Successfully!</h2>");
                response.sendRedirect("admin-panel.html");
            } else {
                response.getWriter().println("<h2>❌ Failed to Add Recycler.</h2>");
                response.getWriter().println("<a href='add-recyler.html'>Try Again</a>");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("<h3>Error: " + e.getMessage() + "</h3>");
        }
    }
}