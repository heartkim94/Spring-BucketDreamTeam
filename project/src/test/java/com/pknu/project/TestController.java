package com.pknu.project;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.pknu.project.common.dao.NoticeDao;
import com.pknu.project.common.dto.ArticleDto;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations= {"classpath:spring/root-context.xml"})
public class TestController {
	@Autowired
	NoticeDao dao;
	
	@Test
	public void test() {
		// 주석추가
		List<ArticleDto> list = dao.list(null);
		for(ArticleDto article : list) {
			String text = article.getArticleNum()
					 +"|"+article.getTitle()
					 +"|"+article.getGroupId();
			System.out.println(text);
		}
	}
}