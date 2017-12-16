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
			<div class="container">
				<div class="makeGroup">
					<form method="post" action="new" id="groupForm">
						<h3>그룹</h3>
						<hr>
						<input type="hidden" name="groupOwnerId" value="${id}">
						<div class="inputGroupName">
							<label class="nameLabel" for="groupName">이름: </label>
							<input type="text" id="groupName" name="groupName" placeholder="group이름 입력" />
						</div>
						<div class="kind">
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
						</div>
						<h3>목표</h3>
						<hr>
						<a href="javascript:void(window.open('/project/group/goalSettingForm', '_blank','width=450, height=300'))">목표 설정</a>
						<!--menubar, status, resizable, titlebar, location, top, left -->
						<br><br>
						<input type="submit" value="만들기">
					</form>
				</div>
			</div>
		</section>
		<%@ include file="../common/footer.jsp" %>
	</div> <!-- wrapper End -->
</body>
<style>
	.makeGroup {
		padding: 100px 0;
	}
	.nameLabel {
		overflow: hidden;
	    position: absolute;
	    height: 1px;
	    width: 1px;
	}
	.inputGroupName{
		width: 100%;
		height: 50px;
		margin-bottom: 20px;
	}
	input#groupName {
	    position: relative;
	    width: 100%;
	    height: 100%;
	    border: none;
	    padding: 0;
	    background: 0 0;
	    line-height: 54px;
	    border-bottom: 1px solid #ccc;
	    font-size: 30px;
	    font-weight: 400;
	    color: #333;
	}
	.kind {
		border: 1px solid red;
	}
</style>
</html>