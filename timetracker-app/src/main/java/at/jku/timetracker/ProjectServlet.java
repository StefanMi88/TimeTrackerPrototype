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
import at.jku.timetracker.model.Project;;

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
		
		//String projectId = req.getParameter("projectId");
		
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
			//Query query = db.getEntityManager().createNativeQuery("Select projectId from project where name = '" + name + "'");
			
			try {
				//projectId = (String) query.getSingleResult();
				Integer maxProjectId = (Integer)queryMaxId.getSingleResult();
				Project prj = new Project(maxProjectId +1, name, desc);
				projectId = "" + (maxProjectId + 1);
				
				db.getEntityManager().getTransaction().commit();
				db.getEntityManager().getTransaction().begin();	
				// Insert new Project in DB
				//db.getEntityManager().persist(prj);
				queryInsert.setParameter(1, prj.getId());
				queryInsert.setParameter(2, prj.getName());
				queryInsert.setParameter(3, prj.getDescription());
				queryInsert.executeUpdate();
				db.getEntityManager().getTransaction().commit();
				
			} catch (javax.persistence.NoResultException exNoResult) {
				// TODO: handle exception
				db.getEntityManager().getTransaction().commit();
			}
			catch (javax.persistence.NonUniqueResultException exNonUnique) {
				// TODO: handle exception
				db.getEntityManager().getTransaction().commit();
			}
			catch (java.lang.IllegalStateException exIllegal) {
				db.getEntityManager().getTransaction().commit();
			}
			finally
			{
				
			}
			
			if (projectId.equals(desc)) {
				
			}else{
					// ToDo
					// auf Fehler Page verweisen 
				/*
					try {
						throw new Exception("Wrong Password:" + projectId + desc);
					} catch (Exception e) {
						e.printStackTrace();
						String nextJSP = "/jsp/project.jsp";
						RequestDispatcher dispatcher = getServletContext()
								.getRequestDispatcher(nextJSP);
						dispatcher.forward(req, resp);
					}
					*/
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
				
			} catch (javax.persistence.NoResultException exNoResult) {
				// TODO: handle exception
				db.getEntityManager().getTransaction().commit();
			}
			catch (javax.persistence.NonUniqueResultException exNonUnique) {
				// TODO: handle exception
				db.getEntityManager().getTransaction().commit();
			}
			catch (java.lang.IllegalStateException exIllegal) {
				db.getEntityManager().getTransaction().commit();
			}
			finally {}
			
			this.getServletContext().setAttribute("PROJECTID", projectId);
			resp.sendRedirect(req.getContextPath()+ "/project");
		} 
		else if (action.equals("delete")) {
			db.getEntityManager().getTransaction().begin();	 
			Query queryDelete = db.getEntityManager().createNativeQuery("DELETE FROM project WHERE id = ?");
			projectId = req.getParameter("projectId");
			try {
				//projectId = (String) query.getSingleResult();
				// Insert new Project in DB
				queryDelete.setParameter(1, projectId);
				queryDelete.executeUpdate();
				db.getEntityManager().getTransaction().commit();
				
			} catch (javax.persistence.NoResultException exNoResult) {
				// TODO: handle exception
				db.getEntityManager().getTransaction().commit();
			}
			catch (javax.persistence.NonUniqueResultException exNonUnique) {
			// TODO: handle exception
				db.getEntityManager().getTransaction().commit();
			}
			catch (java.lang.IllegalStateException exIllegal) {
				db.getEntityManager().getTransaction().commit();
			}
			finally{}
	
			this.getServletContext().setAttribute("PROJECTID", projectId);
			resp.sendRedirect(req.getContextPath()+ "/project");
		}
	}
}
