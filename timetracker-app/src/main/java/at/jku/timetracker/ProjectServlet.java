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
import at.jku.timetracker.model.Project;
import at.jku.timetracker.model.Task;

@SuppressWarnings("serial")
@WebServlet(name = "ProjectServlet", urlPatterns = { "/project" })
public class ProjectServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		if (this.getServletContext().getAttribute(TimeTracker.User) == null) {
			resp.sendRedirect(req.getContextPath() + "/login");
			return;
		}

		DatabaseConnector db;

		if (this.getServletContext().getAttribute(TimeTracker.DBConnector) == null) {
			db = new DatabaseConnector();
			this.getServletContext().setAttribute(TimeTracker.DBConnector, db);
		} else {
			db = (DatabaseConnector) this.getServletContext().getAttribute(
					TimeTracker.DBConnector);
		}

		String nextJSP = "/jsp/project.jsp";
		RequestDispatcher dispatcher = getServletContext()
				.getRequestDispatcher(nextJSP);
		dispatcher.forward(req, resp);

	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		String name = req.getParameter("name");
		String desc = req.getParameter("desc");
		String cat = req.getParameter("cat");
		String action = req.getParameter("action");
		String projectId = req.getParameter("projectId");

		DatabaseConnector db;

		if (this.getServletContext().getAttribute(TimeTracker.DBConnector) == null) {
			db = new DatabaseConnector();
			this.getServletContext().setAttribute(TimeTracker.DBConnector, db);
		} else {
			db = (DatabaseConnector) this.getServletContext().getAttribute(
					TimeTracker.DBConnector);
		}

		if (action.equals("add")) { // Add Project
			db.getEntityManager().getTransaction().begin();
			Query queryMaxId = db.getEntityManager().createNativeQuery(
					"SELECT MAX(id)FROM project");
			Query queryInsert = db
					.getEntityManager()
					.createNativeQuery(
							"INSERT INTO project (id, name, description, category) VALUES (?, ?, ?, ?)");

			try {

				Integer maxProjectId = (Integer) queryMaxId.getSingleResult();
				if (maxProjectId == null)
					maxProjectId = 0;
				Project prj = new Project(maxProjectId + 1, name, desc, cat);
				projectId = "" + (maxProjectId + 1);

				db.getEntityManager().getTransaction().commit();
				db.getEntityManager().getTransaction().begin();
				queryInsert.setParameter(1, prj.getId());
				queryInsert.setParameter(2, prj.getName());
				queryInsert.setParameter(3, prj.getDescription());
				queryInsert.setParameter(4, prj.getCategory());
				queryInsert.executeUpdate();
				db.getEntityManager().getTransaction().commit();

			} catch (Exception ex) {
				db.getEntityManager().getTransaction().commit();
			}

			this.getServletContext().setAttribute("PROJECTID", projectId);
			resp.sendRedirect(req.getContextPath() + "/project");
		} else if (action.equals("edit")) { // Update Project
			db.getEntityManager().getTransaction().begin();
			projectId = req.getParameter("projectId");
			Query queryUpdate = db
					.getEntityManager()
					.createNativeQuery(
							"UPDATE project SET name = ?, description = ?, category = ? WHERE id = ?");
			try {
				queryUpdate.setParameter(1, name);
				queryUpdate.setParameter(2, desc);
				queryUpdate.setParameter(3, cat);
				queryUpdate.setParameter(4, projectId);
				queryUpdate.executeUpdate();
				db.getEntityManager().getTransaction().commit();

			} catch (Exception ex) {
				db.getEntityManager().getTransaction().commit();
			}

			this.getServletContext().setAttribute("PROJECTID", projectId);
			resp.sendRedirect(req.getContextPath() + "/project?projectId="
					+ projectId);
		} else if (action.equals("addUsers")) { // add Users to Project
			projectId = req.getParameter("projectId");
			String[] members = req.getParameterValues("projectmembers");
			db.getEntityManager().getTransaction().begin();
			Query delete = db.getEntityManager().createNativeQuery(
					"DELETE FROM projectmembers WHERE project_id = ?");
			delete.setParameter(1, projectId);
			delete.executeUpdate();
			db.getEntityManager().getTransaction().commit();
			for (String s : members) {
				db.getEntityManager().getTransaction().begin();
				Query update = db
						.getEntityManager()
						.createNativeQuery(
								"INSERT INTO projectmembers (username, project_id) VALUES(?,?)");
				try {
					s = s.replaceAll("\\r\\n", "");
					update.setParameter(1, s);
					update.setParameter(2, projectId);
					update.executeUpdate();
					db.getEntityManager().getTransaction().commit();

				} catch (Exception ex) {
					db.getEntityManager().getTransaction().commit();
				}
			}
			this.getServletContext().setAttribute("PROJECTID", projectId);
			resp.sendRedirect(req.getContextPath() + "/project?projectId="
					+ projectId);
		} else if (action.equals("delete")) { // Delete Project
			db.getEntityManager().getTransaction().begin();
			Query queryDelete = db.getEntityManager().createNativeQuery(
					"DELETE FROM project WHERE id = ?");
			Query queryDeleteTask = db.getEntityManager().createNativeQuery(
					"DELETE FROM Task WHERE project_id = ?");
			projectId = req.getParameter("projectId");
			try {
				queryDelete.setParameter(1, projectId);
				queryDelete.executeUpdate();
				queryDeleteTask.setParameter(1, projectId);
				queryDeleteTask.executeUpdate();
				db.getEntityManager().getTransaction().commit();

			} catch (Exception ex) {
				db.getEntityManager().getTransaction().commit();
			}

			this.getServletContext().setAttribute("PROJECTID", projectId);
			resp.sendRedirect(req.getContextPath() + "/project");
		} else if (action.equals("addTask")) { // add Task to Project
			String nextJSP = "/jsp/project.jsp?projectId="
					+ req.getParameter("projectId");
			db.getEntityManager().getTransaction().begin();
			Query queryName = db.getEntityManager().createNativeQuery(
					"SELECT id FROM Task WHERE name = ? AND project_id = ?");
			queryName.setParameter(1, req.getParameter("taskName"));
			queryName.setParameter(2, req.getParameter("projectId"));
			// Check if task with same name exists
			if (queryName.getResultList().isEmpty()
					&& req.getParameter("taskName") != "") {
				db.getEntityManager().getTransaction().commit();
				db.getEntityManager().getTransaction().begin();
				Query queryMaxId = db.getEntityManager().createNativeQuery(
						"SELECT MAX(id) FROM task");
				Query queryInsert = db
						.getEntityManager()
						.createNativeQuery(
								"INSERT INTO task (id, name, description, project_id) VALUES (?1, ?2, ?3, ?4)");
				String taskName = req.getParameter("taskName");
				String taskDesc = req.getParameter("taskDesc");
				projectId = req.getParameter("projectId");

				try {
					Integer maxTaskId = (Integer) queryMaxId.getSingleResult();
					if (maxTaskId == null)
						maxTaskId = 0;
					Task task = new Task(maxTaskId + 1, 0, taskDesc, taskName);

					db.getEntityManager().getTransaction().commit();
					db.getEntityManager().getTransaction().begin();

					queryInsert.setParameter(1, task.getId());
					queryInsert.setParameter(2, task.getName());
					queryInsert.setParameter(3, task.getDescription());
					queryInsert.setParameter(4, projectId);
					queryInsert.executeUpdate();
					db.getEntityManager().getTransaction().commit();

				} catch (Exception ex) {
					db.getEntityManager().getTransaction().commit();
				}
			} else if (!queryName.getResultList().isEmpty()) {
				db.getEntityManager().getTransaction().commit();
				req.setAttribute("errorMessage",
						"Task already exists! Unique names are required!");
				RequestDispatcher dispatcher = getServletContext()
						.getRequestDispatcher(nextJSP);
				dispatcher.forward(req, resp);
				return;
			}

			else {
				db.getEntityManager().getTransaction().commit();
				req.setAttribute("errorMessage", "Task name required!");
				RequestDispatcher dispatcher = getServletContext()
						.getRequestDispatcher(nextJSP);
				dispatcher.forward(req, resp);
				return;
			}

			req.setAttribute("projectId", projectId);
			resp.sendRedirect(req.getContextPath() + "/project?projectId="
					+ projectId);

		}

	}
}
