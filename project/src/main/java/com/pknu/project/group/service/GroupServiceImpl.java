package com.pknu.project.group.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.pknu.project.group.dao.GroupDao;
import com.pknu.project.group.dto.GroupDto;

@Service
public class GroupServiceImpl implements GroupService {
	@Autowired
	private GroupDao groupDao;
	
	@Override
	public void getMyGroup(String id, Model model) {
		model.addAttribute("groupList", groupDao.getMyGroup(id));
	}
}
