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
	
	@RequestMapping(value="commentRead.do")
	public List<CommentDto> commentRead(@RequestParam int boardNum,
										@RequestParam int commentRow){
		return commentService.getComments(boardNum, commentRow);
	}
	
	@RequestMapping(value="commentWrite.do")
	@ResponseBody
	public HashMap<String, Object> commentWrite(CommentDto comment, 
															   HttpSession session){
		comment.setId((String)session.getAttribute("id"));
//		String content = comment.getCommentContent().replaceAll("\r\n","<br>");
//		comment.setCommentContent(content);
//		System.out.println("내용: "+content);
		commentService.insertComment(comment);
		commentList=commentService.getComments(comment.getBoardNum(), 10);
		HashMap<String, Object> hm = new HashMap<>();
		hm.put("result", 1);
		hm.put("commentList", commentList);
		return hm;		
	}
	
	@RequestMapping(value="commentUpdate.do")
	@ResponseBody
	public String commentUpdate(@RequestParam String commentContent) {
		return null;
	}
}
