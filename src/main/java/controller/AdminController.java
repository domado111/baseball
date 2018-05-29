package controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import dao.UserDAO;
import model.UserVO;

@Controller
@RequestMapping("/admin")
public class AdminController {
	UserDAO db = UserDAO.getInstance();

	// 회원 관리 목록
	@RequestMapping("/manager")
	public String manager(String nickname, Model model) {
		List<UserVO> users = db.getUsers();
		
		int count=db.usersCount();
		
		model.addAttribute("users",users);
		model.addAttribute("count",count);
		
		return "admin/manager";
	}
	
	// 회원 정보 변경
	@RequestMapping("/update")
	public String update(UserVO user, Model model) {		
		int result = db.updateInfo(user);
		
		return "redirect:/admin/manager";
	}
	
	// 회원 삭제
	@RequestMapping("/delete")
	public String delete(UserVO user) {
		int result = db.deleteUser(user);
		
		return "redirect:/admin/manager";
	}
	
	// 데이터 통계
	@RequestMapping("/stats")
	public String stats(HttpServletRequest request, Model model, HttpSession session) throws Throwable {
		request.setCharacterEncoding("utf-8");

		String path=session.getServletContext().getRealPath("/");
		path=path.replace("\\", "/");
		System.out.println(path);
		
		Date date=new Date();
		String dateInput=request.getParameter("date");
		
		if(dateInput==null) {
			SimpleDateFormat simpleDate=new SimpleDateFormat("yyyy-MM-dd",Locale.KOREA);
			dateInput=simpleDate.format(date);
			System.out.println(dateInput+"~~~dateInput");
		}
		
		Map map=RserveService.getInstance().rData(path,dateInput);
		if(map.get("countList")!=null) {
			System.out.println("countList !=null일 때");
			model.addAttribute("countList",(ArrayList)map.get("countList"));
			model.addAttribute("dateList",(ArrayList)map.get("dateList"));
		}else {
			System.out.println("countList ==null 탐");
			model.addAttribute("dateList","noData");
		}
		
		System.out.println("여기까지옴");
		return "admin/stats";
	}
	
	// 로그아웃
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		String id = (String) session.getAttribute("id");
		db.offline(id);
		session.invalidate();

		return "redirect:../index";
	}
}
