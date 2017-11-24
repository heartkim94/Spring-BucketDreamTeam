package com.pknu.project.community.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.pknu.project.common.Page;
import com.pknu.project.common.dto.ArticleDto;
import com.pknu.project.community.dao.CommunityDao;

@Service
public class CommunityServiceImpl implements CommunityService {
	@Autowired
	CommunityDao communityDao;
	@Autowired
	Page page;
	
	List<ArticleDto> noticeList;
	
	HashMap<String, Integer> paramMap;
	
	public Model noticeList(int pageNum, Model model){
		int totalCount = 0;
		int pageSize = 10; //한페이지에 보여줄 글의 갯수
		int pageBlock = 10; //한 블럭당 보여줄 페이지 갯수

		totalCount = communityDao.getNoticeCount();
		page.paging(pageNum, totalCount, pageSize, pageBlock);
		paramMap = new HashMap<>();
		paramMap.put("startRow", page.getStartRow());
		paramMap.put("endRow", page.getEndRow());
		noticeList = communityDao.getNoticeArticles(paramMap);
		model.addAttribute("totalCount",totalCount);
		model.addAttribute("articleList",noticeList);
		model.addAttribute("pageCode",page.getSb().toString());

		return model;
	}

}
