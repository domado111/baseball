package controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import dao.FriendDAO;
import dao.UserDAO;
import model.UserVO;

@Controller
public class WaitingRoomController {

	UserDAO udb = UserDAO.getInstance();
	FriendDAO fdb = FriendDAO.getInstance();

	// 대기실
	@RequestMapping("/waitingroom")
	public String waitingRoom(HttpSession session, Model model) {
		String id = (String) session.getAttribute("id");
		String nickname = (String) session.getAttribute("nickname");
		int friendcount = fdb.friendCount(id);
		System.out.println(id + "<<<아이디!!!! waitingroomController");
		UserVO user = udb.getUser(id);
		List<UserVO> rank = udb.getRank();
		udb.online(id);
		System.out.println(id + "==========" + nickname);

		model.addAttribute("rank", rank);
		model.addAttribute("user", user);
		model.addAttribute("id", id);
		model.addAttribute("nickname", nickname);
		model.addAttribute("friendcount", friendcount);

		return "waitingRoom";
	}
}
