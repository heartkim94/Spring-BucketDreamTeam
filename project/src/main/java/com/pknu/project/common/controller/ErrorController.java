package com.pknu.project.common.controller;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/common/error")
public class ErrorController {
	
	private static final Logger logger = LoggerFactory.getLogger(ErrorController.class);
	
	@RequestMapping(value="/throwable")
	public String throwable(HttpServletRequest req, Model model) {
		logger.info("throwable");
//		pageErrorLog(req);
		model.addAttribute("msg", "예외가 발생했습니다");
		return "common/error";
	}
	@RequestMapping(value="/exception")
	public String exception(HttpServletRequest req, Model model) {
		logger.info("exception");
		model.addAttribute("msg", "예외가 발생했습니다");
		return "common/error";
	}
	@RequestMapping(value="/400")
	public String pageError400(HttpServletRequest req, Model model) {
		logger.info("pageerror code 400");
		model.addAttribute("msg", "잘못된 요청입니다.");
		return "common/error";
	}
	@RequestMapping(value="/403")
	public String pageError403(HttpServletRequest req, Model model) {
		logger.info("pageerror code 403");
		model.addAttribute("msg", "죄송합니다. 접근이 금지되었습니다.");
		return "common/error";
	}
	@RequestMapping(value="/404")
	public String pageError404(HttpServletRequest req, Model model) {
		logger.info("pageerror code 404");
		model.addAttribute("msg", "죄송합니다. 현재 찾을 수 없는 페이지를 요청하셨습니다.");
		return "common/error";
	}
	@RequestMapping(value="/405")
	public String pageError405(HttpServletRequest req, Model model) {
		logger.info("pageerror code 405");
		model.addAttribute("msg", "요청된 메서드가 허용되지 않습니다.");
		return "common/error";
	}
	@RequestMapping(value="/500")
	public String pageError500(HttpServletRequest req, Model model) {
		logger.info("pageerror code 500");
		model.addAttribute("msg", "죄송합니다. 서버에 오류가 발생하였습니다.");
		return "common/error";
	}
	@RequestMapping(value="/503")
	public String pageError503(HttpServletRequest req, Model model) {
		logger.info("pageerror code 503");
		model.addAttribute("msg", "서비스를 이용할 수 없습니다.");
		return "common/error";
	}
}
