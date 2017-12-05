package com.pknu.project.comment.dto;

public class CommentDto {
	private int commentNum;
	private String id;
	private String commentContent;
	private String commentDate;
	private int articleNum;
	private int boardNum;
	
	public int getCommentNum() {
		return commentNum;
	}
	public void setCommentNum(int commentNum) {
		this.commentNum = commentNum;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getCommentContent() {
		return commentContent;
	}
	public void setCommentContent(String commentContent) {
		this.commentContent = commentContent;
	}
	public String getCommentDate() {
		return commentDate;
	}
	public void setCommentDate(String commentDate) {
		this.commentDate = commentDate;
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
	@Override
	public String toString() {
		return "CommentDto [commentNum=" + commentNum + ", id=" + id + ", commentContent=" + commentContent
				+ ", commentDate=" + commentDate + ", articleNum=" + articleNum + ", boardNum=" + boardNum + "]";
	}
	
}
