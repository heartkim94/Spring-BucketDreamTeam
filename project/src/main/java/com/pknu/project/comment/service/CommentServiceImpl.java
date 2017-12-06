package com.pknu.project.comment.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pknu.project.comment.dao.CommentDao;
import com.pknu.project.comment.dto.CommentDto;
import com.pknu.project.common.dao.BoardDao;

@Service
public class CommentServiceImpl implements CommentService {
	@Autowired
	CommentDao commentDao;

	@Override
	public List<CommentDto> getComments(int boardNum, int articleNum, int commentRow) {
		HashMap<String, Integer> commentMap = new HashMap<>();
		commentMap.put("boardNum", boardNum);
		commentMap.put("articleNum", articleNum);
		commentMap.put("commentRow", commentRow);
		return commentDao.getComments(commentMap);
	}

	@Override
	public void insertComment(CommentDto comment) {
		commentDao.insertComment(comment);
		//boardDao.insertComment(comment);
	}

	@Override
	public int commentCount(int boardNum, int articleNum) {
		HashMap<String, Integer> commentMap = new HashMap<>();
		commentMap.put("boardNum", boardNum);
		commentMap.put("articleNum", articleNum);
		return commentDao.commentCount(commentMap);
	}
	
	
	
}
