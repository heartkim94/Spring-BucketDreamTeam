package com.pknu.project.common.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {

	@RequestMapping(value = "/home", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		System.out.println("hello");
		return "home";
	}
	
<<<<<<< HEAD
	@RequestMapping(value="/writeForm.do")
	@Transactional
	public String list(){
		System.out.println("writeForm");
		return "writeForm";   
	}
=======
>>>>>>> refs/remotes/origin/jongBranch
}