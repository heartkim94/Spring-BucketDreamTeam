package com.pknu.project.common.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.ui.Model;

import com.pknu.project.common.dto.ArticleDto;
import com.pknu.project.common.dto.BoardDto;


public interface BoardService {
	/* Board */
	public List<BoardDto> getBoards(int groupNum);
	public void createBoard(String boardName, int groupNum);
	/* Article */
	public void getArticles(int boardNum, int pageNum, Model model);
	public ArticleDto getArticle(String boardNum, String articleNum, int fileStatus, Model model);
	public void writeArticle(ArticleDto article);
	//검색 기능 구현
	public void getSearchedArticles(int boardNum, int pageNum, String searchOption, String keyword, Model model);
}
