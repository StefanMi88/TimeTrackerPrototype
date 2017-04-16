package at.jku.timetracker;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import at.jku.timetracker.database.DatabaseConnector;


@WebServlet(
        name = "LoginServlet",
        urlPatterns = {"/login"}
)
public class LoginServlet extends HttpServlet{
	
	
	 	@Override
	    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
	            throws ServletException, IOException {
	     
		 String username = req.getParameter("username");
		 String password = req.getParameter("password");
		 
		 //DatabaseConnector db = new DatabaseConnector();
		 		 
		 String nextJSP = "/jsp/tracker.jsp";
	     RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(nextJSP);
	     dispatcher.forward(req, resp);
	    }
	 	
	 	@Override
	 	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	 	// TODO Auto-generated method stub
	 	super.doGet(req, resp);
	 	}
	
}
