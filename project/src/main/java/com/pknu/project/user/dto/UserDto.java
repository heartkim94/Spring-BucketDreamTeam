package com.pknu.project.user.dto;

public class UserDto {
	public static final int SUCCESS = 1;
	public static final int FAIL = 0;
	
	private int userNum;
	private String id;
	private String pass;
	private String name;
	private String nickName;
	private String email;
	private String phoneNumber;
	private String gender;
	private String certKey;
	private int certify;
	private boolean admin;
	
	public int getUserNum() {
		return userNum;
	}
	public void setUserNum(int userNum) {
		this.userNum = userNum;
	}
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
	public String getCertKey() {
		return certKey;
	}
	public void setCertKey(String certKey) {
		this.certKey = certKey;
	}
	public int getCertify() {
		return certify;
	}
	public void setCertify(int certify) {
		this.certify = certify;
	}
	public static int getSuccess() {
		return SUCCESS;
	}
	public static int getFail() {
		return FAIL;
	}
	public boolean getIsAdmin() {
		return admin;
	}
	public void setIsAdmin(boolean admin) {
		this.admin = admin;
	}
	
	@Override
	public String toString() {
		return "UserDto [id=" + id + ", pass=" + pass + ", name=" + name + ", nickName=" + nickName + ", email=" + email
				+ ", phoneNumber=" + phoneNumber + ", gender=" + gender + ", certKey="
				+ certKey + ", certify=" + certify + "]";
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
email varchar(100) not null,
phoneNumber varchar(100),
gender varchar(10) NOT NULL,
certkey varchar(100) not null,
certify int default 0 not null
);


CREATE TABLE user(
	id varchar(50) PRIMARY KEY,
	pass varchar(50) NOT NULL,
	name varchar(100),
	nickName varchar(100),
	email varchar(100) not null,
	phoneNumber char(13),
	gender enum('m', 'f') not null,
    isAdmin boolean not null default false,
    certkey varchar(100) not null,
	certify int default 0 not null
	);
	
insert into user values('test', '1234', 'Hong', 'KKong', 'kkong@email','010-1111-1111', 'm', false, 'test certkey', 1);
insert into user values('admin', '1234', 'Hong', 'KKong', 'kkong@email','010-1111-1111', 'm', true, 'test certkey', 1);
*/