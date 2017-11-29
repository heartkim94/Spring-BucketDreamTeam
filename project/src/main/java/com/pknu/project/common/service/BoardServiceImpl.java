package com.pknu.project.common.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.pknu.project.common.dao.BoardDao;
import com.pknu.project.common.dto.ArticleDto;
import com.pknu.project.common.dto.BoardDto;
import com.pknu.project.common.dto.FileDto;
import com.pknu.project.common.utils.Page;

@Service
public class BoardServiceImpl implements BoardService {
	@Autowired
	BoardDao boardDao;
	@Autowired
	Page page;
	
	private ArticleDto article;
	
	List<ArticleDto> noticeList;
	List<BoardDto> boardList;
	
	HashMap<String, String> paramMap;
	
	@Override
	public List<BoardDto> getBoards(int groupNum) {
		boardList = boardDao.getBoards(groupNum);
		return boardList;
	}
	
	@Override
	public void createBoard(String boardName, int groupNum) {
		paramMap = new HashMap<>();
		paramMap.put("boardName", boardName);
		paramMap.put("groupNum", String.valueOf(groupNum));
		boardDao.addBoardList(paramMap);
		boardDao.createTableBoard(paramMap);
	}
	
	@Override
	public void getArticles(int boardNum, int pageNum, Model model){
		int totalCount = 0;
		int pageSize = 10; //한페이지에 보여줄 글의 갯수
		int pageBlock = 10; //한 블럭당 보여줄 페이지 갯수

		paramMap = new HashMap<>();
		paramMap.put("boardNum", String.valueOf(boardNum));
		totalCount = boardDao.getCount(paramMap);
		
		page.paging(pageNum, totalCount, pageSize, pageBlock);
		paramMap.put("startRow", String.valueOf(page.getStartRow()));
		paramMap.put("endRow", String.valueOf(page.getEndRow()));
		noticeList = boardDao.getArticles(paramMap);
		
		model.addAttribute("totalCount",totalCount);
		model.addAttribute("articleList",noticeList);
		model.addAttribute("pageCode",page.getSb().toString());
	}

	@Override
	public ArticleDto getArticle(String boardNum, String articleNum, int fileStatus, Model model) {
		paramMap = new HashMap<>();
		paramMap.put("boardNum", boardNum);
		paramMap.put("articleNum", articleNum);
		article=boardDao.getArticle(paramMap);
//		article.setCommentCount(bbsDao.getCommentCount(articleNum));
		
		boardDao.upHit(paramMap);
		model.addAttribute("article", article);
//		if(fileStatus == 1) {
//			model.addAttribute("fileList", communityDao.getFiles(articleNum));
//		}
		return article;
	}

	@Override
	public void writeArticle(ArticleDto article) {
//		boardDao.writeArticle(article);
		if(article.getFileNames()==null) {
			boardDao.writeArticle(article);
		}else {
			article.setFileStatus((byte)1);
			// 리턴을 하지 않아도 article에 값이 넘어옴
			boardDao.writeArticle(article);
			commonFileUpload(article.getArticleNum(), article.getBoardNum(),article.getFileNames());
		}
	}
	
	public void commonFileUpload(int articleNum, int boardNum, List<String> fileNames) {
		FileDto fileDto = null;
		
		for(String storedFname: fileNames){					
			fileDto = new FileDto();			
			fileDto.setStoredFname(storedFname);			
			fileDto.setArticleNum(articleNum);
			fileDto.setBoardNum(boardNum);
			boardDao.insertFile(fileDto);				
		}
	}
}
