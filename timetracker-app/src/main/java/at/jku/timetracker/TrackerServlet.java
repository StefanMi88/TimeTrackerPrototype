package at.jku.timetracker;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import at.jku.timetracker.database.DatabaseConnector;

@WebServlet(name = "TrackerServlet", urlPatterns = { "/tracker" })
public class TrackerServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		if (this.getServletContext().getAttribute("USERNAME") == null) {
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

		String nextJSP = "/jsp/tracker.jsp";
		RequestDispatcher dispatcher = getServletContext()
				.getRequestDispatcher(nextJSP);
		dispatcher.forward(req, resp);

	}
}
