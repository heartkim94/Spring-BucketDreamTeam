package com.pknu.project.user.service;

import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.pknu.project.user.common.MailUtil;
import com.pknu.project.user.dao.UserDao;
import com.pknu.project.user.dto.UserDto;

@Service
public class UserServiceImpl implements UserService {
	@Autowired
	MailUtil mailUtil;
	
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

	@Override
	public int joinEmailCheck(String inputEmail) {
		String dbEmailCheck = userDao.emailCheck(inputEmail);
		if(dbEmailCheck != null) { // db에 email이 존재하면
			return 2;
		}else {
			return 1;
		}
	}
	
	@Override
	public String userInsert(UserDto userDto) {
		String certKey = UUID.randomUUID().toString().replaceAll("-", "");
		userDto.setCertKey(certKey);
		userDao.userInsert(userDto);
		mailUtil.sendMail(certKey, userDto.getEmail());
		return null;
	}

	@Override
	public String login(HttpSession session, String id, String pass, Model model) {
		String dbPassCheck=userDao.loginCheck(id);
		int dbCertifyCheck=userDao.certifyCheck(id);
		String view=null;
		int dbCertifyCheckNo=0;
		int passFail=0;
		int Notmember=0;
		
//		if(dbPassCheck != null) { // db에 pass가 있다!
//			if(dbPassCheck.equals(pass)) { // db에 있는 pass랑 입력한 pass랑 같다면
//				session.setAttribute("id", id);
//				model.addAttribute("id",id);
//				view="user/loginOk";
//			}else { // 아이디는 맞고 패스워드 틀렸을때
//				view="user/passFail";
//			}
//		}else {
//			view="user/main";
//		}
//		return view;
		
		if (dbPassCheck != null && dbCertifyCheck == 1) {
			if (dbPassCheck.equals(pass)) {//로그인성공
				session.setAttribute("id", id);
				model.addAttribute("id", id);
				view = "user/loginOk";
			} else {//비밀번호 실패
				model.addAttribute("passFail",passFail);
				view = "user/loginFail";
			}
		} else if(dbPassCheck!=null&&dbCertifyCheck==0) {//이메일인증 않함	
			model.addAttribute("dbCertify",dbCertifyCheckNo);
			view="user/main";
		}else if(dbPassCheck==null&&dbCertifyCheck==2) {//회원가입
			model.addAttribute("Notmember",Notmember);
			view = "user/loginFail";
		}
		System.out.println(session.getAttribute("id"));
		return view;
		
		
	}

	@Override
	public String mypage(HttpSession session, UserDto userDto, Model model) {
		userDto.setId((String)session.getAttribute("id"));
		model.addAttribute("id",session.getAttribute("id"));
		userDto.setEmail((String)session.getAttribute("email"));
		model.addAttribute("email",session.getAttribute("email"));
		return null;
	}

	@Override
	public String userUpdate(HttpSession session, UserDto userDto) {
		userDto.setId((String)session.getAttribute("id"));
		userDto.setEmail((String)session.getAttribute("Email"));
		userDao.userUpdate(userDto);
		return null;
	}

	////////////
	@Override
	public int checkJoin(String certKey, Model model) {
		int checkjoin;
		UserDto User=userDao.checkJoin(certKey);
		if(User.getCertify() == UserDto.SUCCESS) {
			// 이미 링크 클릭(가입 절차 모두완료된 상태)	
			checkjoin=1;
			model.addAttribute("certKey",checkjoin);
			return checkjoin;
			
		} else if (User.getCertify() == UserDto.FAIL) {
			// dto를 업데이트 해준다. (certify => 1) User의 ID값 이용
			checkjoin=2;
			userDao.checkJoinUpdate(certKey);
			model.addAttribute("certKey",checkjoin);
			return checkjoin;
		} else {
			// certKey가 존재 하지 않는 키라는 뜻!(회원가입 신청 한적이없음)
			checkjoin=3;
			model.addAttribute("certKey",checkjoin);
			return checkjoin;
		}
	}




	
	
	
	
}
