package com.pknu.project.user.dao;

import java.util.HashMap;

import com.pknu.project.user.dto.UserDto;

public interface UserDao {
	public String loginCheck(String id);
	public UserDto checkLogin(String id);
	public String emailCheck(String email);
	public String findIdEmailCheck(HashMap<String, String> paramMap);
	public String passCheck(String pass);
	public void userInsert(UserDto userDto);
	public void userUpdate(UserDto userDto);
	
	public UserDto checkJoin(String certKey);
	public void checkJoinUpdate(String certKey);
	public int certifyCheck(String id);
	public UserDto getUser(String id);
	public String userIdFind(UserDto userDto);
	public void userPassFind(UserDto userDto);
	
	public void myInfoDel(HashMap<String, String> paramMap);
}
