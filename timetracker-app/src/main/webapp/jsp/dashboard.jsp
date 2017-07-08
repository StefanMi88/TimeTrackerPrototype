<%@page import="javax.swing.text.Document"%>
<%@page import="java.util.concurrent.TimeUnit"%>
<%@page import="com.mysql.jdbc.TimeUtil"%>
<%@page import="at.jku.timetracker.TimeTracker"%>
<%@page import="at.jku.timetracker.database.DatabaseConnector"%>
<%@page import="javax.persistence.Query"%>
<%@page import="at.jku.timetracker.model.Project"%>
<%@page import="at.jku.timetracker.model.Task"%>
<%@page import="at.jku.timetracker.model.Time"%>
<%@page import="at.jku.timetracker.model.User"%>
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
		DatabaseConnector db;
		
		if (request.getServletContext().getAttribute(TimeTracker.DBConnector) == null) {
			db = new DatabaseConnector();
			request.getServletContext().setAttribute(TimeTracker.DBConnector, db);
		} else {
			db = (DatabaseConnector) this.getServletContext().getAttribute(TimeTracker.DBConnector);
		}
	%>
	<div class="wrapper">
		<div class="sidebar" data-color="orange"
			data-image="img/sidebar-5.jpg">

			<!--

        Tip 1: you can change the color of the sidebar using: data-color="blue | azure | green | orange | red | purple"
        Tip 2: you can also add an image using data-image tag

    -->


			<div class="sidebar-wrapper">
				<div class="logo">
					<a href="tracker" class="simple-text"> Time Tracker </a>
				</div>

				<ul class="nav">
					<li><a href="tracker"> <i class="pe-7s-timer"></i>
							<p>Track Time</p>
					</a></li>
					<li class="active"><a href="dashboard"> <i
							class="pe-7s-graph"></i>
							<p>Dashboard</p>
					</a></li>
					<li><a href="project"> <i class="pe-7s-note2"></i>
							<p>Projects</p>
					</a></li>
					<li><a href="user"> <i class="pe-7s-user"></i>
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
						<a class="navbar-brand" href="#">Dashboard</a>
					</div>
					<div class="collapse navbar-collapse">
						<ul class="nav navbar-nav navbar-right">
							<li><a href="login"> Log out </a></li>
						</ul>
					</div>
				</div>
			</nav>

			<div class="content">
				<div class="container-fluid">
					<div class="row">

						<div class="col-md-6">
							<div class="card ">
								<div class="header">
									<h4 class="title">Tasks</h4>
									<p class="category">Worked on</p>
								</div>
								<div class="content">
									<div class="table-full-width">
										<table class="table">
											<thead>
												<th>Project</th>
												<th>Task</th>
												<th>From</th>
												<th>To</th>
												<th>Duration</th>
											</thead>
											<tbody>


												<%
													try {
														db.getEntityManager().getTransaction().begin();	 
														Query queryTime = db.getEntityManager().createNativeQuery("Select * from time t where user_id = ?1", Time.class);
														Query queryProj = db.getEntityManager().createNativeQuery("Select * from Project where id = ?1", Project.class);
														Query queryTask = db.getEntityManager().createNativeQuery("Select * from Task where id = ?1", Task.class);
														User u = (User) this.getServletContext().getAttribute(TimeTracker.User);
														queryTime.setParameter(1, u.getId());
														List<Time> values = queryTime.getResultList();
														

															if (!values.isEmpty()) {
															long duration;
															for (Time time : values) {
																if(time.getEnd() != null){
																	long diffInMillies = time.getEnd().getTime()- time.getStart().getTime();
																	TimeUnit tu = TimeUnit.MINUTES;
																	duration = tu.convert(diffInMillies,TimeUnit.MILLISECONDS);
																}else{
																	duration = 0;
																}

																queryTask.setParameter(1, time.getTask_id());
																List<Task> tasks =  queryTask.getResultList();
																Task t;
																String pName = "deleted", tName = "deleted";
																if (!tasks.isEmpty()) {
																	t = tasks.get(0);
																	queryProj.setParameter(1, t.getProject_id());
																	Project p = (Project)queryProj.getSingleResult();
																	pName = p.getName();
																	tName = t.getName();
																}
														out.println("<tr>");
														out.println("<td>" + p.getName()+ "</td>");
													    out.println("<td>" + t.getName() + "</td>");
													    out.println("<td>" + time.getStart() + "</td>");
													    out.println("<td>" + TimeTracker.NVL(time.getEnd(), "") + "</td>");	  
													    out.println("<td>" +  duration/60 + "h "+ duration%60  + "min</td>");
													    out.println("</tr>");
													}
														}
														
													}
													catch (Exception ex) {
														 out.println(ex.getMessage());
													} finally {
												 		db.getEntityManager().getTransaction().commit();
												 	}
												%>

												<tr>
													<form method="post" action="dashboard">
														<td colspan="3"><button
																class="btn btn-warning btn-fill btn-sm">
																<span class="fa fa-edit"></span>Download
															</button></td>
													</form>
												</tr>
											</tbody>
										</table>
									</div>

									<div class="footer">
										<hr>
										<div class="stats">
											<i class="fa fa-history"></i> Data since last Time Tracker
											entry
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>


			<footer class="footer">
				<div class="container-fluid">
					<p class="copyright pull-right">
						&copy; 2017 <a href="#">Time Tracker, SE Praktikum SS17 
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

<script type="text/javascript">
	$(document).ready(function() {

		demo.initChartist();

	});
</script>

</html>
