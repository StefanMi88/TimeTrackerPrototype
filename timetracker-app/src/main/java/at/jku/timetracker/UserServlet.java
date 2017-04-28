package at.jku.timetracker;


import java.io.IOException;

import javax.persistence.Query;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import at.jku.timetracker.database.DatabaseConnector;
import at.jku.timetracker.model.User;

@WebServlet(name = "UserServlet", urlPatterns = { "/user"})
public class UserServlet extends HttpServlet {

	private String username = null;
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		if ((username = (String) this.getServletContext().getAttribute("USERNAME")) == null) {
			resp.sendRedirect(req.getContextPath() + "/login");
			return;
		}
		
		DatabaseConnector db;

		if (this.getServletContext().getAttribute("DATABASECON") == null) {
			db = new DatabaseConnector();
			this.getServletContext().setAttribute("DATABASECON", db);
		} else {
			db = (DatabaseConnector) this.getServletContext().getAttribute(
					"DATABASECON");
		}
		
		Query selectUserQuery = db.getEntityManager().createNativeQuery("Select u from user u where u.username = ?", User.class);
		selectUserQuery.setParameter(1, this.username);
		
		Object o =  selectUserQuery.getSingleResult();
		req.setAttribute("username", "Test");
		
		String nextJSP = "/jsp/user.jsp";
		RequestDispatcher dispatcher = getServletContext()
				.getRequestDispatcher(nextJSP);
		dispatcher.forward(req, resp);

	}

}
