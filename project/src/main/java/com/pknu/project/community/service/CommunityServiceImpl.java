package com.pknu.project.community.service;

import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.pknu.project.common.dto.ArticleDto;
import com.pknu.project.common.service.BoardService;
import com.pknu.project.common.utils.Page;
import com.pknu.project.community.dao.CommunityDao;

@Service
public class CommunityServiceImpl implements CommunityService {
	@Autowired
	CommunityDao communityDao;
	@Autowired
	BoardService boardService;
	@Autowired
	Page page;
	
	private ArticleDto article;
	
	List<ArticleDto> noticeList;
	
	HashMap<String, Integer> paramMap;
	
	@Override
	public void getAdminBoards(ServletContext servletContext) {
		servletContext.setAttribute("communityBoardList", boardService.getBoards(-1));
	}
	
	@Override
	public String getAdminBoardSetting(int boardNum) {
		return communityDao.getAdminBoardSetting(boardNum);
	}
}
