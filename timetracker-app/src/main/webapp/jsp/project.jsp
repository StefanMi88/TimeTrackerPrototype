<%@page import="at.jku.timetracker.database.DatabaseConnector"%>
<%@page import="javax.persistence.Query"%>
<%@page import="at.jku.timetracker.model.Project"%>
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
	
	if (request.getServletContext().getAttribute("DATABASECON") == null) {
		db = new DatabaseConnector();
		request.getServletContext().setAttribute("DATABASECON", db);
	} else {
		db = (DatabaseConnector) this.getServletContext().getAttribute("DATABASECON");
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
                <li class="active">
                    <a href="project">
                        <i class="pe-7s-note2"></i>
                        <p>Projects</p>
                    </a>
                </li>
                <li>
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
                    <a class="navbar-brand" href="#">Projects</a>
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
                                <h4 class="title">Add new Project...</h4>
                                <p class="category">Enter settings and click create button</p>
                            </div>
                            <div class="content">
                               	<form method="post" action="project">
                                    <div class="row">
                                        <div class="col-md-3">
                                            <label for="name" >Name:</label>
                                            <input class="" type="text" name="name" id="name">
                                        </div>
                                        <div class="col-md-7">
                                            <label for="desc">Description:</label>
                                            <input type="text" name="desc" id="desc" size="60">
                                        </div>
                                        <div class="col-md-2">
                                            <button type="submit" class="btn btn-warning btn-fill btn-sm">Create</button>
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
                                <h4 class="title">Existing Projects</h4>
                                <p class="category">Click the add icon on the right to add tasks to the project</p>
                            </div>
                            <div class="content table-responsive table-full-width">
                                <table class="table table-hover table-striped">
                                    <thead>
                                        <th>ID</th>
                                    	<th>Name</th>
                                    	<th>Description</th>
                                        <th>Add</th>
                                    </thead>
                                    <tbody>
<%
	try {
		db.getEntityManager().getTransaction().begin();	 
		Query query = db.getEntityManager().createNativeQuery("Select * from project p", Project.class);
		List<Project> values = query.getResultList();
		
		if (values != null)
		{
			//out.println(values.size());
			 //Display values
			for (Project prj : values) {
				out.println("<tr>");
	            out.println("<td>" + prj.getId() + "</td>");
	            out.println("<td>" + prj.getName() + "</td>");
	            out.println("<td>" + prj.getDescription() + "</td>");	            
	            out.println("<td><a href=\"project?projectId="+ prj.getId() +"\" title=\"Add\"><span class=\"pe-7s-edit\"></span></a></td>");
	            out.println("</tr>");
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
                                        <tr>
                                        	<td>1</td>
                                        	<td>Project A</td>
                                        	<td>Sample Project A</td>
                                            <td><a href="project?projectId=1" title="Add"><span class="pe-7s-edit"></span></a></td>
                                        </tr>
                                        <tr>
                                        	<td>2</td>
                                        	<td>Project B</td>
                                        	<td>Sample Project B</td>
                                            <td><a href="edit_project.jsp" title="Add"><span class="pe-7s-edit"></span></a></td>
                                        </tr>
                                        <tr>
                                            <td>3</td>
                                            <td>Off Project</td>
                                            <td>Use this if not working on any project</td>
                                            <td><a href="edit_project.jsp" title="Add"><span class="pe-7s-edit"></span></a></td>
                                        </tr>
                                    </tbody>
                                </table>
								 
                                    <%=request.getContextPath()%>
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
