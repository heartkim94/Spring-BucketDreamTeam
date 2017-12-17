package com.pknu.project.group.dao;

import java.util.HashMap;
import java.util.List;

import com.pknu.project.common.dto.FileDto;
import com.pknu.project.group.dto.CategoryDto;
import com.pknu.project.group.dto.GroupDto;
import com.pknu.project.group.dto.TodoDto;

public interface GroupDao {
	public boolean isAdminMember(int userNum);
	public List<GroupDto> getMyGroupList(String id);
	public List<GroupDto> getGroups();
	public GroupDto getGroup(int groupNum);
	public List<String> memberList(int groupNum);
	public List<CategoryDto> getCategory();
	public void newGroup(GroupDto group);
	public void insertProfileImg(FileDto fileDto);
	public void setDefaultProfile(FileDto fileDto);
	public void deleteGroup(int groupNum);
	public void joinGroup(HashMap<String, Object> paramMap);
	public void leaveGroup(HashMap<String, String> paramMap);
	
	/* todo */
	public List<TodoDto> getTodoList(int groupNum);
	public void updateTodoList(HashMap<String, Object> paramMap);
	public void deleteTodoList(List<Integer> deleteList);
}
