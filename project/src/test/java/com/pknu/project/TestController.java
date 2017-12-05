package com.pknu.project;

import java.util.HashMap;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.pknu.project.common.dao.BoardDao;
import com.pknu.project.common.dto.ArticleDto;
import com.pknu.project.common.service.BoardService;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations= {"classpath:spring/root-context.xml", "classpath:spring/servlet-context.xml"})
public class TestController {
	@Autowired
	BoardDao dao;
	@Autowired
	BoardService service;
	HashMap<String, String> paramMap;
	
	@Test
	public void test() {
		paramMap = new HashMap<>();
		paramMap.put("boardNum", "-1");
		// dao.createTableBoard(paramMap);
	}
}
