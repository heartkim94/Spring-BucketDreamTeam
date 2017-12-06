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
	
	@RequestMapping(value="/list", method=RequestMethod.GET)
	public String community(
			@ModelAttribute("boardNum") int boardNum,
			@ModelAttribute("pageNum") int pageNum,
			Model model) {
		boardService.getArticles(-1, boardNum, pageNum, model);
		communityService.getAdminBoardSetting(boardNum, model);
		return "community/list";
	}
	
	@RequestMapping(value="/write", method=RequestMethod.GET)
	public String writeForm(HttpSession session, Model model,
			@ModelAttribute("boardNum") int boardNum){
		System.out.println("***writeForm***");
		model.addAttribute("action", "write");
		return "community/writeForm";
	}
	
	@RequestMapping(value="/write", method=RequestMethod.POST)
	public String write(ArticleDto article, HttpSession session){
//		article.setId((String)session.getAttribute("id"));
		article.setGroupNum(-1);
		boardService.writeArticle(article);
		System.out.println("***write***");
		return "redirect:list?pageNum=1&boardNum="+article.getBoardNum();
	}
	
	
	@RequestMapping(value="/content", method=RequestMethod.GET)
	public String getArticle(
			@ModelAttribute("boardNum") String boardNum,
			@RequestParam("articleNum") String articleNum,
			@ModelAttribute("pageNum") String pageNum,
			@RequestParam("fileStatus") int fileStatus,
			Model model, HttpSession session){						
		boardService.getArticle(-1, boardNum, articleNum, fileStatus, model);
		System.out.println("***getNoticeArticle***");
		return "community/content";
	}
	
	@RequestMapping(value="/content", method=RequestMethod.POST)
	@ResponseBody
	public ArticleDto getArticleAsync(
			@RequestParam("boardNum") String boardNum,
			@RequestParam("articleNum") String articleNum,
			@RequestParam("fileStatus") int fileStatus,
			Model model, HttpSession session){
		System.out.println("***getNoticeArticle***");
		return boardService.getArticle(-1, boardNum, articleNum, fileStatus, model);
	}
	
	// 검색 기능 구현
	@RequestMapping(value="list", method=RequestMethod.POST)
	public String list(@RequestParam(name="searchOption",defaultValue="title") String searchOption,
					   @RequestParam("keyword") String keyword,
					   @RequestParam("boardNum") int boardNum,
					   @RequestParam("pageNum") int pageNum,
					   Model model) {
	    model.addAttribute("boardNum", boardNum);
	    model.addAttribute("pageNum", pageNum);
	    
		boardService.getSearchedArticles(-1, boardNum, pageNum, searchOption, keyword, model);
		communityService.getAdminBoardSetting(boardNum, model);
		return "community/list";
	}
	
	// 답변 달기
	@RequestMapping(value="/reply", method=RequestMethod.GET)
	public String replyForm(HttpSession session,
			@ModelAttribute("boardNum") int boardNum,
			@ModelAttribute("groupId") int groupId, 
			@ModelAttribute("pos") int pos,
			@ModelAttribute("depth") int depth,
			@ModelAttribute("pageNum") int pageNum, Model model) {
		System.out.println("***replyForm***");
		model.addAttribute("action", "reply");
		return "community/writeForm";
	}
	
	@RequestMapping(value="/reply", method=RequestMethod.POST)
	public String reply(ArticleDto article, HttpSession session){		
		article.setId((String)session.getAttribute("id"));
		article.setGroupNum(-1);
		boardService.reply(article);
		return "redirect:list?pageNum=1&boardNum="+article.getBoardNum();
	}
	
	// 글 삭제
	@RequestMapping(value="/delete", method=RequestMethod.GET)
	public String deleteArticle(@RequestParam("articleNum") String articleNum,
						 		@RequestParam("boardNum") String boardNum,
						 		@RequestParam("pageNum") int pageNum,
						 		@RequestParam("fileStatus") int fileStatus, Model model) {
		boardService.deleteArticle(-1, articleNum, boardNum, fileStatus, model);
		return "redirect:list?pageNum="+pageNum+"&boardNum="+boardNum;
	}
	
	// 글 수정
	@RequestMapping(value="/update", method=RequestMethod.GET)
	public String updateForm(@ModelAttribute("articleNum") String articleNum,
							 @ModelAttribute("boardNum") String boardNum,
							 @ModelAttribute("pageNum") int pageNum,
							 @ModelAttribute("fileStatus") int fileStatus, Model model) {
		boardService.updateGetArticle(-1, articleNum, boardNum, fileStatus, model);
		model.addAttribute("action", "update");
		return "community/writeForm";
	}
	
	@RequestMapping(value="/update", method=RequestMethod.POST)
	public String updateArticle(@ModelAttribute("boardNum") String boardNum,
								@ModelAttribute("pageNum") int pageNum,
								ArticleDto article, Model model) {
		article.setGroupNum(-1);
		boardService.updateArticle(article, boardNum, model);
		return "redirect:list";
	}
	
}