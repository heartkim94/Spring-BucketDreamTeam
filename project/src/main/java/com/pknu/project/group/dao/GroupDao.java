package com.pknu.project.group.dao;

import java.util.List;

import com.pknu.project.group.dto.CategoryDto;
import com.pknu.project.group.dto.DoDto;
import com.pknu.project.group.dto.GroupDto;

public interface GroupDao {
	public boolean isAdminMember(int userNum);
	public List<GroupDto> getMyGroup(String id);
	public GroupDto getGroup(int groupNum);
	public List<CategoryDto> getCategory();
	public void newGroup(GroupDto group);
	public void deleteGroup(int groupNum);
	
	/* do */
	public List<DoDto> getDoList(int groupNum);
}
