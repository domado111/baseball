package model;

import java.util.Date;

public class UserVO {
	private int user_num;
	private int grade;
	private String id;
	private String password;
	private String email;
	private String nickname;
	private int win_count;
	private int lose_count;
	private int point;
	private int friend_count;
	private int status;
	private Date reg_date;
	
	public int getUser_num() {
		return user_num;
	}
	public void setUser_num(int user_num) {
		this.user_num = user_num;
	}
	public int getGrade() {
		return grade;
	}
	public void setGrade(int grade) {
		this.grade = grade;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public int getWin_count() {
		return win_count;
	}
	public void setWin_count(int win_count) {
		this.win_count = win_count;
	}
	public int getLose_count() {
		return lose_count;
	}
	public void setLose_count(int lose_count) {
		this.lose_count = lose_count;
	}
	public int getPoint() {
		return point;
	}
	public void setPoint(int point) {
		this.point = point;
	}
	public int getFriend_count() {
		return friend_count;
	}
	public void setFriend_count(int friend_count) {
		this.friend_count = friend_count;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public Date getReg_date() {
		return reg_date;
	}
	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}
	@Override
	public String toString() {
		return "UserVO [user_num=" + user_num + ", grade=" + grade + ", id=" + id + ", password=" + password
				+ ", email=" + email + ", nickname=" + nickname + ", win_count=" + win_count + ", lose_count="
				+ lose_count + ", point=" + point + ", friend_count=" + friend_count + ", status=" + status
				+ ", reg_date=" + reg_date + "]";
	}
}
