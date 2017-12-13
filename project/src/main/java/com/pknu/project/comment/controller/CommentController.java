package com.pknu.project.comment.controller;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession; 

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pknu.project.comment.dto.CommentDto;
import com.pknu.project.comment.service.CommentService;
import com.pknu.project.common.dto.ArticleDto;

@Controller
public class CommentController {
	@Autowired
	CommentService commentService;
	
	int commentRow = 10;
	
	List<CommentDto> commentList = null;
	
	@RequestMapping(value="commentList")
	@ResponseBody
	public List<CommentDto> commentList(CommentDto comment){
		return commentService.getComments(comment.getBoardNum(), comment.getArticleNum(), commentRow);
	}
	
	@RequestMapping(value="commentRead")
	@ResponseBody
	public List<CommentDto> commentRead(CommentDto comment,
			@RequestParam("commentRow") int commentRow){
			return commentService.getComments(comment.getBoardNum(), comment.getArticleNum(), commentRow);
	}
	
	@RequestMapping(value="commentWrite")
	@ResponseBody
	public HashMap<String, Object> commentWrite(CommentDto comment, 
												HttpSession session) {
		comment.setId((String)session.getAttribute("id"));
		commentService.insertComment(comment);
		commentList=commentService.getComments(comment.getBoardNum(), comment.getArticleNum(), commentRow);
		HashMap<String, Object> hm = new HashMap<>();
		hm.put("result", 1);
		hm.put("commentList", commentList);
		return hm;		
	}
	
	@RequestMapping(value="replyComment")
	@ResponseBody
	public HashMap<String, Object> replyComment(CommentDto comment, HttpSession session) {
		comment.setId((String)session.getAttribute("id"));
		commentService.replyComment(comment);
		commentList=commentService.getComments(comment.getBoardNum(), comment.getArticleNum(), commentRow);
		HashMap<String, Object> hm = new HashMap<>();
		hm.put("result", 1);
		hm.put("commentList", commentList);
		return hm;
	}
	
	@RequestMapping(value="updateComment")
	@ResponseBody
	public List<CommentDto> updateComment(CommentDto comment,
											@RequestParam("commentNum") String commentNum,
											@RequestParam("commentContent") String commentContent) {
		commentService.updateComment(commentNum, commentContent);
		return commentService.getComments(comment.getBoardNum(), comment.getArticleNum(), commentRow);
	}
}
