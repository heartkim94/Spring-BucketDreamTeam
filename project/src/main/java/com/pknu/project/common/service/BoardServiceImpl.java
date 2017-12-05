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
	private BoardDao boardDao;
	@Autowired
	private Page page;
	
	private ArticleDto article;
	
	private List<ArticleDto> articleList;
	private List<BoardDto> boardList;
	
	private HashMap<String, String> paramMap;
	
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
	public void getArticles(int groupNum, int boardNum, int pageNum, Model model){
		int totalCount = 0;
		int pageSize = 10; //한페이지에 보여줄 글의 갯수
		int pageBlock = 10; //한 블럭당 보여줄 페이지 갯수

		paramMap = new HashMap<>();
		paramMap.put("groupNum", String.valueOf(groupNum));
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
	public ArticleDto getArticle(int groupNum, String boardNum, String articleNum, int fileStatus, Model model) {
		paramMap = new HashMap<>();
		paramMap.put("groupNum", String.valueOf(groupNum));
		paramMap.put("boardNum", boardNum);
		paramMap.put("articleNum", articleNum);
		
		boardDao.upHit(paramMap);
		article=boardDao.getArticle(paramMap);
//		article.setCommentCount(bbsDao.getCommentCount(articleNum));
		
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
	
	//검색 기능 구현
	@Override
	public void getSearchedArticles(int groupNum, int boardNum, int pageNum, String searchOption, String keyword, Model model) {
		int totalCount = 0;
		int pageSize = 10; //한 페이지에 보여줄 글의 갯수
		int pageBlock = 10; //한 블럭당 보여줄 페이지 갯수
		
		paramMap = new HashMap<>();
		paramMap.put("groupNum", String.valueOf(groupNum));
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
	public void deleteArticle(int groupNum, String articleNum, String boardNum, int fileStatus, Model model) {
		paramMap = new HashMap<>();
		paramMap.put("groupNum", String.valueOf(groupNum));
		paramMap.put("boardNum", boardNum);
		paramMap.put("articleNum", articleNum);
		
		article = boardDao.getArticle(paramMap);
		if(article.getDepth() == 0) {
			deleteReply(paramMap);
		} else {
			deleteSomeReply(paramMap);
		}
		boardDao.deleteArticle(paramMap);
	}
	
	public void deleteReply(HashMap<String, String> paramMap) {
		List<ArticleDto> replyList = boardDao.getReply(paramMap);
		if(replyList != null) {
			for(ArticleDto reply : replyList) {
				HashMap<String, String> replyParamMap = new HashMap<>();
				replyParamMap.put("groupNum", paramMap.get("groupNum"));
				replyParamMap.put("boardNum", paramMap.get("boardNum"));
				replyParamMap.put("articleNum", String.valueOf(reply.getArticleNum()));
				boardDao.deleteArticle(replyParamMap);
			}
		}
	}
	
	public void deleteSomeReply(HashMap<String, String> paramMap) {
		paramMap.put("groupId", String.valueOf(article.getGroupId()));
		paramMap.put("depth", String.valueOf(article.getDepth()));
		paramMap.put("pos", String.valueOf(article.getPos()));
		List<Integer> endPoses = boardDao.getEndPoses(paramMap);
		
		if(endPoses.size()>0) {
			int endPos=endPoses.get(endPoses.size()-1);
			paramMap.put("endPos", String.valueOf(endPos));
			boardDao.deleteSomeReply(paramMap);
		} else {
			boardDao.deleteSomeReplyAll(paramMap);
		}
	}
	
	//글 수정
	@Override
	public void updateGetArticle(int groupNum, String articleNum, String boardNum, int fileStatus, Model model) {
		paramMap = new HashMap<>();
		paramMap.put("groupNum", String.valueOf(groupNum));
		paramMap.put("articleNum", articleNum);
		paramMap.put("boardNum", boardNum);
		article = boardDao.updateGetArticle(paramMap);
		
		model.addAttribute("title", article.getTitle());
		model.addAttribute("content", article.getContent());
//		if(fileStatus == 1) {
//			model.addAttribute("fileList", boardDao.getFiles(articleNum, boardNum));
//			model.addAttribute("fileCount", boardDao.getFiles(articleNum, boardNum).size);
//		} else {
//			model.addAttribute("fileCount", 0);
//		}
	}
	
	@Override
	public void updateArticle(ArticleDto article, String boardNum, Model model) {
		paramMap = new HashMap<>();
		paramMap.put("groupNum", String.valueOf(article.getGroupNum()));
		paramMap.put("articleNum", String.valueOf(article.getArticleNum()));
		paramMap.put("boardNum", String.valueOf(article.getBoardNum()));
		paramMap.put("title", article.getTitle());
		paramMap.put("content", article.getContent());
		paramMap.put("fileStatus", String.valueOf(article.getFileStatus()));
		System.out.println(paramMap);
		boardDao.updateArticle(paramMap);
	}
	
}
