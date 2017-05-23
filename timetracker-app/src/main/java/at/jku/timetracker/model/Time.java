package at.jku.timetracker.model;

import java.sql.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="TIME")
public class Time {

	@Id
	@Column(name = "TASK_ID")
	private int task_id;
	
	@Column(name = "USER_ID")
	private int user_id;
	
	@Column(name = "START")
	private Date start;
	
	@Column(name = "END")
	private Date end;
	
	
	

	public Time() {
		super();
	}

	public Time(int task_id, int user_id, Date start, Date end) {
		super();
		this.task_id = task_id;
		this.user_id = user_id;
		this.start = start;
		this.end = end;
	}

	public int getTask_id() {
		return task_id;
	}

	public void setTask_id(int task_id) {
		this.task_id = task_id;
	}

	public int getUser_id() {
		return user_id;
	}

	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}

	public Date getStart() {
		return start;
	}

	public void setStart(Date start) {
		this.start = start;
	}

	public Date getEnd() {
		return end;
	}

	public void setEnd(Date end) {
		this.end = end;
	}

	
}
