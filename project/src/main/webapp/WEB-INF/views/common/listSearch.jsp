<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE>
<html>
<head>
<meta charset="utf-8">
<title>공지사항</title>
<style>
	.searchBar {
		position: relative;
	    background: #a9a9a9;
	    text-align: center;
	    padding: 4px 0;
	    border-radius: 3px;
	    margin-bottom: 2%;
	}
	.searchBar select {
	    width: 15%;
	    height: 30px;
	    line-height: 200%;
	}
	.searchBar input[name="keyword"] {
		width: 30%;
		min-height: 30px;
	}
	.searchBar input[type="submit"] {
		width: 60px;
		height: 30px;
		border: 0;
	    background: #666;
	    color: #fff;
	    font-weight: 700;
	    font-size: 14px;
	    cursor: pointer;
	    border-radius: 4px;
	}
	.searchBar input[type="submit"]:hover {
		 background: #444;
		 transition: .2s background ease-in-out; 
	}
	.searchBar label {
	    color: #ddd;
    	font-weight: bold;
   	 	margin-right: 2%;
   	 	cursor: pointer;
	}
	
	@media (max-width: 560px) {
		.searchBar label {
			display: none;
		}
		.searchBar select {
		    width: 20%;
		}
		.searchBar input[name="keyword"] {
			width: 50%;
		}
	}
	
</style>
</head>
<body>
	<div class="searchBar">
	
		<form name="searchForm" method="post" action="list">
			<label for="keyword">검색</label>
	        <select name="searchOption">
	            <option value="title">제목</option>
	            <option value="content">내용</option>
	            <option value="id">이름</option>
	        </select>
			<input type="hidden" name="boardNum" value="${boardNum}">
			<input type="hidden" name="pageNum" value="${pageNum}">
	        <input name="keyword" value="${searchMap.keyword}" id="keyword">
	        <input type="submit" value="검색">
	    </form>
    </div>
</body>
</html>