package com.pknu.project.group.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pknu.project.common.dto.BoardDto;
import com.pknu.project.group.dto.GroupDto;
import com.pknu.project.group.service.GroupService;

@Controller
@RequestMapping(value="/group")
public class GroupController {
	@Autowired
	private GroupService groupService;
	
	@RequestMapping(value="/main.do", method=RequestMethod.GET)
	public String main(HttpSession session, Model model) {
		String id = (String)session.getAttribute("id");
		groupService.getMyGroup(id, model);
		return "group/main";
	}
	
	@RequestMapping(value="/new.do", method=RequestMethod.GET)
	public String newGroupForm(Model model) {
		groupService.getCategory(model);
		return "group/new";
	}
	
	@RequestMapping(value="/new.do", method=RequestMethod.POST)
	public String newGroup(GroupDto group) {
		groupService.newGroup(group);
		return "redirect:main.do";
	}
	
	@RequestMapping(value="/{groupNum}/view.do", method=RequestMethod.GET)
	public String view(@PathVariable("groupNum") int groupNum,
			Integer boardNum, Integer pageNum, Model model) {
		groupService.getBoards(groupNum, model);
		if(boardNum!=null && pageNum!=null) {
			groupService.getArticles(boardNum, pageNum, model);
			model.addAttribute("boardNum", boardNum);
			model.addAttribute("pageNum", pageNum);
		}
		return "group/view";
	}
	
	@RequestMapping(value="/{groupNum}/setting.do", method=RequestMethod.GET)
	public String setting(@PathVariable("groupNum") int groupNum, Model model) {
		groupService.getBoards(groupNum, model);
		return "group/setting";
	}
	
	@RequestMapping(value="/{groupNum}/renameBoard.do", method=RequestMethod.POST)
	@ResponseBody
	public String renameBoard(
			@PathVariable("groupNum") String groupNum,
			BoardDto board) {
		return groupService.renameBoard(board);
	}
	
	@RequestMapping(value="/{groupNum}/newBoard.do", method=RequestMethod.POST)
	@ResponseBody
	public int newBoard(@PathVariable("groupNum") int groupNum, String boardName) {
		return groupService.newBoard(boardName, groupNum);
	}
	
	@RequestMapping(value="/{groupNum}/deleteBoard.do", method=RequestMethod.POST)
	@ResponseBody
	public String deleteBoard(int boardNum) {
		return groupService.deleteBoard(boardNum);
	}
}