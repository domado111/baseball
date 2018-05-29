package dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;

import model.FriendVO;
import model.UserVO;
import mybatis.MybatisConnector;

public class FriendDAO extends MybatisConnector {
	private final String namespace = "ldg.mybatis.friend";

	private static FriendDAO instance = new FriendDAO();

	SqlSession sqlSession;

	private FriendDAO() {}

	public static FriendDAO getInstance() {
		return instance;
	}

	public UserVO getUser(String id) {
		sqlSession = sqlSession();

		UserVO user = sqlSession.selectOne(namespace + ".getUser", id);
		sqlSession.commit();
		sqlSession.close();

		return user;
	}

	public List<UserVO> getUsers(String id) {
		sqlSession = sqlSession();

		List<UserVO> users = sqlSession.selectList(namespace + ".getUsers", id);
		sqlSession.commit();
		sqlSession.close();

		return users;
	}

	private int selectUser(String id) {
		sqlSession = sqlSession();
		int userid = sqlSession.selectOne(namespace + ".selectUser", id);

		return userid;
	}

	private UserVO selectUserInfo(int usernum) {
		sqlSession = sqlSession();
		UserVO user = sqlSession.selectOne(namespace + ".selectUserInfo", usernum);

		return user;
	}

	public void userRegistration(String id) {
		sqlSession = sqlSession();
		int user = sqlSession.selectOne(namespace + ".selectUser", id);

		sqlSession.insert(namespace + ".userRegistration", user);
		sqlSession.commit();
		sqlSession.close();
	}

	public void addFriend(String id, String friendid) {
		sqlSession = sqlSession();

		int user_num = selectUser(id);
		int friend_num = selectUser(friendid);

		Map map = new HashMap();
		map.put("user_num", user_num);
		map.put("friend_num", friend_num);

		sqlSession.insert(namespace + ".addFriend", map);
		sqlSession.commit();
		sqlSession.close();
	}

	public int confirmFriend(String id, String friendid) {
		sqlSession = sqlSession();

		int user_num = selectUser(id);
		int friend_num = selectUser(friendid);

		Map map = new HashMap();
		map.put("user_num", user_num);
		map.put("friend_num", friend_num);

		int result = sqlSession.update(namespace + ".confirmFriend", map);
		sqlSession.commit();
		sqlSession.close();

		return result;
	}

	public FriendVO checkFriend(String id, String friendid) {
		FriendVO chkFriend = null;
		sqlSession = sqlSession();

		int user_num = selectUser(id);
		int friend_num = selectUser(friendid);

		Map map = new HashMap();
		map.put("user_num", user_num);
		map.put("friend_num", friend_num);

		chkFriend = sqlSession.selectOne(namespace + ".checkFriend", map);
		sqlSession.commit();
		sqlSession.close();

		return chkFriend;
	}	

	public List<UserVO> receiveRequest(String id) {
		sqlSession = sqlSession();

		List<UserVO> users = sqlSession.selectList(namespace + ".receiveRequest", id);
		sqlSession.commit();
		sqlSession.close();

		return users;
	}

	public List<UserVO> sendRequest(String id) {
		sqlSession = sqlSession();

		List<UserVO> users = sqlSession.selectList(namespace + ".sendRequest", id);
		sqlSession.commit();
		sqlSession.close();

		return users;
	}

	public int cancleRequest(String id, String friendid) {
		sqlSession = sqlSession();

		int user_num = selectUser(id);
		int friend_num = selectUser(friendid);

		Map map = new HashMap();
		map.put("user_num", user_num);
		map.put("friend_num", friend_num);

		int result = sqlSession.delete(namespace + ".cancleRequest", map);
		System.out.println(result);
		sqlSession.commit();
		sqlSession.close();

		return result;
	}

	public int rejectRequest(String id, String friendid) {
		sqlSession = sqlSession();

		int user_num = sqlSession.selectOne(namespace + ".selectUser", id);
		int friend_num = sqlSession.selectOne(namespace + ".selectUser", friendid);

		Map map = new HashMap();
		map.put("user_num", user_num);
		map.put("friend_num", friend_num);

		int result = sqlSession.delete(namespace + ".rejectRequest", map);
		sqlSession.commit();
		sqlSession.close();

		return result;
	}

	public List<UserVO> getFriends(String id) {
		sqlSession = sqlSession();

		int user_num = selectUser(id);
		List<FriendVO> friend_num = sqlSession.selectList(namespace + ".getFriends", user_num);
		List<UserVO> friendlist = new ArrayList();
		UserVO user;

		for (FriendVO f : friend_num) {
			if (f.getFriend_one() != user_num) {
				user = selectUserInfo(f.getFriend_one());
				friendlist.add(user);
			}
			if (f.getFriend_two() != user_num) {
				user = selectUserInfo(f.getFriend_two());
				friendlist.add(user);
			}
		}

		sqlSession.commit();
		sqlSession.close();

		System.out.println(friendlist.toString());
		return friendlist;
	}
	
	public int friendCount(String id) {
		sqlSession = sqlSession();

		int user_num = selectUser(id);
		int count=sqlSession.selectOne(namespace+".friendCount",user_num);

		sqlSession.commit();
		sqlSession.close();
		
		return count;
	}
	
	public List<UserVO> friendSearch(String userid,  String friendnick){
		sqlSession = sqlSession();
		
		Map searchmap = new HashMap();		
		searchmap.put("id", userid);
		searchmap.put("friendnick", friendnick);
		
		int user_num=selectUser(userid);
		List<UserVO> users=new ArrayList();
		users=sqlSession.selectList(namespace+".friendSearch",searchmap);
		
		for(Iterator<UserVO> it=users.iterator(); it.hasNext();) {
			UserVO user=it.next();
			Map countmap = new HashMap();
			countmap.put("user_num", user_num);
			countmap.put("friend_num", user.getUser_num());
			int i=sqlSession.selectOne(namespace+".friendCheck",countmap);
			if(i!=0) {
				it.remove();
			}
		}
		
		System.out.println(users);
		
		sqlSession.close();
		
		return users;
	}
}
