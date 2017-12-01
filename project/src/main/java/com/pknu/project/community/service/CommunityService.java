package com.pknu.project.community.service;

import javax.servlet.ServletContext;

import org.springframework.ui.Model;


public interface CommunityService {
	public void getAdminBoards(ServletContext servletContext);
	public void getAdminBoardSetting(int boardNum, Model model);
	
	/* Old Method */
//	public Model noticeList(int pageNum,Model model);
//	public void getNoticeArticle(int articleNum, int fileStatus, Model model);
//	public void writeNotice(ArticleDto article);
	
}
