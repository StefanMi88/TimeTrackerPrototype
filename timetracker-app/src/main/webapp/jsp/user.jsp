<%@page import="at.jku.timetracker.model.User"%>
<%@page import="at.jku.timetracker.TimeTracker"%>
<%@page import="at.jku.timetracker.model.Project"%>
<%@page import="at.jku.timetracker.database.DatabaseConnector"%>
<%@page import="javax.persistence.Query"%>
<%@page import="java.util.*"%>
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8" />
<link rel="icon" type="image/png" href="img/favicon.ico">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />

<title>Time Tracker SS17</title>

<meta
	content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0'
	name='viewport' />
<meta name="viewport" content="width=device-width" />


<!-- Bootstrap core CSS     -->
<link href="css/bootstrap.min.css" rel="stylesheet" />

<!-- Animation library for notifications   -->
<link href="css/animate.min.css" rel="stylesheet" />

<!--  Light Bootstrap Table core CSS    -->
<link href="css/light-bootstrap-dashboard.css" rel="stylesheet" />


<!--  CSS for Demo Purpose, don't include it in your project     -->
<link href="css/demo.css" rel="stylesheet" />


<!--     Fonts and icons     -->
<link
	href="http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css"
	rel="stylesheet">
<link href='http://fonts.googleapis.com/css?family=Roboto:400,700,300'
	rel='stylesheet' type='text/css'>
<link href="css/pe-icon-7-stroke.css" rel="stylesheet" />

