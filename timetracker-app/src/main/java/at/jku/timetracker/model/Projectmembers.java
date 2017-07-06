package at.jku.timetracker.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "PROJECT")
public class Projectmembers {

	@Id
	@Column(name = "ID")
	private int id;

	@Column(name = "USERNAME")
	private String username;

	@Column(name = "PROJECT_ID")
	private int project_id;

	public Projectmembers() {
		super();
	}

	public Projectmembers(int id, String username, int project_id) {
		this.id = id;
		this.username = username;
		this.project_id = project_id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public int getProjectId() {
		return project_id;
	}

	public void setProjectId(int project_id) {
		this.project_id = project_id;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

}
