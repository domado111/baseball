package websocket;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import dao.GameDAO;
import dao.UserDAO;
import game.BaseBall;
import model.GameVO;
import model.UserVO;
import room.Room;

@ServerEndpoint("/webGroup")
public class WebSocketServerGroup {
	GameDAO gameDao=GameDAO.getInstance();
	UserDAO userDao=UserDAO.getInstance();
	
	private static Set<Session> clients = Collections.synchronizedSet(new HashSet<Session>());
	Room room = Room.getInstance();
	BaseBall baseball = BaseBall.getInstance();

	@OnMessage
	public void onMessage(String message, Session session) throws IOException {
		room.roomListPrint();
		System.out.println(message);
		synchronized (clients) {
			/*
			 * 팀별 채팅을 위한 소스 group명:이름:
			 */
			String userAnswer = "";

			String sgroup = (String) session.getRequestParameterMap().get("group").get(0);
			String sid = (String) session.getRequestParameterMap().get("name").get(0);		

			
		
			//유저 닉네임 추출	
			
			UserVO userSend=userDao.getUser(sid);
			System.out.println(userSend);
			String movemessage =userSend.getNickname() + ":" + message;

			System.out.println(movemessage + "========movemessage");

			if (message.contains("@a@n@s@:")) {

				ArrayList userList=(ArrayList)room.roomGetUsers(sgroup);
				int userNum=userList.indexOf(sid);
				ArrayList userNickList=(ArrayList)room.roomGetUsersNick(sgroup);
				String userNick=(String)userNickList.get(userNum);
				String[] answer = message.split(":");
				
				userAnswer = "a!n!s!@" + userNick + "@" + answer[1] + "@"
						+ baseball.userAnswerCheck(answer[1], sgroup, sid,userList)+"@"+baseball.userTurnCount(sgroup, sid,userList);
				if (userAnswer.contains("승리")) {
					room.roomGameEnd(sgroup); // 방 상태 end로 변경
					
					//db에 데이터 업데이트
					GameVO game=new GameVO();
					game.setWinner(sid);
					int winnerCount=baseball.winnerTurnCount(sgroup,userList);
					int point=0;
					if(winnerCount==1) {
						point=1000;
					}else if(winnerCount<=5) {
						point=500;
					}else if(winnerCount<=10) {
						point=400;
					}else {
						point=300;
					}
					
					game.setPoint(point);
					game.setWinner_turn(winnerCount);
					game.setRoomname(sgroup);
					System.out.println(game+"<<<승리시 넣을 gameVO");
					
					gameDao.updateGame(game);
					
					//각 userDB 업데이트. 게임 중간에 나가면 패 체크 됨
					
					GameVO gameGet=new GameVO();
					gameGet=gameDao.getGame(sgroup);
					gameDao.updateUserGame(gameGet, point,userList);
					
					onMessage("@result@#@",session);
	
				}
			}

			for (Session client : clients) {
				/*
				 * cgroup : client에서 보내는 group명 sgroup : 서버가 가지고 있는 session group명 유저의 그룹명은
				 * sgroup임. 전체유저는 cgroup
				 */

				String cgroup = (String) client.getRequestParameterMap().get("group").get(0);

				System.out.println(cgroup + ":" + sgroup);
				if (sgroup.equals(cgroup)) {
					// 준비완료 여부
					
					if (message.equals("@ready@#@") || message.equals("@o@n@game@") || message.equals("@e@n@d@")) {
						String userReadyStr = message;
						ArrayList userList=(ArrayList)room.roomGetUsers(sgroup);
						
						System.out.println(userReadyStr + "==========ready or ongame or end 로 들어옴");
						ArrayList<String> userReadyList = new ArrayList<String>();
						for (int i = 0; i < userList.size(); i++) {
							userReadyList.add((String) room.getUserReady((String) userList.get(i)));
							// true true false ... 이런식으로 나옴(게임 종료시에는 winner포함)
						}
						for (int i = 0; i < userReadyList.size(); i++) {
							userReadyStr += ":" + userReadyList.get(i);
						}
				
						System.out.println(userReadyStr + "----userReadyStr");
						client.getBasicRemote().sendText(userReadyStr);
			
					}else if(message.equals("@result@#@")){

						ArrayList userList=(ArrayList)room.roomGetUsers(sgroup);
						int userNum=userList.indexOf(sid);
						ArrayList userNickList=(ArrayList)room.roomGetUsersNick(sgroup);
						
						String resultBoardData="@result@board@";
						
						//게임 시작시 전체 유저(닉네임)
						GameVO game=gameDao.getGame(sgroup);
						UserVO user1=userDao.getUser(game.getUser1());
						UserVO user2=userDao.getUser(game.getUser2());
						UserVO user3=userDao.getUser(game.getUser3());
						UserVO user4=userDao.getUser(game.getUser4());

						
						resultBoardData+="#"+user1.getNickname()+":"+user2.getNickname()+":"
										+user3.getNickname()+":"+user4.getNickname()+"#";
						
						//게임완료한 유저 리스트(닉네임)
						resultBoardData+=userNickList.get(0);
						for(int i=1;i<userNickList.size();i++) {
							resultBoardData+=":"+userNickList.get(i);
						}
						
						//게임 포인트, 게임 승리자
						
						UserVO winner=userDao.getUser(game.getWinner());
						resultBoardData+="#"+game.getPoint()+"#"+winner.getNickname();			
						System.out.println(resultBoardData+"===========resultBoardData!!!");
						client.getBasicRemote().sendText(resultBoardData);
						
					}else if (message.equals("@ok@#@")) {//게임 시작

						client.getBasicRemote().sendText(message);
							
					
					} else if (message.contains("@a@n@s@:")) {

						client.getBasicRemote().sendText(userAnswer);

					} else {//일반채팅
						
						client.getBasicRemote().sendText(movemessage);

					}

				}

			}
		}
	}

