package at.jku.timetracker;

import java.io.IOException;
import java.util.*;
import java.util.concurrent.TimeUnit;
import java.sql.Date;
import java.sql.Timestamp;

import javax.persistence.NoResultException;
import javax.persistence.Query;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import at.jku.timetracker.database.DatabaseConnector;
import at.jku.timetracker.model.Project;
import at.jku.timetracker.model.User;
import at.jku.timetracker.model.Time;

@SuppressWarnings("serial")
@WebServlet(name = "StartTimeServlet", urlPatterns = { "/startTime" })
public class StartTimeServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		DatabaseConnector db;
		String action = req.getParameter("type");
		User u = (User) this.getServletContext().getAttribute(TimeTracker.User);

		if (this.getServletContext().getAttribute(TimeTracker.DBConnector) == null) {
			db = new DatabaseConnector();
			this.getServletContext().setAttribute(TimeTracker.DBConnector, db);
		} else {
			db = (DatabaseConnector) this.getServletContext().getAttribute(
					TimeTracker.DBConnector);
		}
		if (action != null && action.equals("manual")) { // Zeit manuell
															// erstellen
			try {
				Timestamp start = Timestamp.valueOf(req.getParameter("start")
						.replace("T", " ").concat(":00"));
				Timestamp end = Timestamp.valueOf(req.getParameter("end")
						.replace("T", " ").concat(":00"));

				long duration;
				long diffInMillies = end.getTime() - start.getTime();
				TimeUnit tu = TimeUnit.MINUTES;
				duration = tu.convert(diffInMillies, TimeUnit.MILLISECONDS);
				db.getEntityManager().getTransaction().begin();
				if (duration > 0) {
					Query queryInsert = db
							.getEntityManager()
							.createNativeQuery(
									"INSERT INTO time (task_id, user_id, start, end) VALUES (?, ?, ?, ?)");

					queryInsert.setParameter(1, req.getParameter("task"));
					queryInsert.setParameter(2, u.getId());
					queryInsert.setParameter(3, start);
					queryInsert.setParameter(4, end);
					queryInsert.executeUpdate();
					db.getEntityManager().getTransaction().commit();
				} else {
					req.setAttribute("errorMessage",
							"End timestamp must be before start timestamp!");
					RequestDispatcher dispatcher = getServletContext()
							.getRequestDispatcher("/jsp/tracker.jsp");
					dispatcher.forward(req, resp);
					db.getEntityManager().getTransaction().commit();
					return;
				}
			} catch (Exception e) {
			}

			String nextJSP = "/jsp/tracker.jsp";
			RequestDispatcher dispatcher = getServletContext()
					.getRequestDispatcher(nextJSP);
			dispatcher.forward(req, resp);
			return;
		}
		if (action != null && action.equals("edit")) { // Edit Zeit
			try {
				Timestamp start = Timestamp.valueOf(req.getParameter("start"));
				Timestamp end = Timestamp.valueOf(req.getParameter("end"));
				long duration;
				long diffInMillies = end.getTime() - start.getTime();
				TimeUnit tu = TimeUnit.MINUTES;
				duration = tu.convert(diffInMillies, TimeUnit.MILLISECONDS);
				db.getEntityManager().getTransaction().begin();
				if (duration > 0) {
					Query queryInsert = db
							.getEntityManager()
							.createNativeQuery(
									"UPDATE time SET start = ?, end = ? WHERE id = ?");

					queryInsert.setParameter(1, req.getParameter("start"));
					queryInsert.setParameter(2, req.getParameter("end"));
					queryInsert.setParameter(3, req.getParameter("id"));
					queryInsert.executeUpdate();
					db.getEntityManager().getTransaction().commit();
				} else {
					req.setAttribute("errorMessage",
							"End timestamp must be before start timestamp!");
					RequestDispatcher dispatcher = getServletContext()
							.getRequestDispatcher("/jsp/tracker.jsp");
					dispatcher.forward(req, resp);
					db.getEntityManager().getTransaction().commit();
					return;
				}
			} catch (Exception e) {
			}

			String nextJSP = "/jsp/tracker.jsp";
			RequestDispatcher dispatcher = getServletContext()
					.getRequestDispatcher(nextJSP);
			dispatcher.forward(req, resp);
			return;
		} else { // Start Stop Zeit
			int taskId;

			if (this.getServletContext().getAttribute("taskId") != null
					&& this.getServletContext().getAttribute("taskId")
							.toString() != "0") {
				taskId = Integer.parseInt(this.getServletContext()
						.getAttribute("taskId").toString());
			} else {
				taskId = Integer.parseInt(req.getParameter("task"));
			}

			try {

				Timestamp curtime = null;

				if (req.getParameter("curtime") != null
						&& !req.getParameter("curtime").equals("")) {
					curtime = Timestamp.valueOf(req.getParameter("curtime"));
				} else {
					curtime = new java.sql.Timestamp(System.currentTimeMillis());
				}

				db.getEntityManager().getTransaction().begin();
				Query querySelect = db
						.getEntityManager()
						.createNativeQuery(
								"Select * from time t where t.task_id = ? AND t.user_id = ? AND t.end IS NULL",
								Time.class);

				querySelect.setParameter(1, taskId);
				querySelect.setParameter(2, u.getId());
				List<Time> values = querySelect.getResultList();

				db.getEntityManager().getTransaction().commit();

				if (values != null && !values.isEmpty()) { // STOP

					Time time = values.get(0);
					time.setEnd(curtime);

					db.getEntityManager().getTransaction().begin();
					Query queryUpdate = db
							.getEntityManager()
							.createNativeQuery(
									"UPDATE time t SET t.end = ? where t.task_id = ? AND t.user_id = ? AND t.start = ?");
					queryUpdate.setParameter(1, time.getEnd());
					queryUpdate.setParameter(2, time.getTask_id());
					queryUpdate.setParameter(3, time.getUser_id());
					queryUpdate.setParameter(4, time.getStart());
					queryUpdate.executeUpdate();
					db.getEntityManager().getTransaction().commit();

					this.getServletContext().setAttribute("taskId", null);

				} else { // START
					Time t = new Time(taskId, u.getId(), curtime, null);
					Query queryInsert = db
							.getEntityManager()
							.createNativeQuery(
									"INSERT INTO time (task_id, user_id, start, end) VALUES (?, ?, ?, ?)");

					db.getEntityManager().getTransaction().begin();
					queryInsert.setParameter(1, t.getTask_id());
					queryInsert.setParameter(2, t.getUser_id());
					queryInsert.setParameter(3, t.getStart());
					queryInsert.setParameter(4, t.getEnd());
					queryInsert.executeUpdate();
					db.getEntityManager().getTransaction().commit();

					this.getServletContext().setAttribute("taskId", taskId);

				}
			} catch (Exception e) {
				db.getEntityManager().getTransaction().commit();
			}

			String nextJSP = "/jsp/tracker.jsp";
			RequestDispatcher dispatcher = getServletContext()
					.getRequestDispatcher(nextJSP);
			dispatcher.forward(req, resp);
			return;

		}
	}

}
