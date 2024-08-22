<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="bean.User" %>
<%@ page import="dao.UserDao" %>
<%@ page import="org.mindrot.jbcrypt.BCrypt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Register Action</title>
</head>
<body>
<%
String email = request.getParameter("email");
String password = request.getParameter("password");
String confirmPassword = request.getParameter("confirmPassword");

// Create a UserDao instance
UserDao userDao = new UserDao();

try {
    // Check if the user is trying to register with the admin email
    if ("admin@gmail.com".equals(email)) {
        %>
        <script type="text/javascript">
        alert("Admin cannot register.");
        window.location.href = "register.jsp";
        </script>
        <%
    } else if (password == null || !password.equals(confirmPassword)) {
        // Check if passwords match
        %>
        <script type="text/javascript">
        alert("Passwords do not match. Please try again.");
        window.location.href = "register.jsp";
        </script>
        <%
    } else if (userDao.emailExists(email)) {
        // Check if the email already exists
        %>
        <script type="text/javascript">
        alert("Email already exists. Please login.");
        window.location.href = "login.jsp";
        </script>
        <%
    } else {
        // Hash the password using BCrypt
        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

        // Create a User object
        User user = new User(email, hashedPassword);

        // Register the user
        boolean isRegistered = userDao.registerUser(user);
        if (isRegistered) {
            %>
            <script type="text/javascript">
            alert("Registered successfully. Please login.");
            window.location.href = "login.jsp";
            </script>
            <%
        } else {
            %>
            <script type="text/javascript">
            alert("Registration failed. Please try again later.");
            window.location.href = "register.jsp";
            </script>
            <%
        }
    }
} catch (Exception e) {
    e.printStackTrace();
    %>
    <script type="text/javascript">
    alert("An error occurred: <%= e.getMessage() %>. Please try again later.");
    window.location.href = "register.jsp";
    </script>
    <%
}
%>
</body>
</html>
