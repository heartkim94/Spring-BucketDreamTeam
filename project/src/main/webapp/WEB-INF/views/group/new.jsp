<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<body>
	<div id="wrapper">
		<%@ include file="../common/header.jsp" %>
		<section>
			<div class="container"></div>
				<form method="post" action="new.do" id="groupForm">
					
					<h3>그룹</h3>
					<hr>
					<input type="hidden" name="groupOwnerId" value="${id}">
					<label>이름: &nbsp;<input type="text" id="groupName" name="groupName"></label><br>
					<label>분류: &nbsp;
						<select name="catNum" form="groupForm">
							<c:forEach var="cat" items="${catList}">
								<option value="${cat.catNum}">
									<c:if test="${cat.parentNum!=0}">&nbsp;  </c:if>
									${cat.catName}
								</option>
							</c:forEach>
						</select>
					</label>
					<h3>목표</h3>
					<hr>
					bla bla
					<button>목표설정</button>
					<br><br>
					<input type="submit" value="만들기">
				</form>
			</div>
		</section>
		<%@ include file="../common/footer.jsp" %>
	</div> <!-- wrapper End -->
</body>
</html>