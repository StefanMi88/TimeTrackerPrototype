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
			db = (DatabaseConnector) this.getServletContext().getAttribute(TimeTracker.DBConnector);
		}
				
		String nextJSP = "/jsp/project.jsp";
		RequestDispatcher dispatcher = getServletContext()
				.getRequestDispatcher(nextJSP);
		dispatcher.forward(req, resp);
		
	}
	
	/* (non-Javadoc)
	 * @see javax.servlet.http.HttpServlet#doPost(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
	 */
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		String name = req.getParameter("name");
		String desc = req.getParameter("desc");
		String action = req.getParameter("action");
		String projectId = req.getParameter("projectId");
		System.out.println(action);
		DatabaseConnector db;
		
		if (this.getServletContext().getAttribute(TimeTracker.DBConnector) == null){
			db = new DatabaseConnector();
			this.getServletContext().setAttribute(TimeTracker.DBConnector, db);
		}else {
			db = (DatabaseConnector) this.getServletContext().getAttribute(TimeTracker.DBConnector);
		}
		
		if (action.equals("add")) {
			
			db.getEntityManager().getTransaction().begin();	 
			Query queryMaxId = db.getEntityManager().createNativeQuery("SELECT MAX(id)FROM project");
			Query queryInsert = db.getEntityManager().createNativeQuery("INSERT INTO project (id, name, description) VALUES (?, ?, ?)");
			
			try {
				
				Integer maxProjectId = (Integer)queryMaxId.getSingleResult();
				Project prj = new Project(maxProjectId +1, name, desc);
				projectId = "" + (maxProjectId + 1);
				
				db.getEntityManager().getTransaction().commit();
				db.getEntityManager().getTransaction().begin();	
				queryInsert.setParameter(1, prj.getId());
				queryInsert.setParameter(2, prj.getName());
				queryInsert.setParameter(3, prj.getDescription());
				queryInsert.executeUpdate();
				db.getEntityManager().getTransaction().commit();
				
			} catch (Exception ex) {
				db.getEntityManager().getTransaction().commit();
			}				
			
						
			this.getServletContext().setAttribute("PROJECTID", projectId);
			resp.sendRedirect(req.getContextPath()+ "/project");
		}
		//Update Project
		else if (action.equals("edit")) {
			db.getEntityManager().getTransaction().begin();	
			projectId = req.getParameter("projectId");
			Query queryUpdate = db.getEntityManager().createNativeQuery("UPDATE project SET name = ?, description = ? WHERE id = ?");
			try {
				//projectId = (String) query.getSingleResult();
				// Insert new Project in DB
				queryUpdate.setParameter(1, name);
				queryUpdate.setParameter(2, desc);
				queryUpdate.setParameter(3, projectId);
				queryUpdate.executeUpdate();
				db.getEntityManager().getTransaction().commit();
				
			} catch (Exception ex) {
				db.getEntityManager().getTransaction().commit();
			}
			
			this.getServletContext().setAttribute("PROJECTID", projectId);
			resp.sendRedirect(req.getContextPath()+ "/project?projectId="+projectId);
		} 
		else if (action.equals("delete")) {
			db.getEntityManager().getTransaction().begin();	 
			Query queryDelete = db.getEntityManager().createNativeQuery("DELETE FROM project WHERE id = ?");
			Query queryDeleteTask = db.getEntityManager().createNativeQuery("DELETE FROM Task WHERE project_id = ?");
			projectId = req.getParameter("projectId");
			try {
				//projectId = (String) query.getSingleResult();
				// Insert new Project in DB
				queryDelete.setParameter(1, projectId);
				queryDelete.executeUpdate();
				queryDeleteTask.setParameter(1, projectId);
				queryDeleteTask.executeUpdate();
				db.getEntityManager().getTransaction().commit();
				
			} catch (Exception ex) {
				db.getEntityManager().getTransaction().commit();
			}
	
			this.getServletContext().setAttribute("PROJECTID", projectId);
			resp.sendRedirect(req.getContextPath()+ "/project");
		}
		else if (action.equals("addTask")) {
			
			db.getEntityManager().getTransaction().begin();	 
			Query queryMaxId = db.getEntityManager().createNativeQuery("SELECT MAX(id)FROM Task");
			Query queryInsert = db.getEntityManager().createNativeQuery("INSERT INTO TASK (id, name, description, project_id) VALUES (?, ?, ?, ?)");
			String taskName = req.getParameter("taskName");
			String taskDesc = req.getParameter("taskDesc");
			projectId = req.getParameter("projectId");
			
			try {
				Integer maxTaskId = (Integer)queryMaxId.getSingleResult();
				Task task = new Task(maxTaskId +1, 0, taskName, taskDesc);
								
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
			
			req.setAttribute("projectId", projectId);
			resp.sendRedirect(req.getContextPath()+ "/project?projectId="+projectId);
		
		}
		
	}
}
