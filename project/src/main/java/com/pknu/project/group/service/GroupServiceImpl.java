package com.pknu.project.group.service;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

import com.pknu.project.common.dao.BoardDao;
import com.pknu.project.common.dto.FileDto;
import com.pknu.project.common.service.BoardService;
import com.pknu.project.common.utils.UploadFileUtils;
import com.pknu.project.group.dao.GroupDao;
import com.pknu.project.group.dto.GroupDto;
import com.pknu.project.group.dto.TodoDto;

@Service
public class GroupServiceImpl implements GroupService {
	@Autowired
	private GroupDao groupDao;
	@Autowired
	private BoardDao boardDao;
	@Autowired
	private BoardService boardService;
	@Resource(name="saveDir")
	String saveDir;
	
	private GroupDto group;
	private HashMap<String, String> paramMap;
	
	@Override
	public void getMyGroupList(String id, Model model) {
		model.addAttribute("myGroupList", groupDao.getMyGroupList(id));
	}

	@Override
	public void getGroups(Model model) {
		model.addAttribute("groupList", groupDao.getGroups());
	}

	@Override
	public GroupDto getGroup(int groupNum, Model model) {
		group = groupDao.getGroup(groupNum);
		List<String> memberList = groupDao.memberList(groupNum);
		model.addAttribute("group", group);
		model.addAttribute("memberList", memberList);
		return group;
	}
	
	@Override
	public void deleteGroup(int groupNum) {
		groupDao.deleteGroup(groupNum);
	}
	
	@Override
	public void joinGroup(String id, int groupNum) {
		HashMap<String, Object> paramMap = new HashMap<>();
		paramMap.put("id", id);
		paramMap.put("groupNum", String.valueOf(groupNum));
		groupDao.joinGroup(paramMap);
	}

	@Override
	public void leaveGroup(String id, int groupNum) {
		paramMap = new HashMap<>();
		paramMap.put("id", id);
		paramMap.put("groupNum", String.valueOf(groupNum));
		groupDao.leaveGroup(paramMap);
	}
	
	/* new */
	@Override
	public void getCategory(Model model) {
		model.addAttribute("catList", groupDao.getCategory());
	}

	@Override
	public void newGroup(GroupDto group, MultipartFile profileImg) {
		System.out.println("Grservice - newGroup 실행됨");
		groupDao.newGroup(group);
		paramMap = new HashMap<>();
		paramMap.put("groupNum", String.valueOf(group.getGroupNum()));
		boardDao.createGroupBoard(paramMap);
		boardService.newBoard("Board", group.getGroupNum());
		
		FileDto fileDto = new FileDto();
		if(profileImg != null) {
			System.out.println("Gservice - profileImg null아님");
			System.out.println("사이즈 : " + profileImg.getSize());
			long fileSize = profileImg.getSize();
			if(fileSize > 0 && fileSize < 204800) {
				System.out.println("Gservice - profileImg 사이즈 적당함");
				try {
					System.out.println("망할 getbyte 시작");
					String storedFile = UploadFileUtils.uploadProfileImg(saveDir, profileImg.getOriginalFilename(), profileImg.getBytes());
					System.out.println("Gservice - storedFile 완료");
					fileDto = new FileDto();
					fileDto.setGroupNum(group.getGroupNum());
					fileDto.setStoredFname(storedFile);
					groupDao.insertProfileImg(fileDto);
				} catch (Exception e) {
					System.out.println("@@@Gservice - catch@@@");
					e.printStackTrace();
				}
			} else {
				System.out.println("profileImg not null - 이미지 입력 안 됨");
				fileDto = new FileDto();
				fileDto.setGroupNum(group.getGroupNum());
				fileDto.setStoredFname("/GroupProfileImg/profileImg_default.jpg");
				groupDao.setDefaultProfile(fileDto);
			}
		} else {
			System.out.println("profileImg null - 이미지 입력 안 됨");
			fileDto = new FileDto();
			fileDto.setGroupNum(group.getGroupNum());
			fileDto.setStoredFname("/GroupProfileImg/profileImg_default.jpg");
			groupDao.setDefaultProfile(fileDto);
		}
	}
	
	
	/* todo */
	@Override
	public List<TodoDto> getTodoList(int groupNum, Model model) {
		List<TodoDto> todoList = groupDao.getTodoList(groupNum);
		if(model != null) {
			model.addAttribute("todoList", todoList);
		}
		return todoList;
	}
	
	@Override
	public String updateTodoList(int groupNum, String userId, List<TodoDto> todoList) {
		HashMap<String, Object> paramMap = new HashMap<>();
		paramMap.put("groupNum", groupNum);
		paramMap.put("id", userId);
		paramMap.put("todoList", todoList);
		groupDao.updateTodoList(paramMap);
		return "success";
	}
	
	@Override
	public String deleteTodoList(List<Integer> deleteList) {
		groupDao.deleteTodoList(deleteList);
		return "success";
	}
}
