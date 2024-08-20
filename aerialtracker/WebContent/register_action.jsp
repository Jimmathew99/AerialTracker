<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.servlet.http.*"%>
<%@ page import="org.mindrot.jbcrypt.*"%>
<%@ page import=" dbconnection.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Register Action</title>
</head>
<body>
	<%
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		String confirmPassword = request.getParameter("confirmPassword");
		String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
		Connection con = null;
		PreparedStatement stmt = null;
		try {
		con=	DBconnection.getConnection();
			if (email.equals("admin@gmail.com")) {
	%>
	<script type="text/javascript">
		alert("Admin cannot register.");
		window.location.href = "register.jsp";
	</script>


	<%
		} else {
				PreparedStatement checkStmt = con
						.prepareStatement("SELECT COUNT(*) FROM userregistration WHERE email=? ");
				checkStmt.setString(1, email);
				ResultSet rs = checkStmt.executeQuery();
				rs.next();
				int count = rs.getInt(1);
				if (count > 0) {
	%>
	<script type="text/javascript">
		alert("Email already exists. Please login.");
		window.location.href = "login.jsp";
	</script>
	<%
		} else {
					String sql = "INSERT INTO userregistration(email, password) values(?,?)";
					stmt = con.prepareStatement(sql);
					stmt.setString(1, email);
					stmt.setString(2, hashedPassword);

					int rows = stmt.executeUpdate();
					if (rows > 0) {
	%>
	<script type="text/javascript">
		alert("Registration succesful. Please login.");
		window.location.href = "login.jsp";
	</script>
	<%
		}
					else{
						%>
						<script type="text/javascript">
						alert("Registration failed.Please try again later");
						window.location.href="register.jsp";
						</script>
						<% 
					}
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
			%>
			<script type="text/javascript">
			alert("An error occured.Please try again later");
			window.location.href="register.jsp";
			
			</script>
			<% 
		}
		finally{
			try{
				if(stmt !=null) stmt.close();
				if(con !=null) con.close();
			}
			catch( Exception e){
				e.printStackTrace();
			}
		}
		
	%>


</body>
</html>