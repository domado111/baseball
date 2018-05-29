package model;

public class FriendVO {
	private int friend_one;
	private int friend_two;
	private String status;
	
	public int getFriend_one() {
		return friend_one;
	}
	public void setFriend_one(int friend_one) {
		this.friend_one = friend_one;
	}
	public int getFriend_two() {
		return friend_two;
	}
	public void setFriend_two(int friend_two) {
		this.friend_two = friend_two;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	@Override
	public String toString() {
		return "FriendDataBean [friend_one=" + friend_one + ", friend_two=" + friend_two + ", status=" + status + "]";
	}
}
