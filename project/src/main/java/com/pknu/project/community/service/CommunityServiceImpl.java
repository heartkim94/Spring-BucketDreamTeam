package com.pknu.project.community.service;

import java.util.HashMap;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.pknu.project.common.service.BoardService;
import com.pknu.project.community.dao.CommunityDao;

@Service
public class CommunityServiceImpl implements CommunityService {
	@Autowired
	private CommunityDao communityDao;
	@Autowired
	private BoardService boardService;
	
	private HashMap<String, Object> resMap;
	
	@Override
	public void getAdminBoards(ServletContext servletContext) {
		servletContext.setAttribute("communityBoardList", boardService.getBoards(-1, null));
	}
	
	@Override
	public void getAdminBoardSetting(int boardNum, Model model) {
		resMap = communityDao.getAdminBoardSetting(boardNum);
		model.addAttribute("isAdminBoard", true);
		model.addAttribute("view", resMap.get("view"));
		model.addAttribute("adminOnly", resMap.get("adminOnly"));
	}
}
