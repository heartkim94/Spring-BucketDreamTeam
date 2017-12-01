package com.pknu.project.common.dao;

import java.util.HashMap;
import java.util.List;


import com.pknu.project.common.dto.ArticleDto;
import com.pknu.project.common.dto.BoardDto;
import com.pknu.project.common.dto.FileDto;

public interface BoardDao {
	/* board */
	public List<BoardDto> getBoards(int groupNum);
	public void addBoardList(HashMap<String, String> paramMap);
	public void createTableBoard(HashMap<String, String> paramMap);
	public void renameBoard(BoardDto board);
	public void deleteBoard(HashMap<String, String> paramMap);
	/* article */
	public int getCount(HashMap<String, String> paramMap);
	public List<ArticleDto> getArticles(HashMap<String, String> paramMap);
	public ArticleDto getArticle(HashMap<String, String> paramMap);
	public void upHit(HashMap<String, String> paramMap);
	public void writeArticle(ArticleDto article);
	// 파일업로드
	public void insertFile(FileDto fileDto);
	public void profileOf(FileDto fileDto);
	//검색 기능 구현
	public int getSearchedCount(HashMap<String, String> paramMap);
	public List<ArticleDto> getSearchedArticles(HashMap<String, String> paramMap);
	// 답변달기
	public void reply(ArticleDto article);
	public void upPos(ArticleDto article);
	// 글 삭제
	public void delete(int articleNum, int boardNum);
}
