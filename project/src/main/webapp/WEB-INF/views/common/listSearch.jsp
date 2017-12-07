<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE>
<html>
<head>
<meta charset="utf-8">
<title>공지사항</title>
<style>
	
</style>
</head>
<body>
	<form name="searchForm" method="post" action="list">
        <select name="searchOption">
            <option value="title">제목</option>
            <option value="content">내용</option>
            <option value="id">이름</option>
        </select>
		<input type="hidden" name="boardNum" value="${boardNum}">
		<input type="hidden" name="pageNum" value="${pageNum}">
        <input name="keyword" value="${searchMap.keyword}">
        <input type="submit" value="검색">
    </form>
</body>
</html>