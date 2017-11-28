package com.pknu.project.user.service;

import javax.servlet.http.HttpSession;

import org.springframework.ui.Model;

import com.pknu.project.user.dto.UserDto;

public interface UserService {
	public int joinIdCheck(String inputId);
	public int joinEmailCheck(String inputEmail);
	public String userInsert(UserDto userDto);
	public String login(HttpSession session, String id, String pass, Model model);
	public String mypage(HttpSession session, Model model);
	public String userUpdate(HttpSession session, UserDto userDto);
	
	public int checkJoin(String certKey,Model model);
	public String userIdFind(UserDto userDto, Model model);
	public String userPassFind(UserDto userDto);
}
