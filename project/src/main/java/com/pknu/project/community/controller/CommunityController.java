package com.pknu.project.community.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.pknu.project.common.dto.ArticleDto;
import com.pknu.project.community.service.CommunityService;

@Controller
public class CommunityController {
	@Autowired
	CommunityService communityService;
	
	@RequestMapping(value = "/notice.do", method = RequestMethod.GET)
	public String noticeList(@ModelAttribute("pageNum") int pageNum, Model model) {
		communityService.noticeList(pageNum, model);
		System.out.println("***notice***");
		return "notice";
	}
	
	@RequestMapping(value="/write.do", method=RequestMethod.GET)
	public String writeForm(){
		System.out.println("***writeForm***");
		return "writeForm";   
	}
	
	@RequestMapping(value="/write.do", method=RequestMethod.POST)
	public String write(ArticleDto article, HttpSession session){
//		article.setId((String)session.getAttribute("id"));
		communityService.writeNotice(article);
		System.out.println("***write***");
		return "redirect:notice.do?pageNum=1";   
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
}
