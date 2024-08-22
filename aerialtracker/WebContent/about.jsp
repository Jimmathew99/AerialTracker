<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>Aerial Tracker</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<meta content="" name="keywords">
<meta content="" name="description">
<link rel="stylesheet" href="https://unpkg.com/leaflet/dist/leaflet.css" />
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<style>
/* Existing styles or override styles can be added here */
</style>
<!-- Favicon -->
<link href="images/airplane.png" rel="icon">

<!-- Google Web Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Roboto:wght@500;700&display=swap"
	rel="stylesheet">

<!-- Icon Font Stylesheet -->
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
	rel="stylesheet">

<!-- Libraries Stylesheet -->
<link href="lib/owlcarousel/assets/owl.carousel.min.css"
	rel="stylesheet">
<link href="lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css"
	rel="stylesheet" />

<!-- Customized Bootstrap Stylesheet -->
<link href="css/bootstrap.min.css" rel="stylesheet">

<!-- Template Stylesheet -->
<link href="css/style.css" rel="stylesheet">

<!-- Additional CSS for landing page -->
<link href="css/landingpage.css" rel="stylesheet">
</head>

<body>
	<%
		HttpSession httpSession = request.getSession(false);
		if (session != null) {
			String email = (String) session.getAttribute("user");
			if (email != null) {

			} else {
				out.println("No email found in session.");
			}
		} else {
			out.println("Session is null.");
		}
	%>
	<div class="container-fluid position-relative d-flex p-0">
		<!-- Sidebar Start -->
		<div id="sidebar" class="sidebar pe-4 pb-3">
			<nav class="navbar bg-secondary navbar-dark">
				<a href="about.jsp" class="navbar-brand mx-4 mb-3">
					<h3 class="text-primary">Aerial Tracker</h3>
				</a>
				<div class="d-flex align-items-center ms-4 mb-4">
					<div class="position-relative">
						<img class="rounded-circle" src="images/user.png" alt=""
							style="width: 40px; height: 40px;">
						<div
							class="bg-success rounded-circle border border-2 border-white position-absolute end-0 bottom-0 p-1"></div>
					</div>
					<div class="ms-3">
						<h6 class="mb-0"><%=(String) session.getAttribute("user")%></h6>

					</div>
				</div>
				<a href="#" class="sidebar-toggler flex-shrink-0"><i
					class="fa fa-bars"></i></a>
				<div class="navbar-nav w-100">
					<a href="index.html" class="nav-item nav-link "><i
						class="fa fa-tachometer-alt me-2"></i>Tracking Map</a> <a
						href="about.jsp" class="nav-item nav-link active"><i
						class="fa fa-laptop me-2"></i>About</a> <a href="logout.jsp"
						class="nav-item nav-link"><i class="fa fa-sign-out-alt me-2"></i>Logout</a>


				</div>
			</nav>
		</div>
		<!-- Sidebar End -->

		<!-- Content Start -->
		<div class="content">
		<div class="container-fluid pt-4 px-4">
    <div class="bg-dark text-light rounded p-4">
        <h1 class="display-4 mb-4" style="color: #EB1616;">About Aerial Tracker</h1>
        <p class="lead mb-4">Welcome to <span style="color: #EB1616;">Aerial Tracker</span>! We specialize in providing real-time tracking solutions for Aircraft. Our platform ensures accurate and timely tracking, helping you stay informed and make better decisions.</p>
        
        <h3 class="mb-3" style="color: #EB1616;">Our Mission</h3>
        <p class="mb-4">Aerial Tracker is a real-time flight tracking web-site that simplifies the process of monitoring aircraft movement. Our platform provides a user-friendly interface for tracking flights, viewing flight routes, and accessing flight data. With Aerial Tracker, users can easily search for flights, view real-time flight status, and access detailed flight information. Our goal is to provide a reliable and easy-to-use platform for aviation enthusiasts, travelers, and industry professionals to track flights and stay informed.</p>

        <h3 class="mb-3" style="color: #EB1616;">About Me</h3>
        <p class="mb-4">I am a passionate developer and aviation enthusiast committed to delivering the best tracking experience. I work tirelessly to ensure that this platform meets the highest standards of performance and reliability.</p>

        <h3 class="mb-3" style="color: #EB1616;">Contact Us</h3>
        <p>If you have any questions or need support, feel free to contact me at<span style="color: #EB1616;"> blackjack1915@gmail.com</span> . I am always happy to help and assist you!</p>
    </div>
</div>
		


			<!-- Footer Start -->
			<div class="container-fluid pt-4 px-4">
				<div class="bg-secondary rounded-top p-4">
					<div class="row">
						<div class="col-12 col-sm-6 text-center text-sm-start">
							&copy; <a href="#">Made with ♥ by Jim</a>, All Rights Reserved.
						</div>
						<div class="col-12 col-sm-6 text-center text-sm-end"></div>
					</div>
				</div>
			</div>
			<!-- Footer End -->
		
		<!-- Content End -->
          </div>
		<!-- JavaScript Libraries -->
		<script src="https://unpkg.com/leaflet/dist/leaflet.js"></script>
		<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
		<script
			src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
		<script src="lib/chart/chart.min.js"></script>
		<script src="lib/easing/easing.min.js"></script>
		<script src="lib/waypoints/waypoints.min.js"></script>
		<script src="lib/owlcarousel/owl.carousel.min.js"></script>
		<script src="lib/tempusdominus/js/moment.min.js"></script>
		<script src="lib/tempusdominus/js/moment-timezone.min.js"></script>
		<script src="lib/tempusdominus/js/tempusdominus-bootstrap-4.min.js"></script>

		<!-- Template Javascript -->
		<script src="js/main.js"></script>

		<!-- Additional JavaScript for functions -->
</body>

</html>