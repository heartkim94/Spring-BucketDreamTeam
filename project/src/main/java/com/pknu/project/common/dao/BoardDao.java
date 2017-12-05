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
	public void createTableBoard(int groupNum);
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
	public void deleteArticle(HashMap<String, String> paramMap);
	public List<ArticleDto> getReply(HashMap<String, String> paramMap);
	public List<Integer> getEndPoses(HashMap<String, String> paramMap);
	public void deleteSomeReply(HashMap<String, String> paramMap);
	public void deleteSomeReplyAll(HashMap<String, String> paramMap);
	// 글 수정
	public ArticleDto updateGetArticle(HashMap<String, String> paramMap);
	public void updateArticle(HashMap<String, String> paramMap);
}
