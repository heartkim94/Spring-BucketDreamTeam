package com.pknu.project.common.dao;

import java.util.HashMap;
import java.util.List;

import com.pknu.project.common.dto.ArticleDto;

public interface BoardDao {
	public int getCount(int boardNum);
	public List<ArticleDto> getArticles(HashMap<String, Integer> paramMap);
	public ArticleDto getArticle(HashMap<String, Integer> paramMap);
}
