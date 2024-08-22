<%@ page import="bean.User" %>
<%@ page import="dao.UserDao" %>
<%@ page import="org.mindrot.jbcrypt.BCrypt" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Login Action</title>
</head>
<body>
<%
  String email = request.getParameter("email");
  String password = request.getParameter("password");

  try {
    // Check if the user is trying to login as admin
    if ("admin@gmail.com".equals(email) && "Admin@123".equals(password)) {
        HttpSession httpSession = request.getSession();
        httpSession.setAttribute("user", email);
        response.sendRedirect("adminwelcome.jsp");
    } else {
        UserDao userDao = new UserDao();
        
        if (userDao.emailExists(email)) {
            User storedUser = userDao.getUserByEmail(email);

            // Check if the stored password matches the input password
            if (storedUser != null && BCrypt.checkpw(password, storedUser.getPassword())) {
                HttpSession httpSession = request.getSession();
                httpSession.setAttribute("user", email);
                response.sendRedirect("userwelcome.jsp");
            } else {
                %>
                <script type="text/javascript">
                alert("Incorrect password. Please try again.");
                window.location.href = "login.jsp";
                </script>
                <%
            }
        } else {
            %>
            <script type="text/javascript">
            alert("No account found with this email. Please register.");
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
    window.location.href = "login.jsp";
    </script>
    <%
  }
%>


</body>
</html>
