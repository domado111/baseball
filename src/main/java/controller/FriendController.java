package controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import dao.FriendDAO;
import model.UserVO;

@Controller
@RequestMapping("/friend")
public class FriendController {
	FriendDAO fdb= FriendDAO.getInstance();
	
	// 친구 목록
	@RequestMapping("/list")
	public String friend(String id, Model model) {
		
		List<UserVO> receive = fdb.receiveRequest(id);
		List<UserVO> send = fdb.sendRequest(id);
		List<UserVO> friendlist = fdb.getFriends(id);

		model.addAttribute("receive", receive);
		model.addAttribute("send", send);
		model.addAttribute("friendlist", friendlist);

		return "friend";
	}

	// 친구 찾기
	@RequestMapping("/search")
	public String search(HttpSession session, @RequestParam("nickname")String friendnick, Model model) {		
		String userid = (String) session.getAttribute("id");

		List<UserVO> users = fdb.friendSearch(userid, friendnick);

		System.out.println(users);
		model.addAttribute("users", users);

		return "search";
	}

	// 친구 추가
	@RequestMapping(value="/addFriend", method=RequestMethod.GET)
	public @ResponseBody String addFriend(HttpSession session, @RequestParam("id") String friendid) {
		
		String id = (String) session.getAttribute("id");
		fdb.addFriend(id, friendid);

		return "success";
	}

	// 친구 거절
	@RequestMapping("/reject")
	public String reject(HttpSession session, String friendid) {
		System.out.println(friendid);
		String id = (String) session.getAttribute("id");
		fdb.rejectRequest(id, friendid);

		return "redirect:/waitingroom";
	}

	// 친구 수락
	@RequestMapping("/confirm")
	public String confirm(HttpSession session, String friendid) {
		
		String id = (String) session.getAttribute("id");
		fdb.confirmFriend(id, friendid);

		return "redirect:/waitingroom";
	}

	// 친구 취소
	@RequestMapping("/cancle")
	public String cancle(HttpSession session, String friendid) {
		String id = (String) session.getAttribute("id");
		System.out.println(friendid);
		fdb.cancleRequest(id, friendid);		
		return "redirect:/waitingroom";
	}

	// 친구 그룹 망함
	@RequestMapping("/group")
	public String group() {

		return null;
	}
}
