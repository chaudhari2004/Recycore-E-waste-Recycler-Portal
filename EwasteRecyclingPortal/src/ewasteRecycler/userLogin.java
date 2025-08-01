package ewasteRecycler;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class userLogin extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public userLogin() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            con = DbConnection.Connect();

            String sql = "SELECT * FROM user WHERE email = ? AND password = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, email);
            pstmt.setString(2, password);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                int id = rs.getInt("id");
                GetSet.setId(id);  // Use improved method name

                // Redirect to user panel
                response.sendRedirect("user-panel.html");
            } else {
                // Invalid login
                response.sendRedirect("user-entry.html?error=invalid");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("user-entry.html?error=server");
        } finally {
            try { if (rs != null) rs.close(); } catch (SQLException e) {}
            try { if (pstmt != null) pstmt.close(); } catch (SQLException e) {}
            try { if (con != null) con.close(); } catch (SQLException e) {}
        }
    }
}
