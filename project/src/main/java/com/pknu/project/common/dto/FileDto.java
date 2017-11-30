package com.pknu.project.common.dto;

public class FileDto {
	private int fileNum;
	private String storedFname;
	private int fileLength;
	private int articleNum;
	private int boardNum;
	private int groupNum;
	
	public int getFileNum() {
		return fileNum;
	}
	public void setFileNum(int fileNum) {
		this.fileNum = fileNum;
	}
	public String getStoredFname() {
		return storedFname;
	}
	public void setStoredFname(String storedFname) {
		this.storedFname = storedFname;
	}
	public int getFileLength() {
		return fileLength;
	}
	public void setFileLength(int fileLength) {
		this.fileLength = fileLength;
	}
	public int getArticleNum() {
		return articleNum;
	}
	public void setArticleNum(int articleNum) {
		this.articleNum = articleNum;
	}
	public int getBoardNum() {
		return boardNum;
	}
	public void setBoardNum(int boardNum) {
		this.boardNum = boardNum;
	}
	public int getGroupNum() {
		return groupNum;
	}
	public void setGroupNum(int groupNum) {
		this.groupNum = groupNum;
	}
	@Override
	public String toString() {
		return "FileDto [fileNum=" + fileNum + ", storedFname=" + storedFname + ", fileLength=" + fileLength
				+ ", articleNum=" + articleNum + ", boardNum=" + boardNum + "]";
	}
	
}
