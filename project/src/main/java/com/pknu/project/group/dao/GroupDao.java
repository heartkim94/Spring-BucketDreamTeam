package com.pknu.project.group.dao;

import java.util.List;

import com.pknu.project.group.dto.CategoryDto;
import com.pknu.project.group.dto.GroupDto;

public interface GroupDao {
	public boolean isAdminMember(int userNum);
	public List<GroupDto> getMyGroup(String id);
	public List<CategoryDto> getCategory();
	public void newGroup(GroupDto group);
}