package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import model.UserVO;
import mybatis.MybatisConnector;

public class UserDAO extends MybatisConnector{
	private final String namespace = "ldg.mybatis.user";
	private static UserDAO instance = new UserDAO();

	SqlSession sqlSession;

	private UserDAO() {}
	
	public static UserDAO getInstance() {
		return instance;
	}
	
	private int selectUser(String id) {
		sqlSession = sqlSession();
		int userid = sqlSession.selectOne(namespace + ".selectUser", id);

		return userid;
	}	
	
	public UserVO getUser(String id) {
		sqlSession = sqlSession();

		UserVO user = sqlSession.selectOne(namespace + ".getUser", id);
		
		sqlSession.close();

		return user;
	}
	
	public List<UserVO> getUsers(){
		sqlSession=sqlSession();
		
		List<UserVO> users=sqlSession.selectList(namespace + ".getUsers");
		
		return users;
	}
	
	public int usersCount() {
		sqlSession=sqlSession();
		
		int count=sqlSession.selectOne(namespace + ".usersCount");
		return count;
	}
	
	public int loginCheck(String id, String password) {
		sqlSession = sqlSession();

		Map map = new HashMap();
		map.put("id", id);
		map.put("password", password);

		int chk = sqlSession.selectOne(namespace + ".loginCheck", map);

		sqlSession.close();

		return chk;
	}
	
	public void insertUser(UserVO user) {
		sqlSession = sqlSession();
		
		if(user.getId().contains("admin_")) {
			user.setGrade(0);
			String id=user.getId().substring(user.getId().indexOf("_")+1);
			user.setId(id);
		} else {
			user.setGrade(1);
		}
		
		sqlSession.insert(namespace + ".insertUser", user);
		sqlSession.commit();
		sqlSession.close();
	}
	
	public int updateInfo(UserVO user) {
		sqlSession = sqlSession();
		
		int result=sqlSession.update(namespace + ".updateInfo", user);
		
		sqlSession.commit();
		sqlSession.close();
		
		return result;
	}
	
	public int deleteUser(UserVO user) {
		sqlSession = sqlSession();
		
		int result=sqlSession.delete(namespace + ".deleteUser", user);
		System.out.println("회원 삭제:"+result);
		sqlSession.commit();
		sqlSession.close();
		
		return result;
	}
	public int checkId(String id) {
		sqlSession = sqlSession();
		
		int chk = sqlSession.selectOne(namespace + ".checkId", id);		
		sqlSession.close();

		return chk;
	}
	
	public int checkNick(String nickname) {
		sqlSession = sqlSession();
		
		int chk = sqlSession.selectOne(namespace + ".checkNick", nickname);		
		sqlSession.close();

		return chk;
	}
	
	public int checkEmail(String email) {
		sqlSession = sqlSession();
		
		int chk = sqlSession.selectOne(namespace + ".checkEmail", email);		
		sqlSession.close();

		return chk;
	}
	
	public void online(String id) {
		sqlSession = sqlSession();

		sqlSession.update(namespace + ".online", id);

		sqlSession.commit();
		sqlSession.close();
	}

	public void offline(String id) {
		sqlSession = sqlSession();

		sqlSession.update(namespace + ".offline", id);

		sqlSession.commit();
		sqlSession.close();
	}
	
	public void ongame(String id) {
		sqlSession = sqlSession();

		sqlSession.update(namespace + ".ongame", id);

		sqlSession.commit();
		sqlSession.close();
	}

	public int findCheck(String nickname, String email) {
		sqlSession = sqlSession();

		Map map = new HashMap();
		map.put("nickname", nickname);
		map.put("email", email);
		int result = sqlSession.selectOne(namespace + ".findCheck", map);

		sqlSession.close();
		return result;
	}
	
	public String findId(String email) {
		sqlSession = sqlSession();
		
		String id = sqlSession.selectOne(namespace + ".findID", email);
		
		sqlSession.close();
		
		return id;
	}
	
	public int findPwd(String id, String email) {
		sqlSession = sqlSession();

		Map map = new HashMap();
		map.put("id", id);
		map.put("email", email);
		int result = sqlSession.selectOne(namespace + ".findPWD", map);

		sqlSession.close();
		return result;
	}
	
	public int updatePwd(String id,String password) {
		sqlSession = sqlSession();

		Map map = new HashMap();
		map.put("id", id);
		map.put("password", password);
		int result = sqlSession.update(namespace + ".updatePWD", map);
		
		sqlSession.commit();
		sqlSession.close();
		return result;
	}

	public List<UserVO> getRank() {
		sqlSession = sqlSession();
		List<UserVO> rank = sqlSession.selectList(namespace + ".getRank");
		
		return rank;
	}
}
