package at.jku.timetracker;

import java.io.IOException;
import java.util.*;
import java.sql.Date;
import java.sql.Timestamp;

import javax.persistence.NoResultException;
import javax.persistence.Query;
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
public class StartTimeServlet extends HttpServlet{
	
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		DatabaseConnector db;

		if (this.getServletContext().getAttribute(TimeTracker.DBConnector) == null) {
			db = new DatabaseConnector();
			this.getServletContext().setAttribute(TimeTracker.DBConnector, db);
		} else {
			db = (DatabaseConnector) this.getServletContext().getAttribute(
					TimeTracker.DBConnector);
		}
		
		Project p;
		String project = req.getParameter("project");
		String task = req.getParameter("task");
		
		
		try {
			int taskId = Integer.parseInt(task);
			
			Timestamp curtime = null;
		      
		      if (req.getParameter("curtime") != null && 
		          !req.getParameter("curtime").equals("")) {
		    	  curtime = Timestamp.valueOf(req.getParameter("curtime"));
		      }
		      else
		      {
		    	  //java.util.Date utilDate = new java.util.Date();
		    	  //curtime = new java.sql.Date(utilDate.getTime());
		    	  curtime =  new java.sql.Timestamp(System.currentTimeMillis());
		      }
		   
		      db.getEntityManager().getTransaction().begin();	
		    Query querySelect = db.getEntityManager().createNativeQuery("Select * from time t where t.task_id = ? AND t.user_id = ? AND t.end IS NULL", Time.class);
		    
		    querySelect.setParameter(1, taskId);
		    querySelect.setParameter(2, 1);
			List<Time> values = querySelect.getResultList();
			
			 db.getEntityManager().getTransaction().commit();
			
			if (values != null && !values.isEmpty())
			{
				for (Time time : values) {
					time.setEnd(curtime);
					
					db.getEntityManager().getTransaction().begin();
					//Query queryUpdate = db.getEntityManager().createQuery("UPDATE time t SET t.end = "+ time.getEnd() +" where t.task_id = "+ time.getTask_id() +" AND t.user_id = "+ time.getUser_id() + " AND t.start = "+ time.getStart() +"");
					Query queryUpdate = db.getEntityManager().createNativeQuery("UPDATE time t SET t.end = ? where t.task_id = ? AND t.user_id = ? AND t.start = ?");
					queryUpdate.setParameter(1, time.getEnd());
					queryUpdate.setParameter(2, time.getTask_id());
					queryUpdate.setParameter(3, time.getUser_id());
					queryUpdate.setParameter(4, time.getStart());					
					queryUpdate.executeUpdate();
					db.getEntityManager().getTransaction().commit();
					
					break;		            
				}
			}
			else
			{
				Time t = new Time(taskId , 1, curtime, null);
				Query queryInsert = db.getEntityManager().createNativeQuery("INSERT INTO time (task_id, user_id, start, end) VALUES (?, ?, ?, ?)");
				
				db.getEntityManager().getTransaction().begin();
				//db.getEntityManager().persist(t);
				queryInsert.setParameter(1, t.getTask_id());
				queryInsert.setParameter(2, t.getUser_id());
				queryInsert.setParameter(3, t.getStart());
				queryInsert.setParameter(4, t.getEnd());
				queryInsert.executeUpdate();
				db.getEntityManager().getTransaction().commit();
			}
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
		
		resp.sendRedirect(req.getContextPath() + "/tracker");
		return;
		
	}

}
