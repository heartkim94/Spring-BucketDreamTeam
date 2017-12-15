package com.pknu.project.group.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pknu.project.common.dto.ArticleDto;
import com.pknu.project.common.dto.BoardDto;
import com.pknu.project.common.service.BoardService;
import com.pknu.project.community.service.CommunityService;
import com.pknu.project.group.dto.GroupDto;
import com.pknu.project.group.dto.TodoDto;
import com.pknu.project.group.service.GroupService;

@Controller
public class GroupController {
	@Autowired
	private GroupService groupService;
	@Autowired
	private BoardService boardService;
	@Autowired
	private CommunityService communityService;
	
	
	@RequestMapping(value="/group/main", method=RequestMethod.GET)
	public String main(HttpSession session, Model model) {
		String id = (String)session.getAttribute("id");
		if(id==null) {
			return "redirect:/home";
		}
		groupService.getMyGroupList(id, model);
		groupService.getGroups(model);
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
	public String view(@PathVariable("groupNum") int groupNum,
						HttpSession session, Model model) {
		groupService.getGroup(groupNum, model);
		boardService.getBoards(groupNum, model);
		return "group/view";
	}
	
	@RequestMapping(value="/{groupNum}/deleteGroup")
	public String deleteGroup(int groupNum) {
		groupService.deleteGroup(groupNum);
		return "redirect:../group/main";
	}
	
	@RequestMapping(value="/{groupNum}/joinGroup")
	public String joinGroup(HttpSession session, int groupNum) {
		groupService.joinGroup(String.valueOf(session.getAttribute("id")), groupNum);
		return "redirect:../group/main";
	}
	
	@RequestMapping(value="/{groupNum}/leaveGroup")
	public String leaveGroup(HttpSession session, int groupNum) {
		groupService.leaveGroup(String.valueOf(session.getAttribute("id")), groupNum);
		return "redirect:../group/main";
	}
	
	@RequestMapping(value="/group/goalSettingForm", method=RequestMethod.GET)
	public String goalSetting() {
		return "group/goalSetting";
	}
	
	
	
	/* group board */
	@RequestMapping(value="/{groupNum}/list", method=RequestMethod.GET)
	public String list(
			@PathVariable("groupNum") int groupNum,
			@ModelAttribute("boardNum") int boardNum,
			@ModelAttribute("pageNum") int pageNum,
			String searchOption, String keyword, Model model) {
		groupService.getGroup(groupNum, model);
		boardService.getBoards(groupNum, model);
		if(keyword==null) {
			boardService.getArticles(groupNum, boardNum, pageNum, model);
		} else {
			boardService.getSearchedArticles(groupNum, boardNum, pageNum, searchOption, keyword, model);
		}
		return "group/list";
	}
	
	// 검색 기능 구현
	@RequestMapping(value="/{groupNum}/list", method=RequestMethod.POST)
	public String list(@PathVariable("groupNum") int groupNum,
					   @RequestParam(name="searchOption",defaultValue="title") String searchOption,
					   @RequestParam("keyword") String keyword,
					   @RequestParam("boardNum") int boardNum,
					   @RequestParam("pageNum") int pageNum,
					   Model model) {
		String view = "redirect:list?pageNum=1&boardNum="+boardNum;
		if(keyword!=null && !keyword.equals("")) {
			view += "&keyword="+keyword+"&searchOption="+searchOption;
		}
		return view;
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
	
	@RequestMapping(value="/{groupNum}/delete", method=RequestMethod.GET)
	public String deleteArticle(@PathVariable("groupNum") int groupNum,
								@RequestParam("articleNum") String articleNum,
						 		@RequestParam("boardNum") String boardNum,
						 		@RequestParam("pageNum") int pageNum,
						 		@RequestParam("fileStatus") int fileStatus, Model model) {
		boardService.deleteArticle(groupNum, articleNum, boardNum, fileStatus, model);
		return "redirect:list?pageNum="+pageNum+"&boardNum="+boardNum;
	}
	
	@RequestMapping(value="/{groupNum}/update", method=RequestMethod.GET)
	public String updateForm(@PathVariable("groupNum") int groupNum,
							 @ModelAttribute("articleNum") String articleNum,
							 @ModelAttribute("boardNum") String boardNum,
							 @ModelAttribute("pageNum") int pageNum,
							 @ModelAttribute("fileStatus") int fileStatus, Model model) {
		boardService.updateGetArticle(groupNum, articleNum, boardNum, fileStatus, model);
		model.addAttribute("action", "update");
		return "community/writeForm";
	}
	
	@RequestMapping(value="/{groupNum}/update", method=RequestMethod.POST)
	public String updateArticle(@PathVariable("groupNum") int groupNum,
								@ModelAttribute("boardNum") String boardNum,
								@ModelAttribute("pageNum") int pageNum,
								ArticleDto article, Model model) {
		article.setGroupNum(groupNum);
		boardService.updateArticle(article, boardNum, model);
		return "redirect:list";
	}
	
	@RequestMapping(value="/{groupNum}/reply", method=RequestMethod.GET)
	public String replyForm(HttpSession session, Model model,
			@PathVariable("groupNum") int groupNum,
			@ModelAttribute("boardNum") int boardNum,
			@ModelAttribute("groupId") int groupId, 
			@ModelAttribute("pos") int pos,
			@ModelAttribute("depth") int depth,
			@ModelAttribute("pageNum") int pageNum) {
		System.out.println("***replyForm***");
		model.addAttribute("action", "reply");
		return "community/writeForm";
	}
	
	@RequestMapping(value="/{groupNum}/reply", method=RequestMethod.POST)
	public String reply(ArticleDto article, HttpSession session){		
		article.setId((String)session.getAttribute("id"));
		boardService.reply(article);
		return "redirect:list?pageNum=1&boardNum="+article.getBoardNum();
	}
	
	/* todo setting */
	@RequestMapping(value="/{groupNum}/todoSetting", method=RequestMethod.GET)
	public String doSetting(@PathVariable("groupNum") int groupNum, Model model) {
		groupService.getGroup(groupNum, model);
		boardService.getBoards(groupNum, model);
		groupService.getTodoList(groupNum, model);
		return "group/todoSetting";
	}
	
	@RequestMapping(value="/{groupNum}/updateTodoList", method=RequestMethod.POST)
	@ResponseBody
	public String updateTodoList(
			@PathVariable("groupNum") int groupNum, HttpSession session,
			@RequestBody UpdateTodoList update) {
		if(!update.deleteList.isEmpty()) {
			groupService.deleteTodoList(update.deleteList);
		}
		String id = (String) session.getAttribute("id");
		groupService.updateTodoList(groupNum, id, update.todoList);
		return "success";
	}
	
	
	/* board setting */
	@RequestMapping(value="/{groupNum}/boardSetting", method=RequestMethod.GET)
	public String BoardSetting(Model model,
			@ModelAttribute @PathVariable("groupNum") int groupNum) {
		groupService.getGroup(groupNum, model);
		boardService.getBoards(groupNum, model);
		if(groupNum == -1) {
//			communityService.get
		}
		return "group/boardSetting";
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

class UpdateTodoList {
	public List<TodoDto> todoList;
	public List<Integer> deleteList;
}