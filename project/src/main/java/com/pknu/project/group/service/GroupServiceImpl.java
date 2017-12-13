package com.pknu.project.group.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.pknu.project.common.dao.BoardDao;
import com.pknu.project.common.service.BoardService;
import com.pknu.project.group.dao.GroupDao;
import com.pknu.project.group.dto.GroupDto;
import com.pknu.project.group.dto.TodoDto;

@Service
public class GroupServiceImpl implements GroupService {
	@Autowired
	private GroupDao groupDao;
	@Autowired
	private BoardDao boardDao;
	@Autowired
	private BoardService boardService;
	
	private GroupDto group;
	private HashMap<String, String> paramMap;
	
	@Override
	public void getMyGroup(String id, Model model) {
		model.addAttribute("myGroupList", groupDao.getMyGroup(id));
	}
	
	@Override
	public void getGroups(Model model) {
		model.addAttribute("groupList", groupDao.getGroups());
	}

	@Override
	public GroupDto getGroup(int groupNum, Model model) {
		group = groupDao.getGroup(groupNum);
		if(model!=null) {
			model.addAttribute("group", group);
		}
		return group;
	}
	
	@Override
	public void deleteGroup(int groupNum) {
		groupDao.deleteGroup(groupNum);
	}
	
	/* new */
	@Override
	public void getCategory(Model model) {
		model.addAttribute("catList", groupDao.getCategory());
	}

	@Override
	public void newGroup(GroupDto group) {
		groupDao.newGroup(group);
		paramMap = new HashMap<>();
		paramMap.put("groupNum", String.valueOf(group.getGroupNum()));
		boardDao.createGroupBoard(paramMap);
		boardService.newBoard("Board", group.getGroupNum());
	}
	
	
	/* todo */
	@Override
	public void getTodoList(int groupNum, Model model) {
		model.addAttribute("todoList", groupDao.getTodoList(groupNum));
	}
	
	@Override
	public String updateTodoList(int groupNum, String userId, List<TodoDto> todoList) {
		HashMap<String, Object> paramMap = new HashMap<>();
		paramMap.put("groupNum", groupNum);
		paramMap.put("id", userId);
		paramMap.put("todoList", todoList);
		groupDao.updateTodoList(paramMap);
		return "success";
	}
	
	@Override
	public String deleteTodoList(List<Integer> deleteList) {
		groupDao.deleteTodoList(deleteList);
		return "success";
	}
}
