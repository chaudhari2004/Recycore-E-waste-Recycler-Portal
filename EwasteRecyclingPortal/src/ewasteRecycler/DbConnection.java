package ewasteRecycler;



import java.sql.Connection;
import java.sql.DriverManager;

public class DbConnection {
   public  static Connection Connect() {
        Connection con = null;
        try {
            // Load MySQL JDBC Driver
            Class.forName("com.mysql.jdbc.Driver");

            
            con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/ewastedb", "root", "");
        } catch (Exception e) {
            System.out.println("not connect...");
        }
        return con;
    }
}
