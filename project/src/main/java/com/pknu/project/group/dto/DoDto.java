package com.pknu.project.group.dto;

import java.sql.Timestamp;

public class DoDto {
	private int doNum;
	private String doName;
	private Timestamp doWhen;
	private Timestamp doEnd;
	private boolean done;
	private int parentNum;
	private String path;
	private int pos;
	private int depth;
	private int groupNum;
	private int userNum;
	
	public int getDoNum() {
		return doNum;
	}
	public void setDoNum(int doNum) {
		this.doNum = doNum;
	}
	public String getDoName() {
		return doName;
	}
	public void setDoName(String doName) {
		this.doName = doName;
	}
	public Timestamp getDoWhen() {
		return doWhen;
	}
	public void setDoWhen(Timestamp doWhen) {
		this.doWhen = doWhen;
	}
	public Timestamp getDoEnd() {
		return doEnd;
	}
	public void setDoEnd(Timestamp doEnd) {
		this.doEnd = doEnd;
	}
	public boolean isDone() {
		return done;
	}
	public void setDone(boolean done) {
		this.done = done;
	}
	public int getParentNum() {
		return parentNum;
	}
	public void setParentNum(int parentNum) {
		this.parentNum = parentNum;
	}
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}
	public int getPos() {
		return pos;
	}
	public void setPos(int pos) {
		this.pos = pos;
	}
	public int getDepth() {
		return depth;
	}
	public void setDepth(int depth) {
		this.depth = depth;
	}
	public int getGroupNum() {
		return groupNum;
	}
	public void setGroupNum(int groupNum) {
		this.groupNum = groupNum;
	}
	public int getUserNum() {
		return userNum;
	}
	public void setUserNum(int userNum) {
		this.userNum = userNum;
	}
}
