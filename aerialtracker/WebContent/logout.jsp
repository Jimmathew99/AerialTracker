<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Logout</title>
</head>
<body>
<%
    // Invalidate the session if it exists
    HttpSession httpSession = request.getSession(false);
    if (session != null) {
        session.invalidate(); // End the session
    }
    response.sendRedirect("index.html");
%>
</body>
</html>
