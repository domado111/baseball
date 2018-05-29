package game;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;



public class BaseBall {
	
	private static BaseBall instance=new BaseBall();
	public static BaseBall getInstance() {
		return instance;
	}
	private BaseBall() {
		
	}
	
	Map<String,String> roomAnswer=new HashMap<String,String>();//방이름-정답
	Map<String,ArrayList<Integer>> roomGameCount=new HashMap<String,ArrayList<Integer>>();//방이름-턴 카운트
	Map<String,String> roomGameWinner=new HashMap<String,String>(); //방이름-승리자 id
	
	public String winnerExtract(String roomName) {
		return (String)roomGameWinner.get(roomName);
	}
	
	public int winnerTurnCount(String roomName,ArrayList userid) {
		//userList에서 userNum뽑음
		ArrayList userList=userid;
		int userNum=userList.indexOf((String)roomGameWinner.get(roomName));
		
		//turnCount
		ArrayList turnCount=roomGameCount.get(roomName);
		return (Integer)turnCount.get(userNum);
		
	}
	public int userTurnCount(String roomName,String id,ArrayList userid) {
		//userList에서 userNum뽑음
		ArrayList userList=userid;
		int userNum=userList.indexOf(id);
		
		//turnCount
		ArrayList turnCount=roomGameCount.get(roomName);
		return (Integer)turnCount.get(userNum);	
	}
	
	public void gameDelete(String roomName) {
		roomAnswer.remove(roomName);
		roomGameCount.remove(roomName);
		//roomGameWinner.remove(roomName);
	}
	public void gameCountOut(String roomName,int userNum){
		ArrayList turnCount=(ArrayList)roomGameCount.get(roomName);
		turnCount.remove(userNum);
		roomGameCount.put(roomName, turnCount);
		System.out.println(roomGameCount+"<====게임 중 나갈 때 게임 턴 카운트");
	}
	
	public void gameAnswer(String roomName) {
		String base = "";
		int  temp =0;
		// 4자리 중복없는 숫자 랜덤선택
		while(base.length()<4) {
			temp = (int)(Math.random()*9)+1;	//1~9까지
			if(!base.contains(temp+""))
			base=base+temp;
		}
		System.out.println("base: "+base);
		
	/*	System.out.println((ArrayList)room.roomGetUsers(roomName));
		ArrayList<String> userList=(ArrayList)room.roomGetUsers(roomName);*/
		ArrayList<Integer> turnCount=new ArrayList<Integer>();

		for(int i=0;i<4;i++) {
			turnCount.add(0);
		}
		System.out.println(turnCount+"<<<<초기화된 turnCount값");
		roomGameCount.put(roomName, turnCount); //방이름-턴 0으로 세팅
		roomAnswer.put(roomName, base);	//방이름-정답 넣기
	
	}
	
	public String userAnswerCheck(String input,String roomName,String id,ArrayList userIds) {
		//한번 답 부를 때 턴 1 오름
		ArrayList<String> userList=userIds;
		int userNum=userList.indexOf(id);
		
		ArrayList turnCount=(ArrayList)roomGameCount.get(roomName);
		turnCount.set(userNum, (Integer)turnCount.get(userNum)+1);	//말할 때마다 턴 1 더함
		
		roomGameCount.put(roomName, turnCount);
		System.out.println(roomGameCount+"=====게임 턴 카운트");
		
		String userAnswer=input;
		int strick=0;
		int ball=0;
		
		for (int i = 0 ; i < 4 ; i++) {
			if(userAnswer.charAt(i)==((String)roomAnswer.get(roomName)).charAt(i))
				strick++;
	        else if(((String)roomAnswer.get(roomName)).indexOf(userAnswer.charAt(i))!=-1)
	            { ball++;  }
		}
		String send="스트라이크:"+strick+" "+"볼:"+ball; 
		System.out.println(send);
		
		if(strick==4) {
			roomGameWinner.put(roomName, id);	//방이름 - 위너 체크
			System.out.println("===승리자이름======="+roomGameWinner.get(roomName));
			
			send="4 스트라이크!! 게임에서 승리하셨습니다";

		}
		
		return send;
	}

	
	
	
}
