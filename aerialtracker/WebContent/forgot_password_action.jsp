<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.UserDao" %>
<%@ page import="org.mindrot.jbcrypt.BCrypt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Password Reset Action</title>
    <script type="text/javascript">
        function showAlertAndRedirect(message, url) {
            alert(message);
            window.location.href = url;
        }
    </script>
</head>
<body>
    <%
        String email = request.getParameter("email");
        String newPassword = request.getParameter("password");
        UserDao userDao = new UserDao();

        try {
            if (email == null || email.isEmpty() || newPassword == null || newPassword.isEmpty()) {
                %>
                <script type="text/javascript">
                    showAlertAndRedirect("Both email and new password are required.", "forgot_password.jsp");
                </script>
                <%
            } else {
                if (userDao.emailExists(email)) {
                    // Hash the new password
                    String hashedPassword = BCrypt.hashpw(newPassword, BCrypt.gensalt());
                    boolean isUpdated = userDao.updateUserPassword(email, hashedPassword);

                    if (isUpdated) {
                        %>
                        <script type="text/javascript">
                            showAlertAndRedirect("Password updated successfully.", "login.jsp");
                        </script>
                        <%
                    } else {
                        %>
                        <script type="text/javascript">
                            showAlertAndRedirect("Failed to update password. Please try again.", "forgot.jsp");
                        </script>
                        <%
                    }
                } else {
                    %>
                    <script type="text/javascript">
                        showAlertAndRedirect("No account found with this email.", "forgot.jsp");
                    </script>
                    <%
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            %>
            <script type="text/javascript">
                showAlertAndRedirect("An error occurred: <%= e.getMessage() %>. Please try again later.", "forgot_password.jsp");
            </script>
            <%
        }
    %>
</body>
</html>
