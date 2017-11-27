package com.pknu.project.community.dao;

import java.util.HashMap;
import java.util.List;

import com.pknu.project.common.dto.ArticleDto;
import com.pknu.project.common.dto.BoardDto;

public interface CommunityDao {
	public String getAdminBoardSetting(int boardNum);
	
	/* Old Method */
	public int getNoticeCount();
	public List<ArticleDto> getNoticeArticles(HashMap<String, Integer> paramMap);
	public ArticleDto getNoticeArticle(int articleNum);
	public void upHit(int articleNum);
	// 새 notice 쓰기
	public void writeNotice(ArticleDto article);
	/* FAQ */
	public List<ArticleDto> getFaqArticles(HashMap<String, Integer> paramMap);
	public ArticleDto getFaqArticle(int articleNum);
}
