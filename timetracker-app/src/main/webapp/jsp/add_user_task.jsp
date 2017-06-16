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

    <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0' name='viewport' />
    <meta name="viewport" content="width=device-width" />


    <!-- Bootstrap core CSS     -->
    <link href="css/bootstrap.min.css" rel="stylesheet" />

    <!-- Animation library for notifications   -->
    <link href="css/animate.min.css" rel="stylesheet"/>

    <!--  Light Bootstrap Table core CSS    -->
    <link href="css/light-bootstrap-dashboard.css" rel="stylesheet"/>


    <!--  CSS for Demo Purpose, don't include it in your project     -->
    <link href="css/demo.css" rel="stylesheet" />


    <!--     Fonts and icons     -->
    <link href="http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet">
    <link href='http://fonts.googleapis.com/css?family=Roboto:400,700,300' rel='stylesheet' type='text/css'>
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
    <div class="sidebar" data-color="orange" data-image="img/sidebar-5.jpg">

        <!--

            Tip 1: you can change the color of the sidebar using: data-color="blue | azure | green | orange | red | purple"
            Tip 2: you can also add an image using data-image tag

        -->

       
        <div class="sidebar-wrapper">
            <div class="logo">
                <a href="tracker" class="simple-text">
                    Time Tracker
                </a>
            </div>

            <ul class="nav">
                <li>
                    <a href="tracker">
                        <i class="pe-7s-timer"></i>
                        <p>Track Time</p>
                    </a>
                </li>
                <li>
                    <a href="dashboard">
                        <i class="pe-7s-graph"></i>
                        <p>Dashboard</p>
                    </a>
                </li>
                <li>
                    <a href="project">
                        <i class="pe-7s-note2"></i>
                        <p>Projects</p>
                    </a>
                </li>
                <li class="active">
                    <a href="user">
                        <i class="pe-7s-user"></i>
                        <p>Users</p>
                    </a>
                </li>
            </ul>
        </div>
    </div>

    <div class="main-panel">
        <nav class="navbar navbar-default navbar-fixed">
            <div class="container-fluid">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navigation-example-2">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="#">Add User to Project</a>
                </div>
                <div class="collapse navbar-collapse">
                    <ul class="nav navbar-nav navbar-right">
                        <li>
                            <a href="login">
                                Log out
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>


        <div class="content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="header">
                                <h4 class="title">Add User...</h4>
                                <p class="category">Enter user and click Add button</p>
                            </div>
                            <div class="content">
                                <form method="post" action="#">
                                    <div class="row">
                                        <div class="col-md-3">
                                            <label for="name" >User:</label>
											<select>
                                                     <%
															try {
																db.getEntityManager().getTransaction().begin();	 
																Query query = db.getEntityManager().createNativeQuery("Select * from User u", User.class);
																List<User> values = query.getResultList();
																
																if (values != null)
																{
																	for (User user : values) {
															            out.println("<option value=" + user.getUsername() + ">");
															           
																	}
																}
																
															}
															catch (Exception ex) {
																 out.println(ex.getMessage());
															}
														 	finally
														 	{
														 		db.getEntityManager().getTransaction().commit();
														 	}
														%>
                                            </select>
                                        </div>
                                        <div class="col-md-2">
                                            <button class="btn btn-warning btn-fill btn-sm">Add</button>
                                        </div>
                                    </div>
                                </form>
                                <br />
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="card">
                            <div class="header">
                                <h4 class="title">Users</h4>
                                <p class="category">Users assigned to the task</p>
                            </div>
                            <div class="content table-responsive table-full-width">
                                <table class="table table-hover table-striped">
                                    <thead>
                                        <th>First Name</th>
                                    	<th>Last Name</th>
                                    </thead>
                                    <tbody>
                                        <tr>
                                        	<td>Toni</td>
                                        	<td>Polster</td>
                                        </tr>
                                        <tr>
                                        	<td>Hans</td>
                                        	<td>Krankl</td>
                                        </tr>
                                    </tbody>
                                </table>

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
    <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?sensor=false"></script>

    <!-- Light Bootstrap Table Core javascript and methods for Demo purpose -->
	<script src="js/light-bootstrap-dashboard.js"></script>

	<!-- Light Bootstrap Table DEMO methods, don't include it in your project! -->
	<script src="js/demo.js"></script>


</html>
