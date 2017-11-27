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
		service.createBoard("Notice", -1);
		service.createBoard("QnA", -1);
		service.createBoard("FAQ", -1);
		
		ArticleDto article = new ArticleDto();
		article.setTitle("test notice article1");
		article.setContent("no content");
		article.setFileStatus(0);
		article.setBoardNum(1);
		service.writeArticle(article);
		
		paramMap = new HashMap<>();
		paramMap.put("startRow", "1");
		paramMap.put("endRow", "10");
		paramMap.put("boardNum", "1");
		List<ArticleDto> list = dao.getArticles(paramMap);
		for(ArticleDto dto: list) {
			System.out.println(dto.getArticleNum()+", "+dto.getTitle());
		}
	}
}
