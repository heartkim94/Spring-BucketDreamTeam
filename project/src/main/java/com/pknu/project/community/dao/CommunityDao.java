package com.pknu.project.community.dao;

import java.util.HashMap;
import java.util.List;

import com.pknu.project.common.dto.ArticleDto;

public interface CommunityDao {
	public int getNoticeCount();
	public List<ArticleDto> getNoticeArticles(HashMap<String, Integer> paramMap, String searchCondition, String searchKeyword);
	public ArticleDto getNoticeArticle(int articleNum);
	public void upHit(int articleNum);
	// 새 notice 쓰기
	public void writeNotice(ArticleDto article);
	/* FAQ */
	public List<ArticleDto> getFaqArticles(HashMap<String, Integer> paramMap);
	public ArticleDto getFaqArticle(int articleNum);
	
}
