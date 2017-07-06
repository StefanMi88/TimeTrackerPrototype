package at.jku.timetracker;

import java.io.IOException;

import javax.persistence.NoResultException;
import javax.persistence.Query;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import at.jku.timetracker.database.DatabaseConnector;
import at.jku.timetracker.model.User;

@SuppressWarnings("serial")
@WebServlet(name = "LoginServlet", urlPatterns = { "/login", "/Login" })
public class LoginServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		req.setAttribute("errorMessage", "");
		this.getServletContext().setAttribute(TimeTracker.User, null);
		String nextJSP = "/jsp/login.jsp";
		RequestDispatcher dispatcher = getServletContext()
				.getRequestDispatcher(nextJSP);
		dispatcher.forward(req, resp);

	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		String username = req.getParameter("username");
		String password = req.getParameter("password");
		DatabaseConnector db;

		if (this.getServletContext().getAttribute(TimeTracker.DBConnector) == null) {
			db = new DatabaseConnector();
			this.getServletContext().setAttribute(TimeTracker.DBConnector, db);
		} else {
			db = (DatabaseConnector) this.getServletContext().getAttribute(
					TimeTracker.DBConnector);
		}

		User u = null;
		db.getEntityManager().getTransaction().begin();
		Query selectUserQuery = db.getEntityManager().createNativeQuery(
				"Select * from user u where u.username = ?", User.class);
		selectUserQuery.setParameter(1, username);

		try {
			u = (User) selectUserQuery.getSingleResult();
		} catch (NoResultException ex) {
			db.getEntityManager().getTransaction().commit();
			req.setAttribute("errorMessage", "User existiert nicht!!");
			String nextJSP = "/jsp/login.jsp";
			RequestDispatcher dispatcher = getServletContext()
					.getRequestDispatcher(nextJSP);
			dispatcher.forward(req, resp);
			return;
		}

		db.getEntityManager().getTransaction().commit();

		if (u.getPassword().equals(password)) {
			this.getServletContext().setAttribute(TimeTracker.User, u);
			resp.sendRedirect(req.getContextPath() + "/tracker");
		} else {
			req.setAttribute("errorMessage", "Falsches Passwort!");
			String nextJSP = "/jsp/login.jsp";
			RequestDispatcher dispatcher = getServletContext()
					.getRequestDispatcher(nextJSP);
			dispatcher.forward(req, resp);

		}
	}

}
