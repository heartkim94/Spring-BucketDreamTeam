package com.pknu.project.common.service;

import java.util.List;

import org.springframework.ui.Model;

import com.pknu.project.common.dto.ArticleDto;
import com.pknu.project.common.dto.BoardDto;


public interface BoardService {
	/* Board */
	public List<BoardDto> getBoards(int groupNum);
	public String getAdminBoardSetting(int boardNum);
	public void createBoard(String boardName, int groupNum);
	/* Article */
	public void getArticles(int boardNum, int pageNum,Model model);
	public void getArticle(String boardNum, String articleNum, String fileStatus, Model model);
	public void writeArticle(ArticleDto article);
}
