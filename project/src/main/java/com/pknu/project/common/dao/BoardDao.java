package com.pknu.project.common.dao;

import java.util.HashMap;
import java.util.List;

import com.pknu.project.common.dto.ArticleDto;
import com.pknu.project.common.dto.BoardDto;

public interface BoardDao {
	/* board */
	public List<BoardDto> getBoards(int groupNum);
	public String getAdminBoardSetting(int boardNum);
	public void addBoardList(HashMap<String, String> paramMap);
	public void createTableBoard(HashMap<String, String> paramMap);
	/* article */
//	public int getCount(int boardNum);
	public int getCount(HashMap<String, String> paramMap);
	public List<ArticleDto> getArticles(HashMap<String, String> paramMap);
	public ArticleDto getArticle(HashMap<String, String> paramMap);
	public void upHit(HashMap<String, String> paramMap);
	public void writeArticle(ArticleDto article);
}
