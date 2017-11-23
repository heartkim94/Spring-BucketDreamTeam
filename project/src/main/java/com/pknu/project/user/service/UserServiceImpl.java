package com.pknu.project.user.service;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.pknu.project.user.dao.UserDao;
import com.pknu.project.user.dto.UserDto;

@Service
public class UserServiceImpl implements UserService {
	@Autowired
	UserDao userDao;

	@Override
	public int joinIdCheck(String inputId) {
		String dbIdCheck = userDao.loginCheck(inputId);
		if(dbIdCheck != null) {  // db에 id가 존재하면
			return 2;
		}else {
			return 1;
		}
	}

//	@Override
//	public int joinEmailCheck(String inputEmail) {
//		String dbEmailCheck = userDao.emailCheck(inputEmail);
//		if(dbEmailCheck != null) { // db에 email이 존재하면
//			return 2;
//		}else {
//			return 1;
//		}
//	}
	
	@Override
	public String userInsert(UserDto userDto) {
		userDao.userInsert(userDto);
		return null;
	}

	@Override
	public String login(HttpSession session, String id, String pass, Model model) {
		String dbPassCheck = userDao.loginCheck(id);
		String view = null;
		if(dbPassCheck != null) { // db에 pass가 있다!
			if(dbPassCheck.equals(pass)) { // db에 있는 pass랑 입력한 pass랑 같다면
				session.setAttribute("id", id);
				model.addAttribute("id",id);
				view="loginOk";
			}else { // 아이디는 맞고 패스워드 틀렸을때
				view="passFail";
			}
		}else {
			view="main";
		}
		return view;
	}


	
	
	
	
}
