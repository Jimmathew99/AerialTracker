package dbconnection;



import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBconnection {
	public static final String HOST_ADDRESS = "localhost";
	public static final String PORT_NUMBER = "3306";
	public static final String USERNAME = "root";
	public static final String PASSWORD = "";
	public static final String DATABASE = "aerialtracker";
	
	private static final String URL="jdbc:mysql://"+HOST_ADDRESS+ ":"+PORT_NUMBER+ "/"+DATABASE;
 
	 public static Connection getConnection( ) throws SQLException{
		 try {
			 Class.forName("com.mysql.jdbc.Driver");
			 
			
		} catch (ClassNotFoundException e) {
			System.out.println("Driver not found: " + e.getMessage());
		}
		 return DriverManager.getConnection(URL,USERNAME,PASSWORD);
	 }
}
