<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
    
<%@ page import="java.sql.*" %>
<%@ page import="ewasteRecycler.*" %>
<%
    try {
        int rid = Integer.parseInt(request.getParameter("rid"));

        Connection con = DbConnection.Connect();
        PreparedStatement pstmt = con.prepareStatement("DELETE FROM recyler WHERE rid = ?");
        pstmt.setInt(1, rid);

        int i = pstmt.executeUpdate();

        pstmt.close();
        con.close();

        if (i > 0) {
            response.sendRedirect("viewRecycler.jsp"); 
        } else {
            out.println("<p style='color:red;'>Failed to delete reminder.</p>");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
    }
%>