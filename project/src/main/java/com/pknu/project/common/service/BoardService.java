package com.pknu.project.common.service;

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
	public void getArticles(int boardNum, int pageNum,Model model);
	public ArticleDto getArticle(String boardNum, String articleNum, int fileStatus, Model model);
	public void writeArticle(ArticleDto article);
}