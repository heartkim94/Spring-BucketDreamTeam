package com.pknu.project.community.dao;

import java.util.HashMap;

import com.pknu.project.common.dto.ArticleDto;

public interface CommunityDao {
	/* 검색 */
	public ArticleDto search(HashMap<String, String> searchMap);
//	public String getAdminBoardSetting(int boardNum);
	public HashMap<String, Object> getAdminBoardSetting(int boardNum);
	
	/* Notice */
	/*
	public int getNoticeCount();
	public List<ArticleDto> getNoticeArticles(HashMap<String, Integer> paramMap);
	public ArticleDto getNoticeArticle(int articleNum);
	public void writeNotice(ArticleDto article);
	/*
	/* FAQ */
	/*
	public int getFaqCount();
	public List<ArticleDto> getFaqArticles(HashMap<String, Integer> paramMap);
	public ArticleDto getFaqArticle(int articleNum);
	*/
	/* QnA */
	/*
	public int getQnaCount();
	public List<ArticleDto> getQnaArticles(HashMap<String, Integer> paramMap);
	public ArticleDto getQnaArticle(int articleNum);
	*/
	/* Util */
	// public void upHit(int articleNum);
}
