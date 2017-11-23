package com.pknu.project.community.dao;

import java.util.HashMap;
import java.util.List;

import com.pknu.project.common.dto.ArticleDto;

public interface CommunityDao {
	public int getNoticeCount();
	public List<ArticleDto> getNoticeArticles(HashMap<String, Integer> paramMap);
}
