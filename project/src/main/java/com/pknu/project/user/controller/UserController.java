package com.pknu.project.user.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pknu.project.user.dto.UserDto;
import com.pknu.project.user.service.UserService;

@Controller
public class UserController {
	@Autowired
	UserService userService;
	
	UserDto userDto;
	
	@RequestMapping(value="userProvisionForm.user")
	public String userProvisionForm() { //회원약관폼
		return "user/userProvisionForm";
	}
	
	@RequestMapping(value="userJoinForm.user")
	public String userJoinForm() { //회원가입폼
		return "user/userJoinForm";
	}
	
	@RequestMapping(value="joinIdCheck.user")
	@ResponseBody
	public int joinIdCheck(@RequestParam("inputId") String inputId) { //회원가입 아이디 중복체크
//		System.out.println(userService.joinIdCheck(inputId));
		return userService.joinIdCheck(inputId);
		
	}
	
	@RequestMapping(value="joinEmailCheck.user")
	@ResponseBody
	public int joinEmailCheck(@RequestParam("inputEmail") String inputEmail) { //회원가입 이메일 중복체크
		return userService.joinEmailCheck(inputEmail); 
	}
	
	
	@RequestMapping(value="/userInsert.user")
	public String memInsert(UserDto userDto) {
		userService.userInsert(userDto);
		return "user/main";
	}
	
	@RequestMapping(value="/login.user", method=RequestMethod.POST)
	public String login(HttpSession session, String id, String pass, Model model) {
		return userService.login(session,id,pass,model);
	}
	
	@RequestMapping(value="/logout.user")
	public String logout(HttpSession session) {
		session.invalidate();
		return "home";
	}
	
	@RequestMapping(value="mypage.user")
	public String mypageForm(HttpSession session, UserDto userDto, Model model) {
		userService.mypage(session,userDto,model);
		return "user/mypage";
	}
	
	@RequestMapping(value="userUpdate.user")
	public String userUpdate(HttpSession session, UserDto userDto) {
		userService.userUpdate(session, userDto);
		return "user/main";
	}
	
	@RequestMapping(value="/checkJoin.user")
	public String checkJoin(@RequestParam("certKey") String certKey,Model model) {
		userService.checkJoin(certKey,model);
		return "user/emailAlertPage";
	}
	
	
}
