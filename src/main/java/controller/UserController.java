package controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import dao.UserDAO;
import model.UserVO;

@Controller
@RequestMapping("/user")
public class UserController {
	UserDAO db = UserDAO.getInstance();

	// 로그아웃
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		String id = (String) session.getAttribute("id");
		db.offline(id);
		session.invalidate();

		return "redirect:/index";
	}

	// 로그인
	@RequestMapping(value="/login", method=RequestMethod.GET)	
	public @ResponseBody String login(@RequestParam("id") String id, @RequestParam("pwd") String password, HttpSession session) {
		int check = db.loginCheck(id, password);	

		if (check == 1) {
			UserVO user = db.getUser(id);
			session.setAttribute("id", id);
			session.setAttribute("usernum", user.getUser_num());
			session.setAttribute("nickname", user.getNickname());
			db.online(id);
			
			if(user.getGrade()==0) {
				return "adminlogin";
			}

			return "loginsuccess";
		} else {
			return "loginfail";
		}
	}
	
	// 회원가입
	@RequestMapping("/signup")
	public String signup(UserVO user) {
		db.insertUser(user);
		
		return "redirect:/index";
	}	
	
	// ajax 회원가입 아이디 중복체크
	@RequestMapping(value="checkid",method=RequestMethod.GET)
	public @ResponseBody int checkId(@RequestParam("id") String id) {
		System.out.println(id);
		return db.checkId(id);
	}
	
	// ajax 회원가입 닉네임 중복체크
	@RequestMapping(value="checknick",method=RequestMethod.GET)
	public @ResponseBody int checkNick(@RequestParam("nickname") String nickname) {
		System.out.println(nickname);
		return db.checkNick(nickname);
	}
	
	// ajax 회원가입 이메일 중복체크
	@RequestMapping(value="checkemail",method=RequestMethod.GET)
	public @ResponseBody int checkEmail(@RequestParam("email") String email) {
		System.out.println(email);
		return db.checkEmail(email);
	}
	
	// ajax 닉네임 이메일 존재 여부 확인
	@RequestMapping(value="findcheck",method=RequestMethod.GET)
	public @ResponseBody int findcheck(@RequestParam("nickname") String nickname, @RequestParam("email") String email) {
		System.out.println(nickname);
		System.out.println(email);
		
		return db.findCheck(nickname,email);
	}
	
	// ajax 아이디 찾기
	@RequestMapping(value="findid",method=RequestMethod.GET)
	public @ResponseBody String findid(@RequestParam("email") String email) {
		
		System.out.println(email);
		
		String id=db.findId(email);
		System.out.println("아이디 길이 ======================"+id.length());
		
		if(id.length() > 3) {
			id=id.substring(0, 3);
		} else if(id.length() > 9) {
			id=id.substring(0, 5);
		}
		
		return id+"******";
	}
	
	// ajax 비밀번호 찾기
	@RequestMapping(value="findpwd",method=RequestMethod.GET)
	public @ResponseBody int findpwd(@RequestParam("id") String id, @RequestParam("email") String email) {
		System.out.println(id);
		System.out.println(email);
		
		return db.findPwd(id,email);
	}
	
	// ajax 비밀번호 변경
	@RequestMapping(value="updatepwd",method=RequestMethod.GET)
	public @ResponseBody String updatepwd(@RequestParam("id") String id, @RequestParam("pwd") String password) {
		System.out.println(id);
		System.out.println(password);
		db.updatePwd(id,password);
		
		return "success";
	}
	
	// 개인 정보
	@RequestMapping("info")
	public String info(String id, Model model) {
		UserVO user=db.getUser(id);
		model.addAttribute("user",user);
		
		return "userinfo";
	}
	
	// 개인정보 변경
	@RequestMapping("/update")
	public String update(UserVO user, HttpSession session) {
		String prenick = (String)session.getAttribute("nickname");
		System.out.println("123213132dasdsfasdfsadfdas"+user);
		System.out.println("포인트============="+user.getPoint());
		System.out.println("비밀번호 변경 후 ========================"+user.getPassword());
		
		if(!prenick.equals(user.getNickname())) {
			user.setPoint(user.getPoint()-10000);
			session.setAttribute("nickname", user.getNickname());
		}
		
		db.updateInfo(user);
		
		if(user.getPassword()!=null && user.getPassword()!="") {
			System.out.println("11111111111111111111===============");
			db.updatePwd(user.getId(), user.getPassword());
		}			
		
		return "redirect:/waitingroom";
	}
	
	// ajax 닉네임 변경시 존재 여부 확인
	@RequestMapping(value="changenickCheck",method=RequestMethod.GET)
	public @ResponseBody String changenickCheck(@RequestParam("nickname") String nickname, HttpSession session) {
		String prenick=(String)session.getAttribute("nickname");
		System.out.println("변경 전==========="+prenick);
		System.out.println("변경 후==========="+nickname);
		
		if (prenick.equals(nickname)){
			return "notchange";
		}
		
		return "change";
	}
	
	// 회원 탈퇴
	@RequestMapping("/delete")
	public String delete(UserVO user) {
		int result = db.deleteUser(user);
		
		return "redirect:/index";
	}
}
