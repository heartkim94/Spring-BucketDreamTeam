package com.pknu.project.group.service;

import org.springframework.ui.Model;

import com.pknu.project.common.dto.BoardDto;
import com.pknu.project.group.dto.GroupDto;

public interface GroupService {
	public void getMyGroup(String id, Model model);
	/* new */
	public void getCategory(Model model);
	public void newGroup(GroupDto group);
	/* view */
	public void getBoards(int groupNum, Model model);
	/* setting */
	public String renameBoard(BoardDto board);
	public int newBoard(String boardName, int groupNum);
	public String deleteBoard(int boardNum);
}
