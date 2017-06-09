package at.jku.timetracker;

public class TimeTracker {
	
	public static final String DBConnector = "DATABASECONNECTOR";
	public static final String User = "USER";
	
	public static Object NVL(Object data, Object nullData){
		if (data == null){
			return nullData;
		}else{
			return data;
		}
	}
}
