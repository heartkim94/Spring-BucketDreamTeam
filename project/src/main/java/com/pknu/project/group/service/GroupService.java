package com.pknu.project.group.service;

import java.util.List;

import org.springframework.ui.Model;

import com.pknu.project.group.dto.GroupDto;
import com.pknu.project.group.dto.TodoDto;

public interface GroupService {
	public void getMyGroup(String id, Model model);
	public GroupDto getGroup(int groupNum, Model model);
	public void getCategory(Model model);
	public void newGroup(GroupDto group);
	public void deleteGroup(int groupNum);
	
	/* todo */
	public void getTodoList(int groupNum, Model model);
	public String updateTodoList(int groupNum, List<TodoDto> todoList);
}
