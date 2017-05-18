package at.jku.timetracker.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="CATEGORY")
public class Category {

	@Id
	@Column(name="ID")
	private int id;
	
	@Column(name="DESCRIPTION")
	private String description;
	
	@Column(name="NAME")
	private String name;
	
	@Column(name="PROJECT_ID")
	private int project_id;
	
	

	public Category() {
		super();
	}



	public Category(int id, String description, String name, int project_id) {
		super();
		this.id = id;
		this.description = description;
		this.name = name;
		this.project_id = project_id;
	}



	public int getId() {
		return id;
	}



	public void setId(int id) {
		this.id = id;
	}



	public String getDescription() {
		return description;
	}



	public void setDescription(String description) {
		this.description = description;
	}



	public String getName() {
		return name;
	}



	public void setName(String name) {
		this.name = name;
	}



	public int getProject_id() {
		return project_id;
	}



	public void setProject_id(int project_id) {
		this.project_id = project_id;
	}
	
	
	
	
}
