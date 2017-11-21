package com.pknu.project;

import java.sql.Connection;
import java.sql.ResultSet;

import javax.sql.DataSource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessResourceFailureException;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations= {"classpath:spring/root-context.xml"})
public class testController {
	@Autowired
	DataSource dataSource;
	
	
	@Test
	public void test() {
		try {
			Connection con = dataSource.getConnection();
			ResultSet rs = con.prepareStatement("select 1 from dual").executeQuery();
			while(rs.next()) {
				System.out.println(rs.getString(1));
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
}
