package com.pknu.project.group.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.pknu.project.common.dto.BoardDto;
import com.pknu.project.common.service.BoardService;
import com.pknu.project.group.dao.GroupDao;
import com.pknu.project.group.dto.GroupDto;

@Service
public class GroupServiceImpl implements GroupService {
	@Autowired
	private GroupDao groupDao;
	@Autowired
	private BoardService boardService;
	
	@Override
	public void getMyGroup(String id, Model model) {
		model.addAttribute("groupList", groupDao.getMyGroup(id));
	}
	
	/* new */
	@Override
	public void getCategory(Model model) {
		model.addAttribute("catList", groupDao.getCategory());
	}

	@Override
	public void newGroup(GroupDto group) {
		groupDao.newGroup(group);
		
		boardService.newBoard("Board", group.getGroupNum());
	}
}
