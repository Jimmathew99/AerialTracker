
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@page import="org.mindrot.jbcrypt.BCrypt"%>
<%@ page import=" dbconnection.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.servlet.http.*"%>
<%@page import="java.sql.PreparedStatement"%>
<%
	String email = request.getParameter("email");
	String password = request.getParameter("password");
	Connection con = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	boolean isValidUser = false;
	try {
		con= DBconnection.getConnection();
		if (email.equals("admin@gmail.com") && password.equals("Admin12@")) {
			HttpSession httpSession = request.getSession();
			httpSession.setAttribute("user", email);
			response.sendRedirect("adminwelcome.jsp");

		} else {
			String sql = "select password from userregistration WHERE email=?";
			stmt = con.prepareStatement(sql);
			stmt.setString(1, email);
			rs = stmt.executeQuery();
			if (rs.next()) {
				String storedHashedpassword = rs.getString("password");
				if (BCrypt.checkpw(password, storedHashedpassword)) {
					HttpSession httpSession = request.getSession();
					httpSession.setAttribute("user", email);
					response.sendRedirect("userwelcome.jsp");

				} else {
					response.sendRedirect("login.jsp?error=1");
				}
			} else {
%>
<script type="text/javascript">
	alert("No account? Create one");
	window.location.href = "register.jsp";
</script>
<%
	}
		}

	} catch (Exception e) {
		out.print("error");

	} finally {
		try {
			if (rs != null)
				rs.close();
			if (stmt != null)
				stmt.close();
			if (con != null)
				con.close();

		} catch (Exception e) {
			out.print("error");
		}
	}
%>