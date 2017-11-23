package com.pknu.project.common.dao;

import java.util.HashMap;
import java.util.List;

import com.pknu.project.common.dto.ArticleDto;

public interface NoticeDao {
	List<ArticleDto> list(HashMap<String, String> paramMap);
}
