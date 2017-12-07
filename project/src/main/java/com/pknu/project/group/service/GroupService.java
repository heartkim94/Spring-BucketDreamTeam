package com.pknu.project.group.service;

import org.springframework.ui.Model;

import com.pknu.project.group.dto.GroupDto;

public interface GroupService {
	public void getMyGroup(String id, Model model);
	public GroupDto getGroup(int groupNum, Model model);
	public void getCategory(Model model);
	public void newGroup(GroupDto group);
	public void deleteGroup(int groupNum);
	
	/* do */
	public void getDoList(int groupNum, Model model);
}
