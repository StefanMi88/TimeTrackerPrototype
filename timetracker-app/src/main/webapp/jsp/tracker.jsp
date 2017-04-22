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

<div class="wrapper">
    <div class="sidebar" data-color="orange" data-image="img/sidebar-5.jpg">

        <!--

            Tip 1: you can change the color of the sidebar using: data-color="blue | azure | green | orange | red | purple"
            Tip 2: you can also add an image using data-image tag

        -->

        <div class="sidebar-wrapper">
            <div class="logo">
                <a href="/tracker" class="simple-text">
                    Time Tracker
                </a>
            </div>

            <ul class="nav">
                <li class="active">
                    <a href="/tracker">
                        <i class="pe-7s-timer"></i>
                        <p>Track Time</p>
                    </a>
                </li>
                <li>
                    <a href="/dashboard">
                        <i class="pe-7s-graph"></i>
                        <p>Dashboard</p>
                    </a>
                </li>
                <li>
                    <a href="/project">
                        <i class="pe-7s-note2"></i>
                        <p>Projects</p>
                    </a>
                </li>
                <li>
                    <a href="/user">
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
                            <a href="#">
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
                                <h4 class="title">Track your time</h4>
                                <p class="category">Choose a project, enter a task and click play button</p>
                            </div>
                            <div class="content table-responsive table-full-width">
                                <table class="table table-hover table-striped">
                                    <thead>
                                        <th>Project</th>
                                    	<th>Task</th>
                                    	<th>Cur. Time</th>
                                    	<th>Start tracking</th>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <form method="post" action="#">
                                                <td>
                                                    <select>
                                                        <option value="projecta">Project A</option>
                                                        <option value="projectb">Project B</option>
                                                        <option value="offproject">Off Project</option>
                                                    </select>
                                                </td>
                                                <td>
                                                    <select>
                                                        <option value="sampleTaskf">Sample Task F</option>
                                                        <option value="sampleTaskb">Sample Task B</option>
                                                        <option value="smapleTaskc">Sample Task C</option>
                                                    </select>
                                                </td>
                                                <td id="curtime"></td>
                                                <td><button class="pe-7s-play btn btn-warning btn-fill btn-sm"></button></td>
                                            </form>
                                        </tr>
                                        <script>
                                            var currentdate = new Date();
                                            var time = currentdate.getHours() + ":" + currentdate.getMinutes();
                                            document.getElementById("curtime").innerHTML = time;
                                        </script>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
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
                                        <th>ID</th>
                                        <th>Project</th>
                                        <th>Task</th>
                                        <th>From</th>
                                        <th>To</th>
                                        <th>Duration</th>
                                        <th>Edit</th>
                                    </thead>
                                    <tbody>
                                    <tr>
                                        <td>3</td>
                                        <td>Project A</td>
                                        <td>Sample Task F</td>
                                        <td>12:40</td>
                                        <td>16:50</td>
                                        <td>4h 10min</td>
                                        <td><a href="#" title="Edit"><span class="pe-7s-edit"></span></a></td>
                                    </tr>
                                    <tr>
                                        <td>2</td>
                                        <td>Project A</td>
                                        <td>Sample Task B</td>
                                        <td>08:00</td>
                                        <td>11:25</td>
                                        <td>3h 25min</td>
                                        <td><a href="#" title="Edit"><span class="pe-7s-edit"></span></a></td>
                                    </tr>
                                    <tr>
                                        <td>1</td>
                                        <td>Project B</td>
                                        <td>Sample Task C</td>
                                        <td>13:00</td>
                                        <td>15:10</td>
                                        <td>2h 10min</td>
                                        <td><a href="#" title="Edit"><span class="pe-7s-edit"></span></a></td>
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
