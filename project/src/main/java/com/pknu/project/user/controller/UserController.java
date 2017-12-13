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
	
	@RequestMapping(value="userProvisionForm")
	public String userProvisionForm() { //회원약관폼
		return "user/userProvisionForm";
	}
	
	@RequestMapping(value="userJoinForm")
	public String userJoinForm() { //회원가입폼
		return "user/userJoinForm";
	}
	
	@RequestMapping(value="joinIdCheck")
	@ResponseBody
	public int joinIdCheck(@RequestParam("inputId") String inputId) { //회원가입 아이디 중복체크
//		System.out.println(userService.joinIdCheck(inputId));
		return userService.joinIdCheck(inputId);
	}
	
	@RequestMapping(value="joinEmailCheck")
	@ResponseBody
	public int joinEmailCheck(@RequestParam("inputEmail") String inputEmail) { //회원가입 이메일 중복체크
		return userService.joinEmailCheck(inputEmail); 
	}
	
	@RequestMapping(value="findIdEmailCheck")
	@ResponseBody
	public int findIdEmailCheck(@RequestParam("inputId") String inputId, @RequestParam("inputEmail") String inputEmail) { //비밀번호 찾기에서 아이디와 이메일비교
		return userService.findIdEmailCheck(inputId, inputEmail);
	}
	
	@RequestMapping(value="delPassCheck")
	@ResponseBody
	public int delPassCheck(@RequestParam("inputPass") String inputPass, HttpSession session) {
		return userService.delPassCheck(session, inputPass);
	}
	
	@RequestMapping(value="/userInsert")
	public String memInsert(UserDto userDto) {
		userService.userInsert(userDto);
		return "redirect:/home";
	}
	
	@RequestMapping(value="/login", method=RequestMethod.POST)
	public String login(HttpSession session, String id, String pass, Model model) {
		return userService.login(session,id,pass,model);
	}
	
	@RequestMapping(value="/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:home";
	}
	
	@RequestMapping(value="mypage")
	public String mypageForm(HttpSession session, Model model) {
		userService.mypage(session,model);
		return "user/mypage";
	}
	
	@RequestMapping(value="userUpdate")
	public String userUpdate(HttpSession session, UserDto userDto) {
		userService.userUpdate(session, userDto);
		return "redirect:/home";
	}
	
	@RequestMapping(value="/checkJoin")
	public String checkJoin(@RequestParam("certKey") String certKey,Model model) {
		userService.checkJoin(certKey,model);
		return "user/emailAlertPage";
	}
	
	@RequestMapping(value="userIdPassFind")
	public String userIdPassFind() { //아이디 비밀번호 찾기 폼
		return "user/userIdPassFind";
	}
	
	@RequestMapping(value="userIdFind")
	public String userIdFind(UserDto userDto,@RequestParam("email") String email, Model model) {
		userDto.setEmail(email);
		userService.userIdFind(userDto, model);
		return "user/userIdShow";
	}
	
	@RequestMapping(value="userPassFind")
	public String userPassFind(UserDto userDto, String id, String email, Model model) {
		userDto.setId(id);
		userDto.setEmail(email);
		userService.userPassFind(userDto);
		return "user/userIdPassFind";
	}

	@RequestMapping(value="myInfoDelForm")
	public String myInfoDelForm() { //회원탈퇴폼
		return "user/myInfoDelForm";
	}
						
	@RequestMapping(value="myInfoDel")
	public String myInfoDel(HttpSession session, String pass) { // 회원탈퇴
		System.out.println(pass);
		userService.myInfoDel(session, pass);
		session.invalidate();
		return "redirect:/home";
	}
	
}
