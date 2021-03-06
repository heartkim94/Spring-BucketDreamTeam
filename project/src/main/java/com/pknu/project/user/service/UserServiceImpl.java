package com.pknu.project.user.service;

import java.util.HashMap;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.pknu.project.user.common.MailUtil;
import com.pknu.project.user.common.encryptSHA;
import com.pknu.project.user.dao.UserDao;
import com.pknu.project.user.dto.UserDto;

@Service
public class UserServiceImpl implements UserService {
	@Autowired
	MailUtil mailUtil;
	
	@Autowired
	UserDao userDao;
	
	@Autowired
	encryptSHA sha;
	
	HashMap<String, String> paramMap;

	@Override
	public int joinIdCheck(String inputId) {
		String dbIdCheck = userDao.loginCheck(inputId);
        boolean langCheck = false;
        for(int i=0; i<inputId.length(); i++) {
        	if(
            (inputId.charAt(i)<48) ||
            (inputId.charAt(i)>57 && inputId.charAt(i)<65) ||
            (inputId.charAt(i)>90 && inputId.charAt(i)<97) ||
            (inputId.charAt(i)>122)) {
        		langCheck=true;
                break;
            }
        }
        
		if(dbIdCheck != null) {	// db에 id가 존재하면
			return 1;
		}else if(langCheck) {	// 영어나 숫자가 아니면
			return 2;
		}else {
			return 3;
		}
	}

	@Override
	public int joinEmailCheck(String inputEmail) {
		System.out.println("***id***");
		String dbEmailCheck = userDao.emailCheck(inputEmail);
		System.out.println("이메일 : " + dbEmailCheck);
		if(dbEmailCheck != null) { // db에 email이 존재하면
			return 2;
		}else {
			return 1;
		}
	}
	
	@Override
	public int findIdEmailCheck(String inputId, String inputEmail) {
		System.out.println("***id+email***");
		paramMap = new HashMap<>();
		paramMap.put("id", inputId);
		paramMap.put("email", inputEmail);
		System.out.println("아이디 : " + inputId);
		System.out.println("이메일 : " + inputEmail);
		String dbIdPassCheck = userDao.findIdEmailCheck(paramMap);
//		System.out.println(dbIdPassCheck+"아이디 이메일");
		if(dbIdPassCheck != null) {  // db에 id가 존재하면
			return 2;
		}else {
			return 1;
		}
	}
	
	@Override
	public int delPassCheck(HttpSession session, String inputPass) {
		String id = (String) session.getAttribute("id");
		String dbPass = userDao.passCheck(id);
		if(dbPass.equals(sha.encryptSHA256(inputPass))) {
			return 2; // db에 있는 pass와 같으면
		}else {
			return 1;
		}
	}
	
	@Override
	public String userInsert(UserDto userDto) {
		String certKey = UUID.randomUUID().toString().replaceAll("-", "");
		userDto.setCertKey(certKey);
		userDto.setPass(sha.encryptSHA256(userDto.getPass()));
		userDao.userInsert(userDto);
		mailUtil.sendMail(certKey, userDto.getEmail());
		return null;
	}

	@Override
	public String login(HttpSession session, String id, String pass, Model model) {
//		String dbPassCheck=userDao.loginCheck(id);
//		int dbCertifyCheck=userDao.certifyCheck(id);
		UserDto user=userDao.checkLogin(id);
//		String dbPassCheck=user.getPass();
//		boolean dbAdminCheck=user.getIsAdmin();
//		int dbCertifyCheck=user.getCertify();
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
		
//		if (dbPassCheck != null && dbCertifyCheck==1) {
//			if (dbPassCheck.equals(pass)) {//로그인성공
//				session.setAttribute("id", id);
//				session.setAttribute("isAdmin", dbAdminCheck);
//				model.addAttribute("id", id);
//				view = "group/groupMain";
//			} else {//비밀번호 실패
//				model.addAttribute("passFail",passFail);
//				view = "user/loginFail";
//			}
//		} else if(dbPassCheck!=null&&dbCertifyCheck==0) {//이메일인증 않함	
//			model.addAttribute("dbCertify",dbCertifyCheckNo);
//			view="home";
//		}else if(dbPassCheck==null && user.getId()!=id) {//회원가입
//			model.addAttribute("Notmember",Notmember);
//			view = "user/loginFail";
//		}
		if (user!=null && user.getCertify()==1) {
			if (user.getPass().equals(sha.encryptSHA256(pass))) {//로그인성공
				session.setAttribute("id", id);
				session.setAttribute("isAdmin", user.getIsAdmin());
				view = "redirect:/group/main";
			} else {//비밀번호 실패
				model.addAttribute("passFail",passFail);
				view = "user/loginFail";
			}
		} else if(user!=null&&user.getCertify()==0) {//이메일인증 않함	
			model.addAttribute("dbCertify", dbCertifyCheckNo);
			view="common/home";
		}else if(user==null) {//회원가입
			model.addAttribute("Notmember",Notmember);
			view = "user/loginFail";
			
		}
		System.out.println(session.getAttribute("id"));
		return view;
		
		
	}

	@Override
	public String mypage(HttpSession session, Model model) {
		UserDto user = userDao.getUser((String)session.getAttribute("id"));
		model.addAttribute("user", user);
		return null;
	}

	@Override
	public String userUpdate(HttpSession session, UserDto userDto) {
		String pass=userDto.getPass();
		
		userDto.setId((String)session.getAttribute("id"));
		userDto.setEmail((String)session.getAttribute("Email"));
		userDto.setPass(sha.encryptSHA256(pass));
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

	@Override
	public String userIdFind(UserDto userDto, Model model) {
		String myId = userDao.userIdFind(userDto);
		model.addAttribute("myId",myId);
		return null;
	}

	@Override
	public String userPassFind(UserDto userDto) {
		String pass="";
		char pwCollection[] = new char[] { 
                '1','2','3','4','5','6','7','8','9','0', 
                'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z', 
                'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z', 
                '!','@','#','$','%','^','&','*','(',')'};//배열에 선언 
		
		for(int i=0; i<10; i++) {
			 int selectRandomPw = (int)(Math.random()*(pwCollection.length));//Math.rondom()은 0.0이상 1.0미만의 난수를 생성해 준다. 
			 pass += pwCollection[selectRandomPw]; 
		}
//		userDto.setPass(pass);
		userDto.setPass(sha.encryptSHA256(pass));
		userDao.userPassFind(userDto);
		mailUtil.sendPass(pass,userDto.getEmail());
		return null;
	}

	@Override
	public void myInfoDel(HttpSession session, String pass) {
		String passWord=sha.encryptSHA256(pass);
		
		String id = (String)session.getAttribute("id");
		System.out.println(id); 
		System.out.println(passWord);
		paramMap = new HashMap<>();
		paramMap.put("id", id);
		paramMap.put("pass", passWord);
		userDao.myInfoDel(paramMap);
	}



}
