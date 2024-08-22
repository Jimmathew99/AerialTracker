<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Forgot Password</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            background-color: #000;
            color: #fff;
        }
        .card {
            border: none;
            border-radius: 8px;
            background-color: #333;
            padding: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }
        .form-control {
            background-color: #555;
            border: 1px solid #444;
            color: #fff;
        }
        .form-control:focus {
            background-color: #555;
            border-color: #777;
            box-shadow: none;
        }
        .btn {
            background-color: #007bff;
            color: #fff;
            border: none;
        }
        .btn:hover {
            background-color: #0056b3;
        }
        .invalid-feedback {
            color: #dc3545;
            display: none; /* Hide by default */
        }
        .form-control.is-invalid {
            border-color: #dc3545;
        }
        .login-link {
            display: block;
            text-align: center;
            margin-top: 15px;
            color: #007bff;
            text-decoration: none;
        }
        .login-link:hover {
            text-decoration: underline;
        }
    </style>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
    <div class="container mt-5">
        <div class="row d-flex justify-content-center">
            <div class="col-md-6">
                <div class="card">
                    <form action="forgot_password_action.jsp" method="POST" onsubmit="return validateForgotPasswordForm();">
                        <div class="mb-3">
                            <label for="email" class="form-label">Email address</label>
                            <input type="email" class="form-control" id="email" name="email">
                            <div id="emailError" class="invalid-feedback"></div>
                        </div>
                        <div class="mb-3">
                            <label for="password" class="form-label">New Password</label>
                            <div class="input-group">
                                <input type="password" class="form-control" id="password" name="password">
                                <span class="input-group-text" onclick="togglePasswordVisibility('password', 'togglePassword')">
                                    <i id="togglePassword" class="bi bi-eye"></i>
                                </span>
                            </div>
                            <div id="passwordError" class="invalid-feedback"></div>
                        </div>
                        <button type="submit" class="btn w-100">Submit</button>
                        <a href="login.jsp" class="login-link">Back to Login</a>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        function validateForgotPasswordForm() {
            var emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            var passwordPattern = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}$/; // Must include at least one uppercase letter, one lowercase letter, one digit, and one special character, with a minimum length of 8 characters.
            var email = document.getElementById("email").value;
            var password = document.getElementById("password").value;

            // Clear previous error messages
            document.getElementById("emailError").style.display = "none";
            document.getElementById("passwordError").style.display = "none";
            document.getElementById("email").classList.remove("is-invalid");
            document.getElementById("password").classList.remove("is-invalid");

            if (!email) {
                document.getElementById("emailError").textContent = "Please enter your email ID";
                document.getElementById("emailError").style.display = "block";
                document.getElementById("email").classList.add("is-invalid");
                document.getElementById("email").focus();
                return false;
            } else if (!emailPattern.test(email)) {
                document.getElementById("emailError").textContent = "Please enter a valid email ID";
                document.getElementById("emailError").style.display = "block";
                document.getElementById("email").classList.add("is-invalid");
                document.getElementById("email").focus();
                return false;
            }

            if (!password) {
                document.getElementById("passwordError").textContent = "Please enter a new password";
                document.getElementById("passwordError").style.display = "block";
                document.getElementById("password").classList.add("is-invalid");
                document.getElementById("password").focus();
                return false;
            } else if (!passwordPattern.test(password)) {
                document.getElementById("passwordError").textContent = "Password must be at least 8 characters long and include at least one uppercase letter, one lowercase letter, one digit, and one special character.";
                document.getElementById("passwordError").style.display = "block";
                document.getElementById("password").classList.add("is-invalid");
                document.getElementById("password").focus();
                return false;
            }

            return true;
        }

        function togglePasswordVisibility(id, toggleId) {
            var passwordField = document.getElementById(id);
            var toggleIcon = document.getElementById(toggleId);
            if (passwordField.type === "password") {
                passwordField.type = "text";
                toggleIcon.classList.remove("bi-eye");
                toggleIcon.classList.add("bi-eye-slash");
            } else {
                passwordField.type = "password";
                toggleIcon.classList.remove("bi-eye-slash");
                toggleIcon.classList.add("bi-eye");
            }
        }
    </script>
</body>
</html>
