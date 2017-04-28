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

	private User user = null;
	private DatabaseConnector db = null;
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		if ((user = (User) this.getServletContext().getAttribute(TimeTracker.User)) == null) {
			resp.sendRedirect(req.getContextPath() + "/login");
			return;
		}
		if (this.getServletContext().getAttribute(TimeTracker.DBConnector) == null) {
			db = new DatabaseConnector();
			this.getServletContext().setAttribute(TimeTracker.DBConnector, db);
		} else {
			db = (DatabaseConnector) this.getServletContext().getAttribute(
					TimeTracker.DBConnector);
		}
		
		req.setAttribute("username", user.getUsername());
		req.setAttribute("firstname", user.getFirstName());
		req.setAttribute("country", user.getCountry());
		req.setAttribute("lastname", user.getLastName());
		req.setAttribute("zip", user.getZip());
		req.setAttribute("address", user.getAddress());
		req.setAttribute("city", user.getCity());
		req.setAttribute("company", user.getCompany());
		req.setAttribute("email", user.getEmail());
		req.setAttribute("aboutme", user.getAboutMe());
		
		String nextJSP = "/jsp/user.jsp";
		RequestDispatcher dispatcher = getServletContext()
				.getRequestDispatcher(nextJSP);
		dispatcher.forward(req, resp);

	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		if ((user = (User) this.getServletContext().getAttribute(TimeTracker.User)) == null) {
			resp.sendRedirect(req.getContextPath() + "/login");
			return;
		}
		if (this.getServletContext().getAttribute(TimeTracker.DBConnector) == null) {
			db = new DatabaseConnector();
			this.getServletContext().setAttribute(TimeTracker.DBConnector, db);
		} else {
			db = (DatabaseConnector) this.getServletContext().getAttribute(
					TimeTracker.DBConnector);
		}
		
		db.getEntityManager().getTransaction().begin();
		
		Query updateUserQuery = db.getEntityManager().createNativeQuery("Update user u set u.firstname = ?, "
				+ " u.country = ?, "
				+ " u.lastname = ?, "
				+ " u.zip = ?, "
				+ " u.address = ?, "
				+ " u.city = ?, "
				+ " u.company = ?, "
				+ " u.email = ?, "
				+ " u.aboutme = ?"
				+ " where u.username = ?");

		updateUserQuery.setParameter(1, req.getParameter("firstname"));
		updateUserQuery.setParameter(2, req.getParameter("country"));
		updateUserQuery.setParameter(3, req.getParameter("lastname"));
		updateUserQuery.setParameter(4, req.getParameter("zip"));
		updateUserQuery.setParameter(5, req.getParameter("address"));
		updateUserQuery.setParameter(6, req.getParameter("city"));
		updateUserQuery.setParameter(7, req.getParameter("company"));
		updateUserQuery.setParameter(8, req.getParameter("email"));
		updateUserQuery.setParameter(9, req.getParameter("aboutme"));
		updateUserQuery.setParameter(10, user.getUsername());
		
		updateUserQuery.executeUpdate();
		db.getEntityManager().getTransaction().commit();
		db.getEntityManager().getTransaction().begin();
		
		Query selectUserQuery = db.getEntityManager().createNativeQuery(
				"Select * from user u where u.username = ?", User.class);
		selectUserQuery.setParameter(1, user.getUsername());
		User u = (User) selectUserQuery.getSingleResult();
		this.getServletContext().setAttribute(TimeTracker.User, u);
		
		db.getEntityManager().getTransaction().commit();
		
		resp.sendRedirect(req.getContextPath() + "/user");
		return;
		
	}

}
