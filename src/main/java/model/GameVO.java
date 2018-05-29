package model;

import java.util.Date;

public class GameVO {
	private int game_num;
	private String roomname;
	private String user1;
	private String user2;
	private String user3;
	private String user4;
	private String winner;
	private int point;
	private int winner_turn;
	private Date start_date;
	private Date end_date;
	public int getGame_num() {
		return game_num;
	}
	public void setGame_num(int game_num) {
		this.game_num = game_num;
	}
	public String getRoomname() {
		return roomname;
	}
	public void setRoomname(String roomname) {
		this.roomname = roomname;
	}
	public String getUser1() {
		return user1;
	}
	public void setUser1(String user1) {
		this.user1 = user1;
	}
	public String getUser2() {
		return user2;
	}
	public void setUser2(String user2) {
		this.user2 = user2;
	}
	public String getUser3() {
		return user3;
	}
	public void setUser3(String user3) {
		this.user3 = user3;
	}
	public String getUser4() {
		return user4;
	}
	public void setUser4(String user4) {
		this.user4 = user4;
	}
	public String getWinner() {
		return winner;
	}
	public void setWinner(String winner) {
		this.winner = winner;
	}
	public int getPoint() {
		return point;
	}
	public void setPoint(int point) {
		this.point = point;
	}
	public int getWinner_turn() {
		return winner_turn;
	}
	public void setWinner_turn(int winner_turn) {
		this.winner_turn = winner_turn;
	}
	public Date getStart_date() {
		return start_date;
	}
	public void setStart_date(Date start_date) {
		this.start_date = start_date;
	}
	public Date getEnd_date() {
		return end_date;
	}
	public void setEnd_date(Date end_date) {
		this.end_date = end_date;
	}
	
	
}
