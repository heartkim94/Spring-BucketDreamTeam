package com.pknu.project.community.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pknu.project.common.dto.ArticleDto;
import com.pknu.project.common.service.BoardService;
import com.pknu.project.community.service.CommunityService;

@Controller
@RequestMapping(value="/community")
public class CommunityController {
	@Autowired
	private CommunityService communityService;
	@Autowired
	private BoardService boardService;
	@Autowired
	private ServletContext servletContext;
	
	@PostConstruct
	public void init() {
		communityService.getAdminBoards(servletContext);
	}
	
	// 검색 조건 목록 설정
	@ModelAttribute("conditionMap")
	public Map<String, String> searchConditionMap(){
		Map<String, String> conditionMap = new HashMap<String, String>();
		conditionMap.put("제목", "TITLE");
		conditionMap.put("내용", "CONTENT");
		return conditionMap;
	}
	
	@RequestMapping(value="/list.do", method=RequestMethod.GET)
	public String community(
			@ModelAttribute("boardNum") int boardNum,
			@ModelAttribute("pageNum") int pageNum,
			Model model) {
		boardService.getArticles(boardNum, pageNum, model);
		communityService.getAdminBoardSetting(boardNum, model);
		return "community/list";
	}
	
	@RequestMapping(value="/write.do", method=RequestMethod.GET)
	public String writeForm(HttpSession session, Model model,
			@ModelAttribute("boardNum") int boardNum){
		System.out.println("***writeForm***");
		return "community/writeForm";
	}
	
	@RequestMapping(value="/write.do", method=RequestMethod.POST)
	public String write(ArticleDto article, HttpSession session){
//		article.setId((String)session.getAttribute("id"));
		boardService.writeArticle(article);
		System.out.println("***write***");
		return "redirect:list.do?pageNum=1&boardNum="+article.getBoardNum();
	}
	
	
	@RequestMapping(value="/content.do", method=RequestMethod.GET)
	public String getArticle(
			@ModelAttribute("boardNum") String boardNum,
			@RequestParam("articleNum") String articleNum,
			@ModelAttribute("pageNum") String pageNum,
			@RequestParam("fileStatus") int fileStatus,
			Model model, HttpSession session){						
		boardService.getArticle(boardNum, articleNum, fileStatus, model);
		System.out.println("***getNoticeArticle***");
		return "community/content";
	}
	
	@RequestMapping(value="/content.do", method=RequestMethod.POST)
	@ResponseBody
	public ArticleDto getArticleAsync(
			@RequestParam("boardNum") String boardNum,
			@RequestParam("articleNum") String articleNum,
			@RequestParam("fileStatus") int fileStatus,
			Model model, HttpSession session){
		System.out.println("***getNoticeArticle***");
		return boardService.getArticle(boardNum, articleNum, fileStatus, model);
	}
	
	// 검색 기능 구현
	@RequestMapping(value="list.do", method=RequestMethod.POST)
	public String list(@RequestParam(name="searchOption",defaultValue="title") String searchOption,
					   @RequestParam("keyword") String keyword,
					   @RequestParam("boardNum") int boardNum,
					   @RequestParam("pageNum") int pageNum,
					   Model model) {
	    model.addAttribute("boardNum", boardNum);
	    model.addAttribute("pageNum", pageNum);
	    
		boardService.getSearchedArticles(boardNum, pageNum, searchOption, keyword, model);
		communityService.getAdminBoardSetting(boardNum, model);
		return "community/list";
	}
	
	
}
