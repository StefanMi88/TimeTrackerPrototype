
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
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
	<script>
	//jQuery function to show hide the manual adding div
	$(document).ready(function(){
		$("#manual").hide();
		$("#btn_manual").click(function(){
		    $("#manual").toggle();
		});
	});
	</script>
</head>
<body>
<%
	//Get DB Connection
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
    
        <div class="sidebar-wrapper">
            <div class="logo">
                <a href="tracker" class="simple-text">
                    Time Tracker
                </a>
            </div>

            <ul class="nav">
                <li class="active">
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
                    <a class="navbar-brand" href="#">Track Time</a>
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
        <!-- show edit view if editTimeId exists as URL parameter -->
        <div class="content"><%
        	if (request.getParameter("editTimeId") != null) {
        		%>
        		<div class="container-fluid" id="edit">
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="header">
                                <h4 class="title">Edit time record</h4>
                                <p class="category">Update start and end time</p>
                                <div class="content table-responsive table-full-width">
                                <table class="table table-hover table-striped">
                                    <thead>
                                    	<th>Start</th>
                                    	<th>Stop</th>
                                    	<th>&nbsp;</th>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <form method="post" action="startTime?type=edit"> 
                                                        <%
															try {
																
																// Edit Time
																String timeId = request.getParameter("editTimeId");
																db.getEntityManager().getTransaction().begin();	 
																Query queryTime = db.getEntityManager().createNativeQuery("SELECT * FROM time WHERE id = ?", Time.class);
																queryTime.setParameter(1, timeId);
																List<Time> values = queryTime.getResultList();
																
																if (values != null)
																{
																	for (Time time : values) {
																		out.println("<td id=\"start\"><input type=\"text\" name=\"start\" id=\"start\" value=\""+ time.getStart() + "\" /></td>");
																		out.println("<td id=\"end\"><input type=\"text\" name=\"end\" id=\"end\" value=\""+ time.getEnd() + "\" /></td>");
																		out.println("<input type=\"hidden\" name=\"id\" id=\"id\" value=\""+ timeId + "\" />");
																	}
																}
															} catch (Exception ex) {
																 out.println(ex.getMessage());
															}
														 	finally
														 	{
														 		db.getEntityManager().getTransaction().commit();
														 	}
														%>
                                                <td><button class="btn btn-warning btn-fill btn-sm">Update</button></td>
                                            </form>
                                        </tr>
                                    </tbody>
                                </table>
                                
								<div class="control-group error">
		      						<span class="help-inline"><% if(request.getAttribute("errorMessage")!=null) {out.println(request.getAttribute("errorMessage"));}%></span>
		    					</div>
                            </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        		<%
        	}
        	else {
        	%>
        	<!-- track time automatically -->
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="header">
                                <h4 class="title">Track your time</h4>
                                <p class="category">Choose a project, enter a task and click play button</p>
                            </div>
                            <div class="content table-responsive table-full-width">
                                <table class="table table-hover table-striped">
                                    <thead>
                                    	<th>Task</th>
                                    	<th>Cur. Time</th>
                                    	<th>Start/Stop tracking</th>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <form method="post" action="startTime">
                                            
                                                <td>
                                                    <select name="task" id="task"  <% 
                                                    
                                                    try{
                                                        String taskId = this.getServletContext().getAttribute("taskId").toString();
                                                    		if (taskId != null){
                                                            	out.println("disabled");
                                                            }
                                                    		
                                                    		}catch(Exception e){
                                                    	
                                                    }
                                                    
                                                    %>>
                                                        <%
															try {
																String taskId = null;
																try{
			                                                        taskId = this.getServletContext().getAttribute("taskId").toString();
			                                                    	if (taskId != null){
			                                                           	out.println("disabled");
			                                                        }
			                                                    	
			                                                    	}catch(Exception e){}
																
																	String project = request.getParameter("project");	
																	db.getEntityManager().getTransaction().begin();	 
																	
																	Query queryTask;
																	if (project == null || project.isEmpty()) {
																		User u = (User) this.getServletContext().getAttribute(TimeTracker.User);
																		queryTask = db.getEntityManager().createNativeQuery("SELECT name, id FROM task WHERE project_id IN (SELECT project_id FROM projectmembers WHERE username = '" + u.getUsername() +"')", Task.class);																		
																	}
																	else {																	
																		queryTask = db.getEntityManager().createNativeQuery("Select * from Task t where t.PROJECT_ID = ?", Task.class);
																	}	
																	
																	queryTask.setParameter(1, project);
																	List<Task> values = queryTask.getResultList();

																	String btn;
																	//List available tasks to track
																	if (values != null)
																	{
																		for (Task task : values) {
																			if (taskId != null && task.getId() == Integer.valueOf(taskId)){
																	            out.println("<option value=\"" + task.getId() + "\" selected>");
																	            out.println("" + task.getName() + "</option>");
																			}
																			else{
																				out.println("<option value=\"" + task.getId() + "\" >");
																	            out.println("" + task.getName() + "</option>");
																	        }
																		}
																	}
																%>
			                                                    </select>
				                                                </td>
				                                                <td id="curtime"></td>
				                                                <td><button class="pe-7s-play btn btn-warning btn-fill btn-sm"></button></td>
			                                            	</form>															
															<%	
																
															}
															catch (Exception ex) {
																 out.println(ex.getMessage());
															}
														 	finally
														 	{
														 		db.getEntityManager().getTransaction().commit();
														 	}
														%>
                                        </tr>
                                        <script>
                                        	//get current timestamp for tracker
                                            var currentdate = new Date();
                                            var time = currentdate.getHours() + ":" + currentdate.getMinutes() + ":" + currentdate.getSeconds();
                                            document.getElementById("curtime").innerHTML = time;
                                        </script>
                                        <tr>
                                        	<td colspan="3"><button  class="btn btn-warning btn-fill btn-sm" id="btn_manual"><span class="fa fa-edit"></span>add recording manually</button></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- manual time tracking div - toggled by jQuery function -->
             <div class="container-fluid" id="manual">
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="header">
                                <h4 class="title">Add record manually</h4>
                                <p class="category">Fill out form to add a record manually</p>
                                <div class="content table-responsive table-full-width">
                                <table class="table table-hover table-striped">
                                    <thead>
                                    	<th>Task</th>
                                    	<th>Start</th>
                                    	<th>Stop</th>
                                    	<th>&nbsp;</th>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <form method="post" action="startTime?type=manual">
                                            
                                                <td>
                                                    <select name="task" id="task"  <% 
                                                    
                                                    try{
                                                        String taskId = this.getServletContext().getAttribute("taskId").toString();
                                                    		if (taskId != null){
                                                            	out.println("disabled");
                                                            }
                                                    		
                                                    		}catch(Exception e){
                                                    	
                                                    }
                                                    
                                                    %>>
                                                        <%
															try {
																String taskId = null;
																try{
			                                                        taskId = this.getServletContext().getAttribute("taskId").toString();
			                                                    		if (taskId != null){
			                                                            	out.println("disabled");
			                                                            }
			                                                    		
			                                                    		}catch(Exception e){}
																
																String project = request.getParameter("project");
																db.getEntityManager().getTransaction().begin();	 
																
																Query queryTask;
																if (project == null || project.isEmpty()) {
																	User u = (User) this.getServletContext().getAttribute(TimeTracker.User);
																	queryTask = db.getEntityManager().createNativeQuery("SELECT name, id FROM task WHERE project_id IN (SELECT project_id FROM projectmembers WHERE username = '" + u.getUsername() +"')", Task.class);
																}
																else {																	
																	queryTask = db.getEntityManager().createNativeQuery("Select * from Task t where t.PROJECT_ID = ?", Task.class);
																}	
																
																queryTask.setParameter(1, project);
																List<Task> values = queryTask.getResultList();
																
																if (values != null)
																{
																	for (Task task : values) {
																		if (taskId != null && task.getId() == Integer.valueOf(taskId)){
															            out.println("<option value=\"" + task.getId() + "\" selected>");
															            out.println("" + task.getName() + "</option>");}
																		else{
																			out.println("<option value=\"" + task.getId() + "\" >");
																            out.println("" + task.getName() + "</option>");}
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
                                                </td>
                                                <td id="start"><input type="datetime-local" name="start" id="start" /></td>
                                                <td id="end"><input type="datetime-local" name="end" id="end" /></td>
                                                <td><button class="btn btn-warning btn-fill btn-sm">Save</button></td>
                                            </form>
                                        </tr>
                                    </tbody>
                                </table>
                                
								<div class="control-group error">
		      						<span class="help-inline"><% if(request.getAttribute("errorMessage")!=null) {out.println(request.getAttribute("errorMessage"));}%></span>
		    					</div>
                            </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Show previous recordings -->
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="header">
                                <h4 class="title">Previous recordings</h4>
                                <p class="category">Here you can see your past recordings</p>
                            </div>
                            <div class="content table-responsive table-full-width">
                                <table class="table table-hover table-striped">
                                    <thead>
                                        <th>Project</th>
                                        <th>Task</th>
                                        <th>From</th>
                                        <th>To</th>
                                        <th>Duration</th>
                                        <th>Edit</th>
                                    </thead>
                                    <tbody>
									<%
										try {
											//query data from tables time, project, task
											db.getEntityManager().getTransaction().begin();	 
											Query queryTime = db.getEntityManager().createNativeQuery("Select * from time t where user_id = ?1 ORDER BY start DESC", Time.class);
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
													//overwrite deleted if task and project still exists
													if (!tasks.isEmpty()) {
														t = tasks.get(0);
														queryProj.setParameter(1, t.getProject_id());
														Project p = (Project)queryProj.getSingleResult();
														pName = p.getName();
														tName = t.getName();
													}
													
													out.println("<tr>");
													out.println("<td>" + pName + "</td>");
										            out.println("<td>" + tName + "</td>");
										            out.println("<td>" + time.getStart() + "</td>");
										            if (time.getEnd() == null) {
										            	out.println("<td>in progress</td>");	
										            }
										            else {
										            	out.println("<td>" + TimeTracker.NVL(time.getEnd(), "") + "</td>");	 
										            }
										            if (time.getEnd() == null) {
										            	out.println("<td>in progress</td>");
										            }
										            else {
											            out.println("<td>" +  duration/60 + "h "+ duration%60  + "min</td>"); 	
										            }
										            out.println("<td><a href=\"tracker?editTimeId="
															+ time.getId()
															+ "\" title=\"Edit\"><span class=\"pe-7s-edit\"></span></a></td>");
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
                                    
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <% } %>

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
