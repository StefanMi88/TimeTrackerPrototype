package at.jku.timetracker;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "NewUserServlet", urlPatterns = { "/newuser" })
public class NewUserServlet extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		if (this.getServletContext().getAttribute(TimeTracker.User) == null) {
			resp.sendRedirect(req.getContextPath() + "/login");
			return;
		}
				
		String nextJSP = "/jsp/new_user.jsp";
		RequestDispatcher dispatcher = getServletContext()
				.getRequestDispatcher(nextJSP);
		dispatcher.forward(req, resp);
	}
}