	@OnOpen
	public void onOpen(Session session) {
		room.roomListPrint();

		System.out.println("onOpen");
		System.out.println(session.getRequestParameterMap());
		// Add session to the connected sessions set
		synchronized (clients) {
			clients.add(session);
		}
		int count = 0;
		String sgroup = (String) session.getRequestParameterMap().get("group").get(0);

		for (Session client : clients) {
			String cgroup = (String) client.getRequestParameterMap().get("group").get(0);

			if (cgroup.equals(sgroup)) {
				// 같은그룹내
				count++;

			}
		}

		try {
			// 인원 수 보내기
			onMessage("@@@@@zxc" + ":" + count + "명", session);

			// 닉네임 보내기(현재 session유저와 비교)
			
			
			ArrayList nameList = (ArrayList) room.roomGetUsersNick(sgroup);

			String nameListStr = "";
			for (int i = 0; i < nameList.size(); i++) {
				nameListStr += ":" + nameList.get(i);
			}
			System.out.println(nameListStr + "< ===========nameListstr");

			onMessage("@n@a@m@e@" + nameListStr, session);

			// ready여부 보내기
			onMessage("@ready@#@", session);

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@OnClose
	public void onClose(Session session) {
		// Remove session from the connected sessions set

		clients.remove(session);
		System.out.println("onClose");

		int count = 0;
		String sgroup = (String) session.getRequestParameterMap().get("group").get(0);
		String sid = (String) session.getRequestParameterMap().get("name").get(0);

		for (Session client : clients) {
			String cgroup = (String) client.getRequestParameterMap().get("group").get(0);

			if (cgroup.equals(sgroup)) {
				// 같은그룹내
				count++;
			}
		}

		room.userReadyOut(sgroup, sid); // 유저 준비 완료 했을 시 준비완료에서 빼기
		room.roomUserOut(sgroup, sid); // 방 맵에서 유저 빼기
		

		System.out.println(count + "====onclose 할 때 client count");
		if (count != 0) {
			try {
				// 인원 수 보내기
				System.out.println(session);
				onMessage("@@@@@zxc" + ":" + count + "명", session);

				// 닉네임 보내기
				ArrayList nameList = (ArrayList) room.roomGetUsersNick(sgroup);
				String nameListStr = "";
				for (int i = 0; i < nameList.size(); i++) {
					nameListStr += ":" + nameList.get(i);
				}
				System.out.println(nameListStr + "< nameListstr");
				System.out.println(room.roomReadyStatus(sgroup));

				onMessage("@n@a@m@e@" + nameListStr, session);

				if (room.roomReadyStatus(sgroup).equals("onGame")) {
					System.out.println("onclose-ongame으로 들어옴");
					onMessage("@o@n@game@", session);

				} else if (room.roomReadyStatus(sgroup).equals("end")) {
					System.out.println("onclose-end으로 들어옴");
					onMessage("@e@n@d@", session);
				} else {
					onMessage("@ready@#@", session);

				}

			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		room.roomListPrint();
	}
}