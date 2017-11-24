package com.pknu.project;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.pknu.project.group.dao.GroupDao;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations= {"classpath:spring/root-context.xml"})
public class TestController {
	@Autowired
	GroupDao dao;
	
	@Test
	public void test() {
		// 주석추가
		boolean res = dao.isAdminMember(1);
		System.out.println(res);
	}
}
