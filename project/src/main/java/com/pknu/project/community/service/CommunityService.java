package com.pknu.project.community.service;

import org.springframework.ui.Model;

import com.pknu.project.common.dto.ArticleDto;

public interface CommunityService {
	public Model noticeList(int pageNum,Model model);
	/* FAQ */
	public void faqList(int pageNum,Model model);
	public ArticleDto getFaqArticle(int articleNum);
}
