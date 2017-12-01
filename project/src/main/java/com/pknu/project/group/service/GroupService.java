package com.pknu.project.group.service;

import org.springframework.ui.Model;

import com.pknu.project.common.dto.BoardDto;
import com.pknu.project.group.dto.GroupDto;

public interface GroupService {
	public void getMyGroup(String id, Model model);
	public void getCategory(Model model);
	public void newGroup(GroupDto group);
}
