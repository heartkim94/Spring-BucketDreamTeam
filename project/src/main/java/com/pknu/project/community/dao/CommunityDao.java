package com.pknu.project.community.dao;

import java.util.HashMap;
import java.util.List;

import com.pknu.project.community.dto.NoticeDto;

public interface CommunityDao {
	public int getNoticeCount();
	public List<NoticeDto> getArticles(HashMap<String, Integer> paramMap);

}
