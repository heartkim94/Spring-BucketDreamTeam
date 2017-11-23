package com.pknu.project.community.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pknu.project.common.dto.ArticleDto;
import com.pknu.project.community.service.CommunityService;

@Controller
public class CommunityController {
	@Autowired
	CommunityService svc;
	
	@RequestMapping(value = "/notice.do", method = RequestMethod.GET)
	public String noticeList(@ModelAttribute("pageNum") int pageNum, Model model) {
		svc.noticeList(pageNum, model);
		System.out.println("***notice***");
		return "notice";
	}
	
	@RequestMapping(value="/write.do", method=RequestMethod.GET)
	public String writeForm(){
		System.out.println("***writeForm***");
		return "writeForm";   
	}
	
	@RequestMapping(value="/write.do", method=RequestMethod.POST)
	public String write(){
		System.out.println("***write***");
		return "notice";   
	}
	
	/* FAQ */
	@RequestMapping(value="/faq.do", method=RequestMethod.GET)
	public String faqList(@ModelAttribute("pageNum") int pageNum, Model model) {
		System.out.println("***faq.do***");
		svc.faqList(pageNum, model);
		return "community/faq";
	}
	
	@RequestMapping(value="/getFaqArticle.do", method=RequestMethod.POST)
	@ResponseBody
	public ArticleDto getFaqArticle(@RequestParam int articleNum) {
		System.out.println("***getFaqArticle.do***");
		System.out.println(articleNum);
		
		return svc.getFaqArticle(articleNum);
	}
}
