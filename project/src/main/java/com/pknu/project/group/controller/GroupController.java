package com.pknu.project.group.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
		return "group/groupMain";
	}
}