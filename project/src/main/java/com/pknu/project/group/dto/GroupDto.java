package com.pknu.project.group.dto;

import org.springframework.stereotype.Component;

@Component
public class GroupDto {
	private int groupNum;
	private String groupName;
	private int groupOwner;
	private int catNum;
	private int memberCount;
	
	public int getGroupNum() {
		return groupNum;
	}
	public void setGroupNum(int groupNum) {
		this.groupNum = groupNum;
	}
	public String getGroupName() {
		return groupName;
	}
	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}
	public int getGroupOwner() {
		return groupOwner;
	}
	public void setGroupOwner(int groupOwner) {
		this.groupOwner = groupOwner;
	}
	public int getCatNum() {
		return catNum;
	}
	public void setCatNum(int catNum) {
		this.catNum = catNum;
	}
	public int getMemberCount() {
		return memberCount;
	}
	public void setMemberCount(int memberCount) {
		this.memberCount = memberCount;
	}
}
