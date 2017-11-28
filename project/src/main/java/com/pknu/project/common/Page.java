package com.pknu.project.common;

import javax.inject.Named;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

@Named
//@Qualifier("bbs")
public class Page {
	private int startRow, endRow;
	private StringBuffer sb;
	
	public synchronized void paging(int pageNum, int totalCount, int pageSize, int pageBlock){
		int totalPage = (int) Math.ceil((double)totalCount/pageSize);
		startRow = (pageNum - 1) * pageSize + 1;
		endRow = pageNum * pageSize;
		
		int startPage = (int)((pageNum-1)/pageBlock)*pageBlock + 1;
		int endPage = startPage + pageBlock - 1;
		
		if(endPage > totalPage) {
			endPage = totalPage;
		}
		
		sb = new StringBuffer();
		if(startPage < pageBlock) {
			sb.append("<img src='resources/img/left.jpg' width='30' height='9'>");
		} else {
			sb.append("<img src='resources/img/left.jpg' width='30' height='9'");
			sb.append(" onclick='location.href=\"noticeList.do?pageNum=");
			sb.append(startPage - pageBlock);
			sb.append("\"' style='cursor:pointer'>");
		}
		
		sb.append("&nbsp;&nbsp;|");
		for(int i = startPage; i <= endPage; i++) {
			if(i == pageNum) {
				sb.append("&nbsp;&nbsp;<b><font color='#91B7EF'>");
				sb.append(i);
				sb.append("</font></b>");
			} else {
				sb.append("&nbsp;&nbsp;<a href='noticeList.do?pageNum=");
				sb.append(i);
				sb.append("'>");
				sb.append(i);
				sb.append("</a>");
			}
		}
		
		sb.append("&nbsp;&nbsp;|");
		if(endPage < totalPage) {
			sb.append("<img src='resources/img/right.jpg' width='30' height='9'");
			sb.append(" onclick='location.href=\"noticeList.do?pageNum=");
			sb.append(startPage + pageBlock);
			sb.append("\"' style='cursor:pointer'> ");
		} else {
			sb.append("<img src='resources/img/right.jpg' width='30' height='9'>");
		}
	}
	
	public int getStartRow() {
		return startRow;
	}

	public int getEndRow() {
		return endRow;
	}

	public StringBuffer getSb() {
		return sb;
	}
}
