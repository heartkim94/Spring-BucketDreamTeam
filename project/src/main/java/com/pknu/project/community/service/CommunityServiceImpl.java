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
	
	private HashMap<String, Object> map;
	
	@Override
	public void getAdminBoards(ServletContext servletContext) {
		servletContext.setAttribute("communityBoardList", boardService.getBoards(-1, null));
	}
	
	@Override
	public void getAdminBoardSetting(int boardNum, Model model) {
		map = communityDao.getAdminBoardSetting(boardNum);
		model.addAttribute("isAdminBoard", true);
		model.addAttribute("view", map.get("view"));
		model.addAttribute("adminOnly", map.get("adminOnly"));
	}
	
	@Override
	public void getAdminBoardSettings(Model model) {
		model.addAttribute("settings", communityDao.getAdminBoardSettings());
	}
	
	@Override
	public void insertAdminBoardSetting(int boardNum, String view) {
		map = new HashMap<String, Object>();
		map.put("boardNum", boardNum);
		map.put("view", view);
		communityDao.insertAdminBoardSetting(map);
	}
	
	@Override
	public void updateAdminBoardSetting(int boardNum, boolean adminOnly, String view) {
		map = new HashMap<String, Object>();
		map.put("boardNum", boardNum);
		map.put("adminOnly", adminOnly);
		map.put("view", view);
		communityDao.updateAdminBoardSetting(map);
	}
//	@def @class User: {
//		id: str;
//		pass: str;
//		name: str;
//	}
}
