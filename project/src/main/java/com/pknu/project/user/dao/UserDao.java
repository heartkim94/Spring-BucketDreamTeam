package com.pknu.project.user.dao;

import com.pknu.project.user.dto.UserDto;

public interface UserDao {
	public String loginCheck(String id);
//	public String emailCheck(String email);
	public void userInsert(UserDto userDto);
}
