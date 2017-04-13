package at.jku.timetracker.database;

import static org.junit.Assert.*;

import org.junit.Test;

import at.jku.timetracker.model.User;

public class DatabaseTest {

	@Test
	public void test() {

			System.out.println("Start Test");

			DatabaseConnector db = new DatabaseConnector();
			db.getEntityManager().getTransaction().begin();
			db.getEntityManager().createNativeQuery("update User set username = 'max'").executeUpdate();
			
			
			User u = new User();
			u.setUsername("test");
			db.getEntityManager().persist(u);
			db.getEntityManager().getTransaction().commit();
			
			
			
			db.getEntityManager().getTransaction().begin();
			String p  =  (String) db.getEntityManager().createQuery("Select ü.username from User").getSingleResult();
			
			
			System.out.println(p);
		}

}
