<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script>
</script>
</head>
<body>
	<footer>
		<div class="foot">
			<div>
				<c:forEach var="board" items="${communityBoardList}" varStatus="status">
					<a href="/project/community/list?pageNum=1&boardNum=${board.boardNum}">
						<strong>${board.boardName}</strong>
					</a><c:if test="${!status.last}">&nbsp;&nbsp;&nbsp;</c:if>
				</c:forEach>
			</div>
			<br>
			<div>
				<p class="text-center">
					<small><strong> 사거리</strong></small><br>
					<small>대표 : 홍길동 ㆍ 주소 :  사거리 ㆍ 사업자등록번호:123-12-12345 ㆍ 전화 : 064-123-1234</small><br>
					<small>Copyrightⓒ test.com All rights reserved.</small>
				</p>
			</div>
		</div>
	</footer>
</body>
</html>