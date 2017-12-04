package com.pknu.project.common.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.ui.Model;

import com.pknu.project.common.dto.ArticleDto;
import com.pknu.project.common.dto.BoardDto;


public interface BoardService {
	/* Board */
	public List<BoardDto> getBoards(int groupNum, Model model);
	public int newBoard(String boardName, int groupNum);
	public void renameBoard(BoardDto board);
	public String deleteBoard(int boardNum);
	/* Article */
	public void getArticles(int boardNum, int pageNum, Model model);
	public ArticleDto getArticle(String boardNum, String articleNum, int fileStatus, Model model);
	public void writeArticle(ArticleDto article);
	//검색 기능 구현
	public void getSearchedArticles(int boardNum, int pageNum, String searchOption, String keyword, Model model);
	// 답변달기
	public void reply(ArticleDto article);
	// 글 삭제
<<<<<<< HEAD
	public void deleteArticle(int articleNum, int boardNum);
	// 글 수정
	public void updateGetArticle(String articleNum, String boardNum, int fileStatus, Model model);
=======
	public void delete(ArticleDto article);
>>>>>>> refs/remotes/origin/jjong1
}
