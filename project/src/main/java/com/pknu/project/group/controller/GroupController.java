package com.pknu.project.group.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pknu.project.common.dto.ArticleDto;
import com.pknu.project.common.dto.BoardDto;
import com.pknu.project.common.service.BoardService;
import com.pknu.project.group.dto.GroupDto;
import com.pknu.project.group.service.GroupService;

@Controller
public class GroupController {
	@Autowired
	private GroupService groupService;
	@Autowired
	private BoardService boardService;
	
	@RequestMapping(value="/group/main", method=RequestMethod.GET)
	public String main(HttpSession session, Model model) {
		String id = (String)session.getAttribute("id");
		if(id==null) {
			return "redirect:/home";
		}
		groupService.getMyGroup(id, model);
		return "group/main";
	}
	
	@RequestMapping(value="/group/new", method=RequestMethod.GET)
	public String newGroupForm(Model model) {
		groupService.getCategory(model);
		return "group/new";
	}
	
	@RequestMapping(value="/group/new", method=RequestMethod.POST)
	public String newGroup(GroupDto group) {
		groupService.newGroup(group);
		return "redirect:main";
	}
	
	@RequestMapping(value="/{groupNum}/view", method=RequestMethod.GET)
	public String view(@PathVariable("groupNum") int groupNum, Model model) {
		groupService.getGroup(groupNum, model);
		boardService.getBoards(groupNum, model);
		return "group/view";
	}
	
	/* group board */
	@RequestMapping(value="/{groupNum}/list", method=RequestMethod.GET)
	public String list(
			@PathVariable("groupNum") int groupNum,
			@ModelAttribute("boardNum") int boardNum,
			@ModelAttribute("pageNum") int pageNum, Model model) {
		groupService.getGroup(groupNum, model);
		boardService.getBoards(groupNum, model);
		boardService.getArticles(groupNum, boardNum, pageNum, model);
		return "group/list";
	}
	
	@RequestMapping(value="/{groupNum}/content", method=RequestMethod.GET)
	public String content(
			@PathVariable("groupNum") int groupNum,
			@ModelAttribute("boardNum") String boardNum,
			@RequestParam("articleNum") String articleNum,
			@ModelAttribute("pageNum") String pageNum,
			@RequestParam("fileStatus") int fileStatus,
			Model model, HttpSession session){
		groupService.getGroup(groupNum, model);
		boardService.getBoards(groupNum, model);
		boardService.getArticle(groupNum, boardNum, articleNum, fileStatus, model);
		return "group/content";
	}
	
	@RequestMapping(value="/{groupNum}/write", method=RequestMethod.GET)
	public String writeForm(HttpSession session,
			@PathVariable("groupNum") int groupNum,
			@ModelAttribute("boardNum") int boardNum, Model model){
		groupService.getGroup(groupNum, model);
		boardService.getBoards(groupNum, model);
		return "group/writeForm";
	}
	
	@RequestMapping(value="/{groupNum}/write", method=RequestMethod.POST)
	public String write(
			@PathVariable("groupNum") int groupNum,
			ArticleDto article, HttpSession session, Model model){
		groupService.getGroup(groupNum, model);
		boardService.writeArticle(article);
		return "redirect:list?pageNum=1&boardNum="+article.getBoardNum();
	}
	
	@RequestMapping(value="/{groupNum}/setting", method=RequestMethod.GET)
	public String setting(@PathVariable("groupNum") int groupNum, Model model) {
		groupService.getGroup(groupNum, model);
		boardService.getBoards(groupNum, model);
		return "group/setting";
	}
	
	@RequestMapping(value="/{groupNum}/renameBoard", method=RequestMethod.POST)
	@ResponseBody
	public String renameBoard(
			@PathVariable("groupNum") String groupNum,
			BoardDto board) {
		boardService.renameBoard(board);
		return "success";
	}
	
	@RequestMapping(value="/{groupNum}/newBoard", method=RequestMethod.POST)
	@ResponseBody
	public int newBoard(@PathVariable("groupNum") int groupNum, String boardName) {
		return boardService.newBoard(boardName, groupNum);
	}
	
	@RequestMapping(value="/{groupNum}/deleteBoard", method=RequestMethod.POST)
	@ResponseBody
	public String deleteBoard(int boardNum) {
		return boardService.deleteBoard(boardNum);
	}
	
	@RequestMapping(value="/{groupNum}/deleteGroup", method=RequestMethod.POST)
	public void deleteGroup(int groupNum) {
		groupService.deleteGroup(groupNum);
	}
	
	/* chatroom */
	@RequestMapping(value="/{groupNum}/chatrooms", method=RequestMethod.GET)
	public String chatroomList(@PathVariable("groupNum") int groupNum, Model model) {
		model.addAttribute("groupNum", groupNum);
		return "chat/chatrooms";
	}
	
	@RequestMapping(value="/{groupNum}/chat", method=RequestMethod.GET)
	public String chat(
			@ModelAttribute @PathVariable("groupNum") int groupNum,
			@ModelAttribute("roomNum") int roomNum) {
		return "chat/chat";
	}
}