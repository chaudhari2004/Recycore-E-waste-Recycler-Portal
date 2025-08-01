package ewasteRecycler;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

public class SubmitPickupRequest extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        PrintWriter out = response.getWriter();
        Connection con = null;

        try {
            con = DbConnection.Connect();
            con.setAutoCommit(false);

            // Get form data
            int userid = Integer.parseInt(request.getParameter("userid"));
            String itemName = request.getParameter("itemName");
            String itemCondition = request.getParameter("itemCondition");
            String itemtype = request.getParameter("itemtype");
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            String pickupDate = request.getParameter("pickupDate");
            String status = "Pending";

            // Step 1: Insert into pickup_requests and get generated ID
            String pickupSQL = "INSERT INTO pickup_requests (userid, itemtype, quantity, pickupDate, status) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement psPickup = con.prepareStatement(pickupSQL);
            psPickup.setInt(1, userid);
            psPickup.setString(2, itemtype);
            psPickup.setInt(3, quantity);
            psPickup.setString(4, pickupDate);
            psPickup.setString(5, status);
            int rows1 = psPickup.executeUpdate();

            ResultSet rs = psPickup.getGeneratedKeys();
         
            if (rs.next()) {
         
            } else {
                throw new Exception("Failed to retrieve pickup_request ID");
            }
            int id = 0;
            // Step 2: Insert into items using generated requestId
            String itemSQL = "INSERT INTO items (requestId, itemName, itemCondition) VALUES (?, ?, ?)";
            PreparedStatement psItem = con.prepareStatement(itemSQL);
            psItem.setInt(1, id);
            psItem.setString(2, itemName);
            psItem.setString(3, itemCondition);
            int rows2 = psItem.executeUpdate();
            
           

            if (rows1 > 0 && rows2 > 0) {
           
                response.sendRedirect("user-view-pickup.jsp");
               
            } else {
                con.rollback();
                out.println("<h2 style='color:red;'> Failed to submit pickup request.</h2>");
            }

        } catch (Exception e) {
            e.printStackTrace();
            out.println("<h3 style='color:red;'>Error: " + e.getMessage() + "</h3>");
        } finally {
            try {
                if (con != null) con.close();
            } catch (SQLException e) {
                out.println("<h3>Error closing connection: " + e.getMessage() + "</h3>");
            }
        }
    }
}
