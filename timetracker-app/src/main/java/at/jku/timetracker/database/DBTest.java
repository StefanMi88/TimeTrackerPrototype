package at.jku.timetracker.database;

import at.jku.timetracker.model.User;

public class DBTest {

	public static void main(String[] args) {
		System.out.println("Start Test");
		
		DatabaseConnector db = new DatabaseConnector();
		
		System.out.println("Insert Entity");
		
		User u = new User("test", "test1", "test2");
		db.getEntityManager().getTransaction().begin();
		db.getEntityManager().persist(u);
		db.getEntityManager().getTransaction().commit();
		
		System.out.println("Update Entity");
		
		db.getEntityManager().getTransaction().begin();
		db.getEntityManager().createQuery("Update User u set u.password = '123' where u.username = 'test'").executeUpdate();
		db.getEntityManager().getTransaction().commit();
		
		System.out.println("Select Entity");
		
		db.getEntityManager().getTransaction().begin();
		u = (User) db.getEntityManager().createQuery("Select u from User u where u.username = 'test'").getSingleResult();
		db.getEntityManager().getTransaction().commit();
		
		System.out.println("Delete Entity");
		
		db.getEntityManager().getTransaction().begin();
		db.getEntityManager().createQuery("Delete from User u where u.username = 'test'").executeUpdate();
		db.getEntityManager().getTransaction().commit();

	}
}
