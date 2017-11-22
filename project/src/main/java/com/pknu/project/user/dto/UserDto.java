package com.pknu.project.user.dto;

public class UserDto {
	private String id;
	private String pass;
	private String name;
	private String nickName;
	private String email;
	private String phoneNumber;
	private String gender;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPhoneNumber() {
		return phoneNumber;
	}
	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	@Override
	public String toString() {
		return "UserDto [id=" + id + ", pass=" + pass + ", name=" + name + ", nickName=" + nickName + ", email=" + email
				+ ", phoneNumber=" + phoneNumber + ", gender=" + gender + "]";
	}
	
	
}

/*

create database project;

use project;

CREATE TABLE user(
id varchar(50) PRIMARY KEY,
pass varchar(50) NOT NULL,
name varchar(100),
nickName varchar(100),
email varchar(100),
phoneNumber varchar(100),
gender varchar(10) NOT NULL
);

*/