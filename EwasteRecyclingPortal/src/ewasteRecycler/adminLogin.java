package ewasteRecycler;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.*;

public class adminLogin extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public adminLogin() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Optional: Print to console for debugging
        System.out.println("email: " + email);
        System.out.println("password: " + password);

     

        if ("vivek@gmail.com".equals(email) && "admin".equals(password)) {
            response.sendRedirect("admin-panel.html"); // Redirect to admin choice/dashboard page
        } else {
            response.getWriter();
            response.getWriter();
        }
    }
}
