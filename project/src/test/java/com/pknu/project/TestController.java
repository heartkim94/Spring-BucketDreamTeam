package com.pknu.project;

import java.util.HashMap;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.pknu.project.community.dao.CommunityDao;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations= {"classpath:spring/root-context.xml", "classpath:spring/servlet-context.xml"})
public class TestController {
	@Autowired
	CommunityDao dao;
	
	HashMap<String, Object> paramMap;
	List<HashMap<String, Object>> res;
	@Test
	public void test() {
		res = dao.getAdminBoardSettings();
		System.out.println(res);
		if(res!=null) {
			for(HashMap<String, Object> setting: res) {
				System.out.println(setting.get("boardNum")
						+", "+setting.get("adminOnly")
						+", "+setting.get("view"));
			}
		}
	}
}
