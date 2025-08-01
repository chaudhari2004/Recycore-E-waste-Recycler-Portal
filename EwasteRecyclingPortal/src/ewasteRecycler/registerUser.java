package ewasteRecycler;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

public class registerUser extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Set response type
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        // Get form values
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String address = request.getParameter("address");
        String contact = request.getParameter("contact");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            // Connect to DB
            Connection con = DbConnection.Connect();

            // Insert query
            String query = "INSERT INTO user (id, name, address, contact, email, password) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(query);

            ps.setInt(1, id);
            ps.setString(2, name);
            ps.setString(3, address);
            ps.setString(4, contact);
            ps.setString(5, email);
            ps.setString(6, password);

            int result = ps.executeUpdate();

            if (result > 0) {
                out.println("<h2>✅ Registration Successful!</h2>");
                out.println("<a href='user-login.html'>Click here to Login</a>");
            } else {
                out.println("<h2>❌ Registration Failed.</h2>");
                out.println("<a href='user-registration.html'>Try Again</a>");
            }

            ps.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
            out.println("<h3>Error: " + e.getMessage() + "</h3>");
        }
    }
}
