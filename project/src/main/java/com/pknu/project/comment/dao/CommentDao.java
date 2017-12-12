package com.pknu.project.comment.dao;

import java.util.HashMap;
import java.util.List;

import com.pknu.project.comment.dto.CommentDto;

public interface CommentDao {
	public List<CommentDto> getComments(HashMap<String, Integer> commentMap);
	public void insertComment(CommentDto comment);
	public int commentCount (HashMap<String, Integer> commentMap);
	public void replyComment(CommentDto comment);
	public void updateComment(HashMap<String, String> commentMap);
	public String getPath(int commentNum);
	public List<CommentDto> getAllComments(HashMap<String, Integer> commentMap);
	public void deleteComment(int commentNum);
}
