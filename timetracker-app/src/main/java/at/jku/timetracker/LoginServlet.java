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

@WebServlet(name = "LoginServlet", urlPatterns = { "/login" })
public class LoginServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

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

		DatabaseConnector db = new DatabaseConnector();

		db.getEntityManager().getTransaction().begin();
				 
		Query query = db.getEntityManager().createNativeQuery(
				"Select password from user where username = '" + username
						+ "'");
		String pwd = (String) query.getSingleResult();
		db.getEntityManager().getTransaction().commit();

		if (pwd.equals(password)) {
            // set Context User
			resp.sendRedirect(req.getContextPath()+ "/tracker");
		}else{
				// ToDo
				// auf Fehler Page verweisen 
				try {
					throw new Exception("Wrong Password:" + pwd + password);
				} catch (Exception e) {
					e.printStackTrace();
					String nextJSP = "/login";
					RequestDispatcher dispatcher = getServletContext()
							.getRequestDispatcher(nextJSP);
					dispatcher.forward(req, resp);
				}
		}
	}

}
