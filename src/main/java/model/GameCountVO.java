package model;

import java.util.Date;

public class GameCountVO {
	private String start_date;
	private int count;
	
	public String getStart_date() {
		return start_date;
	}
	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	@Override
	public String toString() {
		return "GameCountVO [start_date=" + start_date + ", count=" + count + "]";
	}
	
	
	
}
