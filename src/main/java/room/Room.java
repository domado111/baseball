package room;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dao.GameDAO;
import dao.UserDAO;
import game.BaseBall;

public class Room {
	private static Room instance = new Room();
	UserDAO userDao= UserDAO.getInstance();
	GameDAO gameDao= GameDAO.getInstance();
	
	public static Room getInstance() {
		return instance;
	}

	private Room() {

	}

	BaseBall baseball = BaseBall.getInstance();

	List<String> roomNameList = new ArrayList<String>(); // 방 이름만 뽑아 줌-map에서 key값 찾는 용도. !! 나중에 방 삭제시 방이름 지워야함

	// 유저관련
	Map<String, Integer> roomUserNum = new HashMap<String, Integer>(); // 방이름-유저 명 수 매칭
	Map<String, List> roomUser = new HashMap<String, List>(); // 방이름-유저이름 매칭
	Map<String, List> roomUserNick=new HashMap<String,List>(); //방이름 - 닉네임 넣어줌
	Map<String, String> userReady = new HashMap<String, String>(); // 유저이름-준비완료 여부, 게임종료 시 승리자 표기

	// 게임 관련
	Map<String, String> roomOngame = new HashMap<String, String>(); // 방이름-게임중/웨이팅/게임끝
	Map<String, Integer> roomReadyCount = new HashMap<String, Integer>(); // 방이름-준비완료 한 유저 수

	// !--방 생성 현황 출력용
	public void roomListPrint() {
		System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~roomNameList : " + roomNameList);
	}

	// !!!!!--------게임 ready관련
	public boolean roomGameOn(String roomName, String id) {
		roomReadyUp(roomName, id);
		if (roomReadyCount.get(roomName) == 4) {
			roomOngame.put(roomName, "onGame");
			System.out.println(roomOngame);
			return true;
		}
		return false;
	}

	// 게임 끝날 때 방 상태 바꿔줌
	public void roomGameEnd(String roomName) {
		roomOngame.put(roomName, "end");
		String winnerId = baseball.winnerExtract(roomName);
		userReady.put(winnerId, "winner");

	}

	public void roomReadyUp(String roomName, String id) {
		System.out.println(roomReadyCount + "=====count올리기 전");
		roomReadyCount.put(roomName, (int) roomReadyCount.get(roomName) + 1);
		System.out.println(roomReadyCount + "=====count올린 후");
		userReady.put(id, "true");
	}

	public void userReadyOut(String roomName, String id) {
		if (userReady.containsKey(id)) {
			userReady.remove(id);
			System.out.println(roomReadyCount + "=======게임 종료 시 roomReadyCount<userReadyOut 메서드 내");
			roomReadyCount.put(roomName, (int) roomReadyCount.get(roomName) - 1);
			System.out.println(roomReadyCount + "=====유저 나간 후 readyCount");
		}
	}

	public String roomReadyStatus(String roomName) {
		return (String) roomOngame.get(roomName);
	}

	public String getUserReady(String id) {
		return userReady.get(id);

	}

	// !!!!!--------유저 리스트 return
	public List roomGetUsers(String userRoom) {
		ArrayList userList = (ArrayList) roomUser.get(userRoom);
		System.out.println(userList+"<<<<<<리턴userList");
		return userList;

	}
	public List roomGetUsersNick(String userRoom) {
		ArrayList userList=(ArrayList) roomUserNick.get(userRoom);
		return userList;

	}
	
	// !!!!!--------유저 나갈 때
	public void roomUserOut(String userRoom, String id) {
		// 유저 명단 빼기
		ArrayList userList = (ArrayList) roomUser.get(userRoom);
		
		int userNum=userList.indexOf(id);
		System.out.println(userNum+"==========roomUserOut. 뺄 index");
		//유저 닉네임 지움
		ArrayList userNickList=(ArrayList) roomUserNick.get(userRoom);
		userNickList.remove(userNum);
		roomUserNick.put(userRoom, userNickList); //유저 닉 뺀 나머지 리스트 다시 넣음
		
		userList.remove(id);//유저 id 지움
		roomUser.put(userRoom, userList); // 유저 뺀 나머지 리스트 다시 넣음
		
		System.out.println(userList + " < ==========유저 나갈 시 userList");
		System.out.println(userNickList+"<==========유저 나갈 시 userNickList");
		
		// 유저 카운트 빼기
		roomUserNum.put(userRoom, (int) roomUserNum.get(userRoom) - 1);
		System.out.println(roomUserNum.get(userRoom) + "< ==========유저 나갈 시 roomUserNum");
		System.out.println(roomOngame.get(userRoom) + "<============유저 나갈 시 roomOngame");
		// roomOngame-onGame 게임중 상태 면서 방 유저 수가 0명일 때 방 삭제(게임 종료 후 삭제과정)
		
		//게임중간에 나갈 때 게임 turnCount빼줌
		if(((String) roomOngame.get(userRoom)).equals("end") || ((String) roomOngame.get(userRoom)).equals("onGame")) {
			baseball.gameCountOut(userRoom, userNum);
		}
		
		
		if ((((String) roomOngame.get(userRoom)).equals("end") || ((String) roomOngame.get(userRoom)).equals("onGame"))
				&& (int) roomUserNum.get(userRoom) == 0) {

			// 방-유저 정보 삭제
			roomNameList.remove(userRoom);

			System.out.println(roomNameList + "====roomNameList(방삭제후)");

			roomUserNum.remove(userRoom);
			roomUser.remove(userRoom);
			roomUserNick.remove(userRoom);
			roomOngame.remove(userRoom);
			roomReadyCount.remove(userRoom);

			// 게임데이터 삭제
			baseball.gameDelete(userRoom);

		}

	}

