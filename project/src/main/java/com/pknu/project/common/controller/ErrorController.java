package com.pknu.project.common.controller;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/common")
public class ErrorController {
	
	private static final Logger logger = LoggerFactory.getLogger(ErrorController.class);
	
	@RequestMapping(value="/400")
	public String pageError400(HttpServletRequest req, Model model) {
		logger.info("page error code 400");
		model.addAttribute("msg", "잘못된 요청입니다/");
		return "common/error";
	}
}
