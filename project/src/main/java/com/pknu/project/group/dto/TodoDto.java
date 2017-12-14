package com.pknu.project.group.dto;

public class TodoDto {
	private int doNum;
	private String doName;
	private String doWhen;
	private String doWhenTime;
	private String doEnd;
	private String doEndTime;
	private boolean doAllDay;
	private String color;
	private boolean done;
	private String memo;
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
	public String getDoWhen() {
		return doWhen;
	}
	public void setDoWhen(String doWhen) {
		this.doWhen = doWhen;
	}
	public String getDoWhenTime() {
		return doWhenTime;
	}
	public void setDoWhenTime(String doWhenTime) {
		this.doWhenTime = doWhenTime;
	}
	public String getDoEnd() {
		return doEnd;
	}
	public void setDoEnd(String doEnd) {
		this.doEnd = doEnd;
	}
	public String getDoEndTime() {
		return doEndTime;
	}
	public void setDoEndTime(String doEndTime) {
		this.doEndTime = doEndTime;
	}
	public boolean isDoAllDay() {
		return doAllDay;
	}
	public void setDoAllDay(boolean doAllDay) {
		this.doAllDay = doAllDay;
	}
	public String getColor() {
		return color;
	}
	public void setColor(String color) {
		this.color = color;
	}
	public boolean isDone() {
		return done;
	}
	public void setDone(boolean done) {
		this.done = done;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
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
