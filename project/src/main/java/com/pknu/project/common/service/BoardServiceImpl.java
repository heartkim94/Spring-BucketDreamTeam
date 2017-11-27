package com.pknu.project.common.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.pknu.project.common.Page;
import com.pknu.project.common.dao.BoardDao;
import com.pknu.project.common.dto.ArticleDto;
import com.pknu.project.community.dao.CommunityDao;

@Service
public class BoardServiceImpl implements BoardService {
	@Autowired
	BoardDao boardDao;
	@Autowired
	Page page;
	
	private ArticleDto article;
	
	List<ArticleDto> noticeList;
	
	HashMap<String, Integer> paramMap;
	
	@Override
	public void getArticles(int boardNum, int pageNum, Model model){
		int totalCount = 0;
		int pageSize = 10; //한페이지에 보여줄 글의 갯수
		int pageBlock = 10; //한 블럭당 보여줄 페이지 갯수

		totalCount = boardDao.getCount(boardNum);
		page.paging(pageNum, totalCount, pageSize, pageBlock);
		paramMap = new HashMap<>();
		paramMap.put("startRow", page.getStartRow());
		paramMap.put("endRow", page.getEndRow());
		noticeList = boardDao.getArticles(paramMap);
		model.addAttribute("totalCount",totalCount);
		model.addAttribute("articleList",noticeList);
		model.addAttribute("pageCode",page.getSb().toString());
	}

	@Override
	public void getNoticeArticle(int articleNum, int fileStatus, Model model) {
		article=boardDao.getArticle(articleNum);
//		article.setCommentCount(bbsDao.getCommentCount(articleNum));
		boardDao.upHit(articleNum);
		model.addAttribute("article", article);
//		if(fileStatus == 1) {
//			model.addAttribute("fileList", communityDao.getFiles(articleNum));
//		}
	}

	@Override
	public void writeNotice(ArticleDto article) {
		boardDao.writeNotice(article);
//		if(article.getFileNames()==null) {
//			communityDao.writeNotice(article);
//		}else {
//			article.setFileStatus((byte)1);
//			// 리턴을 하지 않아도 article에 값이 넘어옴
//			communityDao.writeNotice(article);
//			commonFileUpload(article.getArticleNum(), article.getFileNames());
//		}
	}
	
	
	
	/* FAQ */
	@Override
	public void faqList(int pageNum, Model model){
		int totalCount = 0;
		int pageSize = 10; //한페이지에 보여줄 글의 갯수
		int pageBlock = 10; //한 블럭당 보여줄 페이지 갯수

		totalCount = boardDao.getNoticeCount();
		page.paging(pageNum, totalCount, pageSize, pageBlock);
		paramMap = new HashMap<>();
		paramMap.put("startRow", page.getStartRow());
		paramMap.put("endRow", page.getEndRow());
		
		model.addAttribute("totalCount",totalCount);
		model.addAttribute("articleList", boardDao.getFaqArticles(paramMap));
		model.addAttribute("pageCode",page.getSb().toString());
	}

	@Override
	public ArticleDto getFaqArticle(int articleNum) {
		ArticleDto article = boardDao.getFaqArticle(articleNum);
		System.out.println(article.getTitle());
		return boardDao.getFaqArticle(articleNum);
	}
}
