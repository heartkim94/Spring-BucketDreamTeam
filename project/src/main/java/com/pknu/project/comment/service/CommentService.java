package com.pknu.project.comment.service;

import java.util.HashMap;
import java.util.List;

import com.pknu.project.comment.dto.CommentDto;

public interface CommentService {
	public List<CommentDto> getComments(int boardNum, int articleNum, int commentRow);
	public void insertComment(CommentDto comment);
	public int commentCount(int boardNum, int articleNum);
	
	public void deleteComment(int commentNum);
}
