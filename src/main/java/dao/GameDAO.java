package dao;


import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import mybatis.MybatisConnector;
import room.Room;
import model.GameVO;
import model.UserVO;

public class GameDAO extends MybatisConnector{
	UserDAO userDao=UserDAO.getInstance();
	Room room=Room.getInstance();
	
	private final String namespace = "ldg.mybatis.game";
	private static GameDAO instance = new GameDAO();

	SqlSession sqlSession;

	private GameDAO() {}
	
	public static GameDAO getInstance() {
		return instance;
	}
	
	
	public void insertGame(GameVO game) {
		sqlSession = sqlSession();
		int number=sqlSession.selectOne(namespace+".getNextNumber");
		game.setGame_num(number);
		
		sqlSession.insert(namespace+".insertGame",game);
		sqlSession.commit();
		sqlSession.close();
		
	}
	public void updateGame(GameVO game) {
		sqlSession = sqlSession();
		sqlSession.update(namespace+".updateGame",game);
		sqlSession.commit();
		sqlSession.close();
	}
	public int checkRoom(String roomName) {
		sqlSession = sqlSession();
		int chk=sqlSession.selectOne(namespace+".checkRoom",roomName);
		sqlSession.commit();
		sqlSession.close();
		
		return chk;
	}
	
	public GameVO getGame(String roomName) {
		sqlSession = sqlSession();
		System.out.println(roomName+"<><<<<<gameVO getGame 내 roomName");
		GameVO game=sqlSession.selectOne(namespace+".getGame",roomName);
		System.out.println(game.getWinner()+"======gameVO getGame 내 getWinner");
		
		sqlSession.close();
		
		return game;
	}
	public void updateUserGame(GameVO game,int point,ArrayList idList) {
		sqlSession = sqlSession();
		//게임시작시 있던 유저
		ArrayList<String> userList=new ArrayList<String>();
		userList.add((String)game.getUser1());
		userList.add((String)game.getUser2());
		userList.add((String)game.getUser3());
		userList.add((String)game.getUser4());
		String winner=game.getWinner();
		
		//게임종료까지 참여한 유저
		ArrayList<String> onGameUsers=idList;
		System.out.println(onGameUsers+"<<<<onGameUsers(updateUserGame내!)");
		
		Map map=new HashMap();
		for(int i=0;i<userList.size();i++) {
			String userId=(String)userList.get(i);
			map.put("userId", userId);
			UserVO user=userDao.getUser(userId);

			if(userId.equals(winner)) {
				int winCount=user.getWin_count()+1;
				int pointUp=user.getPoint()+point;
				map.put("winCount", winCount);
				map.put("point", pointUp);
				sqlSession.update(namespace+".updateWin",map);
			}else if(onGameUsers.contains(userId)){	//게임에 끝까지 참여했는지 확인
				int loseCount=user.getLose_count()+1;
				int pointUp=user.getPoint()+100;	//진사람 일괄적으로 100점 포인트
				map.put("loseCount", loseCount);
				map.put("point", pointUp);
				sqlSession.update(namespace+".updateLose",map);
			}else {	//게임에 끝까지 참여하지 않은 사람 (point 0)
				int loseCount=user.getLose_count()+1;
				map.put("loseCount", loseCount);
				sqlSession.update(namespace+".updateOutLose",map);

			}
		}

		sqlSession.commit();
		sqlSession.close();
	}
	
	public List getGameCountList(String dateInput) throws ParseException {
		List gameCountList=new ArrayList();

		sqlSession=sqlSession();
		Map map=new HashMap();
		map.put("dateInput", dateInput);
		gameCountList= sqlSession.selectList(namespace+".getGameCounts",map);
		
		sqlSession.close();
	
		return gameCountList;	
	}
	public int getGameDataCount() {
		sqlSession=sqlSession();
		int count=sqlSession.selectOne(namespace+".getGameDataCount");
		sqlSession.close();
		return count;
	}
}
