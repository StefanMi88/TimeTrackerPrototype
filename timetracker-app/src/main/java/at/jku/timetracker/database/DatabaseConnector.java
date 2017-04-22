package at.jku.timetracker.database;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

public class DatabaseConnector {
	
	private EntityManager entityManager;
	
	public DatabaseConnector() {
		
		EntityManagerFactory emfactory = Persistence.createEntityManagerFactory("DBCON");
	    this.entityManager = emfactory.createEntityManager( );
			      
	}

	public EntityManager getEntityManager() {

		return this.entityManager;
	}

}
