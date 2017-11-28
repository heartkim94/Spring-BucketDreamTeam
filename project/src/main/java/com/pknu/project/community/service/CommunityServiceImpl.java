package com.pknu.project.community.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.pknu.project.common.Page;
import com.pknu.project.common.dto.ArticleDto;
import com.pknu.project.community.dao.CommunityDao;

@Service
public class CommunityServiceImpl implements CommunityService {
	@Autowired
	CommunityDao communityDao;
	@Autowired
	Page page;
	
	private ArticleDto article;
	
	List<ArticleDto> noticeList;
	
	HashMap<String, Integer> paramMap;
	
	public Model noticeList(int pageNum, Model model){
		int totalCount = 0;
		int pageSize = 10; //한페이지에 보여줄 글의 갯수
		int pageBlock = 10; //한 블럭당 보여줄 페이지 갯수
		
		totalCount = communityDao.getNoticeCount();
		page.paging(pageNum, totalCount, pageSize, pageBlock);
		paramMap = new HashMap<>();
		paramMap.put("startRow", page.getStartRow());
		paramMap.put("endRow", page.getEndRow());
		noticeList = communityDao.getNoticeArticles(paramMap);
		model.addAttribute("totalCount",totalCount);
		model.addAttribute("articleList",noticeList);
		model.addAttribute("pageCode",page.getSb().toString());

		return model; 
	}

	@Override
	public void getNoticeArticle(int articleNum, int fileStatus, Model model) {
		article=communityDao.getNoticeArticle(articleNum);
//		article.setCommentCount(bbsDao.getCommentCount(articleNum));
		communityDao.upHit(articleNum);
		model.addAttribute("article", article);
//		if(fileStatus == 1) {
//			model.addAttribute("fileList", communityDao.getFiles(articleNum));
//		}
	}

	@Override
	public void writeNotice(ArticleDto article) {
		communityDao.writeNotice(article);
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

		totalCount = communityDao.getFaqCount();
		page.paging(pageNum, totalCount, pageSize, pageBlock);
		paramMap = new HashMap<>();
		paramMap.put("startRow", page.getStartRow());
		paramMap.put("endRow", page.getEndRow());
		
		model.addAttribute("totalCount",totalCount);
		model.addAttribute("articleList", communityDao.getFaqArticles(paramMap));
		model.addAttribute("pageCode",page.getSb().toString());
	}

	@Override
	public ArticleDto getFaqArticle(int articleNum) {
		ArticleDto article = communityDao.getFaqArticle(articleNum);
		System.out.println(article.getTitle());
		return communityDao.getFaqArticle(articleNum);
	}
	
	
	
	
	/* QnA */
	@Override
	public void qnaList(int pageNum, Model model){
		int totalCount = 0;
		int pageSize = 10; //한페이지에 보여줄 글의 갯수
		int pageBlock = 10; //한 블럭당 보여줄 페이지 갯수

		totalCount = communityDao.getQnaCount();
		page.paging(pageNum, totalCount, pageSize, pageBlock);
		paramMap = new HashMap<>();
		paramMap.put("startRow", page.getStartRow());
		paramMap.put("endRow", page.getEndRow());
		
		model.addAttribute("totalCount",totalCount);
		model.addAttribute("articleList", communityDao.getQnaArticles(paramMap));
		model.addAttribute("pageCode",page.getSb().toString());
	}

	@Override
	public ArticleDto getQnaArticle(int articleNum) {
		return communityDao.getQnaArticle(articleNum);
	}
}
