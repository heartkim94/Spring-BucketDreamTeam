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
	
	@RequestMapping(value="userProvisionForm.do")
	public String userProvisionForm() { //회원약관폼
		return "user/userProvisionForm";
	}
	
	@RequestMapping(value="userJoinForm.do")
	public String userJoinForm() { //회원가입폼
		return "user/userJoinForm";
	}
	
	@RequestMapping(value="joinIdCheck.do")
	@ResponseBody
	public int joinIdCheck(@RequestParam("inputId") String inputId) { //회원가입 아이디 중복체크
//		System.out.println(userService.joinIdCheck(inputId));
		return userService.joinIdCheck(inputId);
		
	}
	
	@RequestMapping(value="joinEmailCheck.do")
	@ResponseBody
	public int joinEmailCheck(@RequestParam("inputEmail") String inputEmail) { //회원가입 이메일 중복체크
		return userService.joinEmailCheck(inputEmail); 
	}
	
	@RequestMapping(value="findIdEmailCheck.do")
	@ResponseBody
	public int findIdEmailCheck(@RequestParam("inputId") String inputId, @RequestParam("inputEmail") String inputEmail) { //비밀번호 찾기에서 아이디와 이메일비교
		return userService.findIdEmailCheck(inputId, inputEmail);
	}
	
	@RequestMapping(value="delPassCheck.do")
	@ResponseBody
	public int delPassCheck(@RequestParam("inputPass") String inputPass, HttpSession session) {
		return userService.delPassCheck(session, inputPass);
	}
	
	@RequestMapping(value="/userInsert.do")
	public String memInsert(UserDto userDto) {
		userService.userInsert(userDto);
		return "user/main";
	}
	
	@RequestMapping(value="/login.do", method=RequestMethod.POST)
	public String login(HttpSession session, String id, String pass, Model model) {
		return userService.login(session,id,pass,model);
	}
	
	@RequestMapping(value="/logout.do")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:home.do";
	}
	
	@RequestMapping(value="mypage.do")
	public String mypageForm(HttpSession session, Model model) {
		userService.mypage(session,model);
		return "user/mypage";
	}
	
	@RequestMapping(value="userUpdate.do")
	public String userUpdate(HttpSession session, UserDto userDto) {
		userService.userUpdate(session, userDto);
		return "reirect:home.do";
	}
	
	@RequestMapping(value="/checkJoin.do")
	public String checkJoin(@RequestParam("certKey") String certKey,Model model) {
		userService.checkJoin(certKey,model);
		return "user/emailAlertPage";
	}
	
	@RequestMapping(value="userIdPassFind.do")
	public String userIdPassFind() { //아이디 비밀번호 찾기 폼
		return "user/userIdPassFind";
	}
	
	@RequestMapping(value="userIdFind.do")
	public String userIdFind(UserDto userDto,@RequestParam("email") String email, Model model) {
		userDto.setEmail(email);
		userService.userIdFind(userDto, model);
		return "user/userIdShow";
	}
	
	@RequestMapping(value="userPassFind.do")
	public String userPassFind(UserDto userDto, String id, String email, Model model) {
		userDto.setId(id);
		userDto.setEmail(email);
		userService.userPassFind(userDto);
		return "user/userIdPassFind";
	}

	@RequestMapping(value="myInfoDelForm.do")
	public String myInfoDelForm() { //회원탈퇴폼
		return "user/myInfoDelForm";
	}
						
	@RequestMapping(value="myInfoDel.do")
	public String myInfoDel(HttpSession session, String pass) { // 회원탈퇴
		System.out.println(session.getAttribute("id")); 
		System.out.println(pass);
		userService.myInfoDel(session, pass);
		session.invalidate();
		return "redirect:/project/home.do";
	}
	
}
