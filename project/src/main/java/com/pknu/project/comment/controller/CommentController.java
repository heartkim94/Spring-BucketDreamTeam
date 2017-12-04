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
	
//	@RequestMapping(value="commentRead.do")
//	public List<CommentDto> commentRead(@RequestParam int articleNum,
//										@RequestParam int commentRow){
//		return commentService.getComments(articleNum, commentRow);
//	}
	
	@RequestMapping(value="commentWrite.do")
	@ResponseBody
	public HashMap<String, Object> commentWrite(CommentDto comment, 
															   HttpSession session){
		comment.setId((String)session.getAttribute("id"));
		commentService.insertComment(comment);
//		commentList=commentService.getComments(comment.getArticleNum(),10);
		HashMap<String, Object> hm = new HashMap<>();
		hm.put("result", 1);
		hm.put("commentList", commentList);
		return hm;		
	}
}
