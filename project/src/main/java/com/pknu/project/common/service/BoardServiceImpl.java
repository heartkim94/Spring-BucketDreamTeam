package com.pknu.project.common.service;

import java.io.File;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.pknu.project.comment.service.CommentService;
import com.pknu.project.common.dao.BoardDao;
import com.pknu.project.common.dto.ArticleDto;
import com.pknu.project.common.dto.BoardDto;
import com.pknu.project.common.dto.FileDto;
import com.pknu.project.common.utils.Page;
import com.pknu.project.community.service.CommunityService;

@Service
public class BoardServiceImpl implements BoardService {
	@Autowired
	private BoardDao boardDao;
	@Autowired
	private Page page;
	@Autowired
	private CommentService commentService;
	
	private ArticleDto article;
	private FileDto file;
	
	private List<ArticleDto> articleList;
	private List<FileDto> fileList;
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
		
		for(ArticleDto article : articleList) {
			article.setCommentCount(commentService.commentCount(boardNum, article.getArticleNum()));
		}
	}
	
	@Override
	public ArticleDto getArticle(int groupNum, String boardNum, String articleNum, int fileStatus, Model model) {
		paramMap = new HashMap<>();
		paramMap.put("groupNum", String.valueOf(groupNum));
		paramMap.put("boardNum", boardNum);
		paramMap.put("articleNum", articleNum);
		boardDao.upHit(paramMap);
		boardDao.getFiles(paramMap);
		article = boardDao.getArticle(paramMap);
		article.setCommentCount(commentService.commentCount(Integer.parseInt(boardNum), article.getArticleNum()));
		model.addAttribute("article", article);
		if(fileStatus == 1) {
			fileList = boardDao.getFiles(paramMap);
			model.addAttribute("fileList", fileList);
		}
		return article;
	}

	@Override
	public FileSystemResource download(HttpServletResponse resp, String storedFname) {
		String originFname=storedFname.substring(storedFname.indexOf("_")+1);;
		try {
			originFname = URLEncoder.encode(originFname,"utf-8").replace("+","%20").replace("%28", "(").replace("%29", ")");
		} catch (Exception e){}
		
		resp.setContentType("application/download");
		resp.setHeader("Content-Disposition", "attachment;" +" filename=\""+originFname+ "\";");
		FileSystemResource fsr= new FileSystemResource(saveDir+storedFname);
		return fsr;
	}

	@Override
	public void writeArticle(ArticleDto article) {
		if(article.getFiles().size()==0) {
			boardDao.writeArticle(article);
		}else {
			article.setFileStatus((byte)1);
			// 리턴을 하지 않아도 article에 값이 넘어옴
			boardDao.writeArticle(article);
			commonFileUpload(article.getArticleNum(), article.getBoardNum(), article.getFiles());
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
		if(article.getFiles().size()==0) {
			boardDao.reply(article);
		}else {
			article.setFileStatus((byte)1);
			// 리턴을 하지 않아도 article에 값이 넘어옴
			boardDao.upPos(article);
			boardDao.reply(article);
			commonFileUpload(article.getArticleNum(), article.getBoardNum(),article.getFiles());
		}
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
	
	// 파일 삭제 메서드
//	public void deleteFile(int articleNum, int boardNum, int fileNum){
//		System.out.println("articleNum: "+articleNum);
//		System.out.println("boardNum: "+boardNum);
//		System.out.println("fileNum: "+fileNum);
//		HashMap<String, String> paramMap = new HashMap<>();
//		paramMap.put("articleNum", String.valueOf(articleNum));
//		paramMap.put("boardNum", String.valueOf(boardNum));
//		List<FileDto> storedFnameList=(List<FileDto>) boardDao.getFiles(paramMap);
//		if(!storedFnameList.isEmpty()){
//			for(FileDto storedFname : storedFnameList){
//				File file = new File(saveDir+storedFname);
//				if(file.exists()){ 
//					file.delete();
//				}
//			}
//		}
//	}
	
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
		if(fileStatus == 1) {
//			model.addAttribute("fileList", boardDao.getFiles(articleNum, boardNum));
//			model.addAttribute("fileCount", boardDao.getFiles(articleNum, boardNum).size);
			model.addAttribute("fileList", boardDao.getFiles(paramMap));
			model.addAttribute("fileCount", boardDao.getFiles(paramMap).size());
		} else {
			model.addAttribute("fileCount", 0);
		}
	}
	
	@Override
	public void updateArticle(ArticleDto article, String boardNum, Model model) {
		if(article.getFiles().size()==0) {
			article.setFileStatus((byte)0);
			boardDao.updateArticle(article);
		}else {
			article.setFileStatus((byte)1);
			boardDao.updateArticle(article);
			commonFileUpload(article.getArticleNum(), article.getBoardNum(),article.getFiles());
		}
	}
	
	public void commonFileUpload(int articleNum, int boardNum, List<FileDto> files) {
		for(FileDto fileDto: files){
			fileDto.setArticleNum(articleNum);
			fileDto.setBoardNum(boardNum);
			boardDao.insertFile(fileDto);
		}
	}
	
	// 글 수정시 파일 삭제
	public void updateSomeDelFile(String storedFname){		
		if(!storedFname.isEmpty()){			
			File file = new File(saveDir+storedFname);
			if(file.exists()){
				file.delete();
			}			
		}
	}
	
	
}