</head>
<body>
	<%
		// Get DB Connection
		DatabaseConnector db;
		if (request.getServletContext().getAttribute(
				TimeTracker.DBConnector) == null) {
			db = new DatabaseConnector();
			request.getServletContext().setAttribute(
					TimeTracker.DBConnector, db);
		} else {
			db = (DatabaseConnector) this.getServletContext().getAttribute(
					TimeTracker.DBConnector);
		}
	%>

	<div class="wrapper">
		<div class="sidebar" data-color="orange"
			data-image="img/sidebar-5.jpg">


			<div class="sidebar-wrapper">
				<div class="logo">
					<a href="tracker" class="simple-text"> Time Tracker </a>
				</div>

				<ul class="nav">
					<li><a href="tracker"> <i class="pe-7s-timer"></i>
							<p>Track Time</p>
					</a></li>
					<li><a href="dashboard"> <i class="pe-7s-graph"></i>
							<p>Dashboard</p>
					</a></li>
					<li><a href="project"> <i class="pe-7s-note2"></i>
							<p>Projects</p>
					</a></li>
					<li class="active"><a href="user"> <i class="pe-7s-user"></i>
							<p>Users</p>
					</a></li>
				</ul>
			</div>
		</div>

		<div class="main-panel">
			<nav class="navbar navbar-default navbar-fixed">
				<div class="container-fluid">
					<div class="navbar-header">
						<button type="button" class="navbar-toggle" data-toggle="collapse"
							data-target="#navigation-example-2">
							<span class="sr-only">Toggle navigation</span> <span
								class="icon-bar"></span> <span class="icon-bar"></span> <span
								class="icon-bar"></span>
						</button>
						<a class="navbar-brand" href="#">Users</a>
					</div>
					<div class="collapse navbar-collapse">
						<ul class="nav navbar-nav navbar-right">
							<li><a href="newuser"
								class="<%User u = (User) this.getServletContext().getAttribute(
												TimeTracker.User);
										if (u.getType().toLowerCase().equals("admin")) {
											out.println("");
										} else {
											out.println("hidden");
										}%>">
									New User </a></li>
							<li><a href="user"> Account </a></li>
							<li><a href="login"> Log out </a></li>
						</ul>
					</div>
				</div>
			</nav>

			<div class="content">
				<div class="container-fluid">
					<div class="row">
						<div class="col-md-8">
							<div class="card">
								<div class="header">
									<h4 class="title">
										Edit Profile of
										<%=request.getAttribute("username")%></h4>
									<p class="category">
										<%
											try {
												 // Display Projects User is assigned to
												db.getEntityManager().getTransaction().begin();
												Query queryProj = db
														.getEntityManager()
														.createNativeQuery(
																"SELECT name FROM project WHERE id IN (SELECT project_id FROM projectmembers WHERE username = ?)",
																Project.class);
												queryProj.setParameter(1, request.getAttribute("username"));
												List<Project> values = queryProj.getResultList();

												if (!values.isEmpty()) {
													out.println("<b>Member of: </b>");
													for (Project p : values) {
														out.println(p.getName() + ", ");
													}
												} else {
													out.println("You're not assigned to any projects yet!");
												}
											} catch (Exception ex) {
												out.println(ex.getMessage());
											} finally {
												db.getEntityManager().getTransaction().commit();
											}
										%>
									</p>
								</div>
								<div class="content">
									<form method="post" action="user">
										<div class="row">
											<div class="col-md-5">
												<div class="form-group">
													<label>Company</label> <input type="text"
														class="form-control" placeholder="Company" name="company"
														id="company" value="<%=request.getAttribute("company")%>">
												</div>
											</div>
											<div class="col-md-3">
												<div class="form-group">
													<label>Username</label> <input type="text"
														disabled="disabled" class="form-control"
														placeholder="Username" name="username" id="username"
														value="<%=request.getAttribute("username")%>">
												</div>
											</div>
											<div class="col-md-4">
												<div class="form-group">
													<label for="exampleInputEmail1">Email address</label> <input
														type="email" class="form-control" placeholder="Email"
														name="email" id="email"
														value="<%=request.getAttribute("email")%>">
												</div>
											</div>
										</div>

										<div class="row">
											<div class="col-md-6">
												<div class="form-group">
													<label>First Name</label> <input type="text"
														class="form-control" placeholder="First Name"
														name="firstname" id="firstname"
														value="<%=request.getAttribute("firstname")%>">
												</div>
											</div>
											<div class="col-md-6">
												<div class="form-group">
													<label>Last Name</label> <input type="text"
														class="form-control" placeholder="Last Name"
														name="lastname" id="lastname"
														value="<%=request.getAttribute("lastname")%>">
												</div>
											</div>
										</div>

										<div class="row">
											<div class="col-md-12">
												<div class="form-group">
													<label>Address</label> <input type="text"
														class="form-control" placeholder="Home Address"
														name="address" id="address"
														value="<%=request.getAttribute("address")%>">
												</div>
											</div>
										</div>

										<div class="row">
											<div class="col-md-4">
												<div class="form-group">
													<label>City</label> <input type="text" class="form-control"
														placeholder="City" name="city" id="city"
														value="<%=request.getAttribute("city")%>">
												</div>
											</div>
											<div class="col-md-4">
												<div class="form-group">
													<label>Country</label> <input type="text"
														class="form-control" placeholder="Country" name="country"
														id="country" value="<%=request.getAttribute("country")%>">
												</div>
											</div>
											<div class="col-md-4">
												<div class="form-group">
													<label>Postal Code</label> <input type="number"
														class="form-control" placeholder="ZIP Code" name="zip"
														id="zip" value="<%=request.getAttribute("zip")%>">
												</div>
											</div>
										</div>

										<div class="row">
											<div class="col-md-12">
												<div class="form-group">
													<label>About Me</label>
													<textarea rows="5" class="form-control"
														placeholder="Here can be your description" name="aboutme"
														id="aboutme"><%=request.getAttribute("aboutme")%></textarea>
												</div>
											</div>
										</div>

										<button type="submit" class="btn btn-info btn-fill pull-right">Update
											Profile</button>
										<div class="clearfix"></div>
									</form>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<footer class="footer">
				<div class="container-fluid">
					<p class="copyright pull-right">
						&copy; 2017 <a href="#">Time Tracker, SE Praktikum SS17</a>
					</p>
				</div>
			</footer>

		</div>
	</div>

</body>

<!--   Core JS Files   -->
<script src="js/jquery-1.10.2.js" type="text/javascript"></script>
<script src="js/bootstrap.min.js" type="text/javascript"></script>

<!--  Checkbox, Radio & Switch Plugins -->
<script src="js/bootstrap-checkbox-radio-switch.js"></script>

<!--  Charts Plugin -->
<script src="js/chartist.min.js"></script>

<!--  Notifications Plugin    -->
<script src="js/bootstrap-notify.js"></script>

<!--  Google Maps Plugin    -->
<script type="text/javascript"
	src="https://maps.googleapis.com/maps/api/js?sensor=false"></script>

<!-- Light Bootstrap Table Core javascript and methods for Demo purpose -->
<script src="js/light-bootstrap-dashboard.js"></script>

<!-- Light Bootstrap Table DEMO methods, don't include it in your project! -->
<script src="js/demo.js"></script>

</html>
