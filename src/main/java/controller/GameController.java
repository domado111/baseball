package controller;

import java.util.ArrayList;
import java.util.Arrays;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import dao.GameDAO;
import dao.UserDAO;
import game.BaseBall;
import model.GameVO;
import room.Room;

@Controller
@RequestMapping("/game")
public class GameController {
	Room room = Room.getInstance(); // 방 객체 가져옴
	BaseBall baseball = BaseBall.getInstance();
	UserDAO db= UserDAO.getInstance();

	GameDAO gameDao=GameDAO.getInstance();
	
	@RequestMapping("/play")
	public String play(HttpServletRequest request, Model model, HttpSession session) throws Throwable {
		if(session.getAttribute("id")==null) {
			return "redirect:/index";
		}		
		// 유저 리스트 받아옴
		ArrayList<String> users;
		
		String id = (String) session.getAttribute("id");
		db.ongame(id);
		
		System.out.println(id + "< id");

		String[] getUsers = request.getParameterValues("users");

		if (getUsers != null) {
			users = new ArrayList<String>(Arrays.asList(getUsers));
		} else {
			users = new ArrayList<String>(Arrays.asList(id));
		}

		System.out.println(users + "< users");

		// 방추출
		String userRoom = room.roomMatch(users);
		
		model.addAttribute("name", id);
		model.addAttribute("group", userRoom);

		return "gameView";
	}

	@RequestMapping("/out")
	public String out(Model model) throws Throwable {

		return "out";
	}

	@RequestMapping("/ready")
	@ResponseBody
	public String ready(HttpServletRequest request, Model model) throws Throwable {

		String ready = request.getParameter("ready");
		String roomName = request.getParameter("roomName");
		String id = request.getParameter("id");

		System.out.println(ready + "====ready====" + roomName + "===roomName");

		boolean chk = false;
		if (ready.equals("true")) {
			chk = room.roomGameOn(roomName, id);
		}
		System.out.println(chk);
		if (chk) {
			baseball.gameAnswer(roomName); // 게임 정답 추출
			//db에 기본 값 넣기
			GameVO game=new GameVO();
			game.setRoomname(roomName);
			ArrayList userList=(ArrayList)room.roomGetUsers(roomName);
			game.setUser1((String)userList.get(0));
			game.setUser2((String)userList.get(1));
			game.setUser3((String)userList.get(2));
			game.setUser4((String)userList.get(3));
			System.out.println(game+"<<<게임 시작 시 gameVO");
			gameDao.insertGame(game);
		
			return "ok";

		}
		else
			return "no";
		
	}
	@RequestMapping("/gameresult")
	public String gameresult(HttpServletRequest request, Model model) throws Throwable {
		
		String roomName=request.getParameter("roomName");
		GameVO game=gameDao.getGame(roomName);
		System.out.println(game.getRoomname()+"<<<<<gameresult 내 game.getRoomname");
		ArrayList<String> loseList=new ArrayList<String>();
		loseList.add(game.getUser1());
		loseList.add(game.getUser2());
		loseList.add(game.getUser3());
		loseList.add(game.getUser4());

		loseList.remove(game.getWinner());
		
		model.addAttribute("loseList", loseList);
		model.addAttribute("winner", game.getWinner());
		model.addAttribute("point",game.getPoint());
		model.addAttribute("winnerTurn", game.getWinner_turn());
		
		return "gameResult";
	}

}
