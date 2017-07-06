package at.jku.timetracker;

import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Arrays;
import java.util.List;
import java.util.concurrent.TimeUnit;

import javax.persistence.Query;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.jasper.tagplugins.jstl.core.Out;

import at.jku.timetracker.database.DatabaseConnector;
import at.jku.timetracker.model.Project;
import at.jku.timetracker.model.Task;
import at.jku.timetracker.model.Time;
import at.jku.timetracker.model.User;

@SuppressWarnings("serial")
@WebServlet(name = "DashboardServlet", urlPatterns = { "/dashboard" })
public class DashboardServlet extends HttpServlet {

	DatabaseConnector db;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		if (this.getServletContext().getAttribute(TimeTracker.User) == null) {
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

		String nextJSP = "/jsp/dashboard.jsp";
		RequestDispatcher dispatcher = getServletContext()
				.getRequestDispatcher(nextJSP);
		dispatcher.forward(req, resp);

	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		String filename = "download.csv";
		resp.setHeader("Content-Type", "text/csv");
		resp.setHeader("Content-Disposition", "attachment; filename=\""
				+ filename + "\"");
		PrintWriter writer = resp.getWriter();

		try {

			db.getEntityManager().getTransaction().begin();

			Query queryTime = db.getEntityManager().createNativeQuery(
					"Select * from time t where user_id = ?1", Time.class);
			Query queryProj = db.getEntityManager().createNativeQuery(
					"Select * from Project where id = ?1", Project.class);
			Query queryTask = db.getEntityManager().createNativeQuery(
					"Select * from Task where id = ?1", Task.class);
			User u = (User) this.getServletContext().getAttribute(
					TimeTracker.User);

			queryTime.setParameter(1, u.getId());
			List<Time> values = queryTime.getResultList();

			if (!values.isEmpty()) {

				long duration;

				for (Time time : values) {

					if (time.getEnd() != null) {
						long diffInMillies = time.getEnd().getTime()
								- time.getStart().getTime();
						TimeUnit tu = TimeUnit.MINUTES;
						duration = tu.convert(diffInMillies,
								TimeUnit.MILLISECONDS);
					} else {
						duration = 0;
					}

					queryTask.setParameter(1, time.getTask_id());
					Task t = (Task) queryTask.getSingleResult();

					queryProj.setParameter(1, t.getProject_id());
					Project p = (Project) queryProj.getSingleResult();

					writer.append(p.getName());
					writer.append(',');
					writer.append(t.getName());
					writer.append(',');
					writer.append(time.getStart().toString());
					writer.append(',');
					writer.append(TimeTracker.NVL(time.getEnd(), "").toString());
					writer.append(',');
					writer.append(duration / 60 + "h " + duration % 60 + "min");
					writer.append('\n');

				}

				writer.flush();
				writer.close();

			}

		} catch (Exception ex) {
			System.out.println(ex.getMessage());
		} finally {
			db.getEntityManager().getTransaction().commit();
		}

		super.doPost(req, resp);
	}
}
