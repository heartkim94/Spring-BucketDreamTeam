package com.pknu.project.community.controller;

import java.util.Locale;

import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class CommunityController {
	@RequestMapping(value = "/notice.do", method = RequestMethod.GET)
	public String home(Model model) {
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
}
