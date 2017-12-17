package com.pknu.project.group.service;

import java.util.List;

import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

import com.pknu.project.group.dto.GroupDto;
import com.pknu.project.group.dto.TodoDto;

public interface GroupService {
	public void getMyGroupList(String id, Model model);
	public void getGroups(Model model);
	public GroupDto getGroup(int groupNum, Model model);
	public void getCategory(Model model);
	public void newGroup(GroupDto group, MultipartFile profileImg);
	public void deleteGroup(int groupNum);
	public void joinGroup(String id, int groupNum);
	public void leaveGroup(String id, int groupNum);
	
	/* todo */
	public void getTodoList(int groupNum, Model model);
	public String updateTodoList(int groupNum, String userId, List<TodoDto> todoList);
	public String deleteTodoList(List<Integer> deleteList);
}
