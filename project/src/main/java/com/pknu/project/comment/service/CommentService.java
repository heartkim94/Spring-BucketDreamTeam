package com.pknu.project.comment.service;

import java.util.List;

import com.pknu.project.comment.dto.CommentDto;

public interface CommentService {
//	public List<CommentDto> getComments(int articleNum, int commentRow);
	public void insertComment(CommentDto comment);
}
