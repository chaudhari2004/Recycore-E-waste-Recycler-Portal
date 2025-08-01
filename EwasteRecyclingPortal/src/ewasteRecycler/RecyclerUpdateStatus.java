package ewasteRecycler;

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class RecyclerUpdateStatus extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        String status = request.getParameter("status");

        try {
            Connection con = DbConnection.Connect();
            PreparedStatement ps = con.prepareStatement("UPDATE pickup_requests SET status = ? WHERE id = ?");
            ps.setString(1, status);
            ps.setInt(2, id);
            ps.executeUpdate();

            response.sendRedirect("recycler-pending-requests.jsp");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
