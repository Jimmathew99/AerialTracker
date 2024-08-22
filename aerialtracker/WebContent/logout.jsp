<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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
