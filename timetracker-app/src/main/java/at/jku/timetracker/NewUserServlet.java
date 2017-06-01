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
@WebServlet(name = "NewUserServlet", urlPatterns = { "/newuser" })
public class NewUserServlet extends HttpServlet{

	private User user = null;
	private DatabaseConnector db = null;
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		if ((user = (User) this.getServletContext().getAttribute(TimeTracker.User)) == null) {
			resp.sendRedirect(req.getContextPath() + "/login");
			return;
		}
		
		req.setAttribute("firstname", "");
		req.setAttribute("lastname", "");
		req.setAttribute("country", "");
		req.setAttribute("zip", "");
		req.setAttribute("address", "");
		req.setAttribute("city", "");
		req.setAttribute("company", "");
		req.setAttribute("email", "");
		req.setAttribute("aboutme", "");
		req.setAttribute("username", "");
		req.setAttribute("password", "");
		req.setAttribute("type", "");	
		req.setAttribute("errorMessage", "");
				
		String nextJSP = "/jsp/new_user.jsp";
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
		String nextJSP = "/jsp/new_user.jsp";
		
		String firstname = req.getParameter("firstname");
		String lastname = req.getParameter("lastname");
		String country = req.getParameter("country");
		String zip = req.getParameter("zip");
		String address = req.getParameter("address");
		String city = req.getParameter("city");
		String company = req.getParameter("company");
		String email = req.getParameter("email");
		String aboutme = req.getParameter("aboutme");
		String username = req.getParameter("username");
		String password = req.getParameter("password");
		String type = req.getParameter("type");
		
		req.setAttribute("firstname", firstname);
		req.setAttribute("lastname", lastname);
		req.setAttribute("country", country);
		req.setAttribute("zip", zip);
		req.setAttribute("address", address);
		req.setAttribute("city", city);
		req.setAttribute("company", company);
		req.setAttribute("email", email);
		req.setAttribute("aboutme", aboutme);
		req.setAttribute("username", username);
		req.setAttribute("username", username);
		req.setAttribute("password", password);
		req.setAttribute("type", type);
		
		if (username.equals("")){
			req.setAttribute("errorMessage", "Username is empty!");
			RequestDispatcher dispatcher = getServletContext()
					.getRequestDispatcher(nextJSP);
			dispatcher.forward(req, resp);
			return;
		}
		
		if (password.equals("")){
			req.setAttribute("errorMessage", "Password is empty!");
			RequestDispatcher dispatcher = getServletContext()
					.getRequestDispatcher(nextJSP);
			dispatcher.forward(req, resp);
			return;
		}
		
		if (aboutme.equals("")){
			req.setAttribute("errorMessage", "About Me is empty!");
			RequestDispatcher dispatcher = getServletContext()
					.getRequestDispatcher(nextJSP);
			dispatcher.forward(req, resp);
			return;
		}
		
		if (city.equals("")){
			req.setAttribute("errorMessage", "City is empty!");
			RequestDispatcher dispatcher = getServletContext()
					.getRequestDispatcher(nextJSP);
			dispatcher.forward(req, resp);
			return;
		}
		
		if (zip.equals("")){
			req.setAttribute("errorMessage", "Postal Code is empty!");
			RequestDispatcher dispatcher = getServletContext()
					.getRequestDispatcher(nextJSP);
			dispatcher.forward(req, resp);
			return;
		}
		
		if (firstname.equals("")){
			req.setAttribute("errorMessage", "First Name is empty!");
			RequestDispatcher dispatcher = getServletContext()
					.getRequestDispatcher(nextJSP);
			dispatcher.forward(req, resp);
			return;
		}
		
		if (lastname.equals("")){
			req.setAttribute("errorMessage", "Last Name is empty!");
			RequestDispatcher dispatcher = getServletContext()
					.getRequestDispatcher(nextJSP);
			dispatcher.forward(req, resp);
			return;
		}
		
		if (company.equals("")){
			req.setAttribute("errorMessage", "Company is empty!");
			RequestDispatcher dispatcher = getServletContext()
					.getRequestDispatcher(nextJSP);
			dispatcher.forward(req, resp);
			return;
		}
		
		if (email.equals("")){
			req.setAttribute("errorMessage", "Email is empty!");
			RequestDispatcher dispatcher = getServletContext()
					.getRequestDispatcher(nextJSP);
			dispatcher.forward(req, resp);
			return;
		}
		
		if (country.equals("")){
			req.setAttribute("errorMessage", "Country is empty!");
			RequestDispatcher dispatcher = getServletContext()
					.getRequestDispatcher(nextJSP);
			dispatcher.forward(req, resp);
			return;
		}
		
		if (address.equals("")){
			req.setAttribute("errorMessage", "Address is empty!");
			RequestDispatcher dispatcher = getServletContext()
					.getRequestDispatcher(nextJSP);
			dispatcher.forward(req, resp);
			return;
		}
		
		db.getEntityManager().getTransaction().begin();
		User existingUser = null;
		Query selectUsernameQuery = db.getEntityManager().createNativeQuery("Select * from User u where u.username = ?", User.class);
		selectUsernameQuery.setParameter(1, username);
		try{
			existingUser = (User) selectUsernameQuery.getSingleResult();
		} catch (NoResultException ex){
			// alles in ordnung
		}
		
		if (existingUser != null){
			db.getEntityManager().getTransaction().commit();
			req.setAttribute("errorMessage", "Username already existing!");
			RequestDispatcher dispatcher = getServletContext()
					.getRequestDispatcher(nextJSP);
			dispatcher.forward(req, resp);
			return;
		}
		
		Query insertUserQuery = db.getEntityManager().createNativeQuery("Insert into User(username, password, firstname, lastname, country, zip, address, city, company, email, aboutme, type) values(?,?,?,?,?,?,?,?,?,?,?,?)");
		insertUserQuery.setParameter(1, username);
		insertUserQuery.setParameter(2, password);
		insertUserQuery.setParameter(3, firstname);
		insertUserQuery.setParameter(4, lastname);
		insertUserQuery.setParameter(5, country);
		insertUserQuery.setParameter(6, zip);
		insertUserQuery.setParameter(7, address);
		insertUserQuery.setParameter(8, city);
		insertUserQuery.setParameter(9, company);
		insertUserQuery.setParameter(10, email);
		insertUserQuery.setParameter(11, aboutme);
		insertUserQuery.setParameter(12, type);
		
		insertUserQuery.executeUpdate();
		db.getEntityManager().getTransaction().commit();
		req.setAttribute("firstname", null);
		req.setAttribute("lastname", null);
		req.setAttribute("country", null);
		req.setAttribute("zip", null);
		req.setAttribute("address", null);
		req.setAttribute("city", null);
		req.setAttribute("company", null);
		req.setAttribute("email", null);
		req.setAttribute("aboutme", null);
		req.setAttribute("username", null);
		req.setAttribute("password", null);
		req.setAttribute("type", null);		
		resp.sendRedirect(req.getContextPath() + "/user");
		return;
	}
}
