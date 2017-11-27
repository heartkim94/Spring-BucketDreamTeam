package com.pknu.project.community.controller;

import javax.annotation.PostConstruct;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
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
public class CommunityController {
	@Autowired
	CommunityService communityService;
	@Autowired
	BoardService boardSerivce;
	@Autowired
	private ServletContext servletContext;
	
	@PostConstruct
	public void init() {
		servletContext.setAttribute("communityBoardList", boardSerivce.getBoards(-1));
	}
	
	@RequestMapping(value="/community/getBoards.do", method=RequestMethod.POST)
	@ResponseBody
	public String getBoards(HttpServletRequest request) {
		request.getServletContext().setAttribute("communityBoardList", boardSerivce.getBoards(-1));
		return "success";
	}
	@RequestMapping(value = "/noticeList.do", method = RequestMethod.GET)
	public String noticeList(@ModelAttribute("pageNum") int pageNum, Model model) {
		communityService.noticeList(pageNum, model);
		System.out.println("***noticeList***");
		return "noticeList";
	}
	
	@RequestMapping(value="/write.do", method=RequestMethod.GET)
	public String writeForm(HttpSession session){
		session.getId();
		System.out.println("***writeForm***");
		return "writeForm";   
	}
	
	@RequestMapping(value="/write.do", method=RequestMethod.POST)
	public String write(ArticleDto article, HttpSession session){
//		article.setId((String)session.getAttribute("id"));
		communityService.writeNotice(article);
		System.out.println("***write***");
		return "redirect:noticeList.do?pageNum=1";
	}
	
	
	@RequestMapping(value="/content.do")
	public String getNoticeArticle(@RequestParam("articleNum") int articleNum,
						  @ModelAttribute("pageNum") int pageNum,
						  @RequestParam("fileStatus") int fileStatus,
						  Model model, HttpSession session){						
		communityService.getNoticeArticle(articleNum, fileStatus, model);	
		System.out.println("***getNoticeArticle***");
		return "content";
	}
	
	/* FAQ */
	@RequestMapping(value="/faq.do", method=RequestMethod.GET)
	public String faqList(@ModelAttribute("pageNum") int pageNum, Model model, HttpServletRequest request) {
		System.out.println("***faq.do***");
		 communityService.faqList(pageNum, model);
		// boardSerivce.getArticles(pageNum, model);
		 request.getServletContext().setAttribute("communityBoardList", boardSerivce.getBoards(-1));
		return "community/faq";
	}
	
	@RequestMapping(value="/getFaqArticle.do", method=RequestMethod.POST)
	@ResponseBody
	public ArticleDto getFaqArticle(@RequestParam int articleNum) {
		System.out.println("***getFaqArticle.do***");
		System.out.println(articleNum);
		
		return communityService.getFaqArticle(articleNum);
	}
}
