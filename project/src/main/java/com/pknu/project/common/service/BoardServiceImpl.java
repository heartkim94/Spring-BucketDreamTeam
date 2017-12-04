package com.pknu.project.common.service;

import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
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
	
	List<ArticleDto> articleList;
	List<BoardDto> boardList;
	
	HashMap<String, String> paramMap;
	
	@Resource(name="saveDir")
	String saveDir;
	
	/* Board */
	@Override
	public List<BoardDto> getBoards(int groupNum, Model model) {
		boardList = boardDao.getBoards(groupNum);
		if(model!=null) {
			model.addAttribute("boardList", boardList);
		}
		return boardList;
	}
	
	@Override
	public int newBoard(String boardName, int groupNum) {
		paramMap = new HashMap<>();
		paramMap.put("boardName", boardName);
		paramMap.put("groupNum", String.valueOf(groupNum));
		boardDao.addBoardList(paramMap);
		boardDao.createTableBoard(paramMap);
		return Integer.parseInt(String.valueOf((paramMap.get("boardNum"))));
	}
	
	@Override
	public void renameBoard(BoardDto board) {
		boardDao.renameBoard(board);
	}
	
	@Override
	public String deleteBoard(int boardNum) {
		paramMap = new HashMap<>();
		paramMap.put("boardNum", String.valueOf(boardNum));
		boardDao.deleteBoard(paramMap);
		return "success";
	}
	
	/* Article */
	@Override
	public void getArticles(int boardNum, int pageNum, Model model){
		int totalCount = 0;
		int pageSize = 10; //한페이지에 보여줄 글의 갯수
		int pageBlock = 10; //한 블럭당 보여줄 페이지 갯수

		paramMap = new HashMap<>();
		paramMap.put("boardNum", String.valueOf(boardNum));
		totalCount = boardDao.getCount(paramMap);
		
		page.paging(pageNum, boardNum, totalCount, pageSize, pageBlock);
		paramMap.put("startRow", String.valueOf(page.getStartRow()));
		paramMap.put("endRow", String.valueOf(page.getEndRow()));
		articleList = boardDao.getArticles(paramMap);
		
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("articleList", articleList);
		model.addAttribute("pageCode", page.getSb().toString());
	}
	
	@Override
	public ArticleDto getArticle(String boardNum, String articleNum, int fileStatus, Model model) {
		paramMap = new HashMap<>(); 
		paramMap.put("boardNum", boardNum); 
		paramMap.put("articleNum", articleNum);
		
		boardDao.upHit(paramMap);
		article=boardDao.getArticle(paramMap);
//		article.setCommentCount(bbsDao.getCommentCount(articleNum));
		
		model.addAttribute("article", article);
//		if(fileStatus == 1) {
//			model.addAttribute("fileList", boardDao.getFiles(Integer.parseInt(articleNum)));
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
	
	//검색 기능 구현
	@Override
	public void getSearchedArticles(int boardNum, int pageNum, String searchOption, String keyword, Model model) {
		int totalCount = 0;
		int pageSize = 10; //한 페이지에 보여줄 글의 갯수
		int pageBlock = 10; //한 블럭당 보여줄 페이지 갯수
		
		paramMap = new HashMap<>();
		paramMap.put("boardNum", String.valueOf(boardNum));
		paramMap.put("searchOption", searchOption);
	    paramMap.put("keyword", keyword);
		totalCount = boardDao.getSearchedCount(paramMap);
		
		page.paging(1, boardNum, totalCount, pageSize, pageBlock);
	    articleList = boardDao.getSearchedArticles(paramMap);
		
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("articleList", articleList);
		model.addAttribute("pageCode", page.getSb().toString());
	}
	
	// 답변 달기
	@Override
	public void reply(ArticleDto article) {
		boardDao.upPos(article);
		boardDao.reply(article);
	}
	
	// 글 삭제
	@Override
	public void deleteArticle(int articleNum, int boardNum) {
		paramMap = new HashMap<>();
		paramMap.put("boardNum", String.valueOf(boardNum));
		paramMap.put("articleNum", String.valueOf(articleNum));
		boardDao.deleteArticle(paramMap);
	}
	
	//글 수정
	public void updateGetArticle(String articleNum, String boardNum, int fileStatus, Model model) {
		paramMap = new HashMap<>();
		paramMap.put("articleNum", articleNum);
		paramMap.put("boardNum", boardNum);
		ArticleDto article = boardDao.updateGetArticle(paramMap);
		
		model.addAttribute("title", article.getTitle());
		model.addAttribute("content", article.getContent());
//		if(fileStatus == 1) {
//			model.addAttribute("fileList", boardDao.getFiles(articleNum, boardNum));
//			model.addAttribute("fileCount", boardDao.getFiles(articleNum, boardNum).size);
//		} else {
//			model.addAttribute("fileCount", 0);
//		}
	}
	
	
}
