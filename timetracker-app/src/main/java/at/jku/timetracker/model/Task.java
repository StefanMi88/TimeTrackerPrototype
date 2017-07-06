package at.jku.timetracker.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "TASK")
public class Task {

	@Id
	@Column(name = "ID")
	private int id;

	@Column(name = "CATEGORY_ID")
	private int category_id;

	@Column(name = "PROJECT_ID")
	private int project_id;

	@Column(name = "DESCRIPTION")
	private String description;

	@Column(name = "NAME")
	private String name;

	public Task() {
		super();
	}

	public Task(int id, int category_id, int project_id, String description,
			String name) {
		super();
		this.id = id;
		this.category_id = category_id;
		this.project_id = project_id;
		this.description = description;
		this.name = name;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getCategory_id() {
		return category_id;
	}

	public void setCategory_id(int category_id) {
		this.category_id = category_id;
	}

	public int getProject_id() {
		return project_id;
	}

	public void setProject_id(int project_id) {
		this.project_id = project_id;
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

	public Task(int id, int project_id, String description, String name) {
		super();
		this.id = id;
		this.project_id = project_id;
		this.description = description;
		this.name = name;
	}

}
