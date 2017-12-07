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

@Controller
public class CommentController {
	@Autowired
	CommentService commentService;
	
	List<CommentDto> commentList = null;
	
	@RequestMapping(value="commentList")
	@ResponseBody
	public List<CommentDto> commentList(CommentDto comment){
		return commentService.getComments(comment.getBoardNum(), comment.getArticleNum(), 10);
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
															   HttpSession session){
		comment.setId((String)session.getAttribute("id"));
		commentService.insertComment(comment);
		commentList=commentService.getComments(comment.getBoardNum(), comment.getArticleNum(), 10);
		HashMap<String, Object> hm = new HashMap<>();
		hm.put("result", 1);
		hm.put("commentList", commentList);
		return hm;		
	}
	
	@RequestMapping(value="replyComment")
	@ResponseBody
	public String replyComment() {
		return null;
	}
	
	@RequestMapping(value="updateComment")
	@ResponseBody
	public String commentUpdate(@RequestParam String commentContent) {
		return null;
	}
	
	@RequestMapping(value="deleteComment")
	@ResponseBody
	public String deleteComment() {
		return null;
	}
}