	// !!!!!--------방 매칭 관련
	public String roomMatch(ArrayList names) {
		boolean check = false;
		String roomName = "";
		int namesCount = names.size(); // 진입한 인원 수
		//유저닉이 미리 있으면 같이 들어가게 if 넣기
		
		for (int i = 0; i < roomNameList.size(); i++) { // roomName의 방 이름 명단으로 map의 키값 서치
			roomName = roomNameList.get(i);
			if ((int) roomUserNum.get(roomName) + namesCount <= 4 && roomOngame.get(roomName).equals("wait")) {
				// 방에 있는 유저 수와 새로 들어온 유저 리스트합이 4보다 같거나 작은지 체크 , 방 상태가 현재 게임중인지 체크
				// 4보다 작으면 방에 추가
				System.out.println(roomName + "< roomName");

				roomUserNum.put(roomName, (int) roomUserNum.get(roomName) + namesCount);
				// 방이름-유저 수 추가

				List userList = (ArrayList) roomUser.get(roomName);
				List userNickList=(ArrayList) roomUserNick.get(roomName);
				
				for (int k = 0; k < names.size(); k++) {
					if (!userList.contains(names.get(k))) {
						userList.add(names.get(k)); // 들어온 유저 이름을 새롭게 추가
						
						//db에서 닉네임 추출
						String nickname=userDao.getUser((String)names.get(k)).getNickname();
						
						userNickList.add(nickname);	//db에서 가져온 닉네임 추가
					}
				}
				roomUser.put(roomName, userList); // roomUser 맵 업데이트
				roomUserNick.put(roomName, userNickList);	//roomUserNick 맵 업데이트
				System.out.println(userList + "< ==============userList");
				System.out.println(roomUser+"<==roomUser");
				System.out.println(userNickList + "< ==============userList");
				check = true;
				break; // 반복문에서 나옴
			}
		}
		if (!check) { // 들어갈 방이 없을 때
			String newRoom = roomMaker(); // 새로운 방 생성

			roomUserNum.put(newRoom, names.size()); // 유저 추가
			System.out.println(roomUserNum.get(newRoom) + " < 방 새로 생성 시 roomUserNum");
			roomUser.put(newRoom, names); // 방이름 - 유저 new ArrayList 추가
			
			//유저 닉네임 리스트 추가
			List<String> userNickList=new ArrayList<String>();
			for(int i=0;i<names.size();i++) {
				String nickname=userDao.getUser((String)names.get(i)).getNickname();
				userNickList.add(nickname);
			}
			roomUserNick.put(newRoom, userNickList);
			roomOngame.put(newRoom, "wait"); // 방생성시 방 현황 세팅
			roomReadyCount.put(newRoom, 0); // 방생성시 방 readyCount 세팅

			return newRoom; // 새로생성한 방이름
		}
		return roomName; // 기존의 방이름

	}

	public String roomMaker() {
		String newName = nameMaker();
		if (roomNameList.contains(newName)) { // 방이름이 이미 포함되어 있으면 이름 다시 뽑아야함.
			roomMaker();
		}
		// 중복되는 방 이름이 없을 때

		roomNameList.add(newName); // 방이름 추가
		roomUserNum.put(newName, 0); // 방이름-유저 0명 초기화
		roomUser.put(newName, new ArrayList()); // 방이름 - 유저 new ArrayList 추가
		roomUserNick.put(newName, new ArrayList());//방이름- 유저 닉네임 new ArrayList 추가
		
		return newName; // 새로 만든 방이름 리턴해줌
	}

	public String nameMaker() { // 6자리의 방 이름 뽑아줌
		String roomName = "";
		String[] keyWord = { "A", "B", "C", "D", "E", "F", "G", "H", "I", 
				"1", "2", "3", "4", "5", "6", "7", "8", "9", "0" };

		for (int i = 0; i < 6; i++) {
			int rand = (int) (Math.random() * keyWord.length);
			roomName += keyWord[rand];
		}
		//db에 값있나 체크
		int check=gameDao.checkRoom(roomName);
		if(check==1) {
			nameMaker();
		}

		return roomName;
	}
}
