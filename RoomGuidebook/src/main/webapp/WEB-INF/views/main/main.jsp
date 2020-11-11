<%@page import="org.springframework.web.context.request.SessionScope"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true"%>
<%@include file="header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Room Guide Book</title>
<link rel="stylesheet" href="/resources/css/main.css">
<script type="text/javascript">
	var result = '${result}';

	if (result == "loginSucceeded") {
		alert('${sessionScope.member.name}' + "님, 환영합니다.");
	} else if (result == "logout") {
		alert("로그아웃이 정상적으로 처리되었습니다.");
	} else if (result == "registerMemberSucceeded") {
		alert("회원가입이 완료되었습니다.");
	} else if (result == "registerMemberFailed") {
		alert("회원가입 중 알 수 없는 오류가 발생했습니다.");
	} else if (result == "needLogin") {
		if (confirm("로그인이 필요한 작업입니다. 로그인 페이지로 이동하시겠습니까?")) {
			window.location.href = "http://localhost:8080/login";
		}
	} else if (result == "updateMemberSucceeded") {
		alert("회원정보 수정이 완료되었습니다.");
	} else if (result == "deleteMemberSucceed") {
		alert("회원 탈퇴가 완료되었습니다. 그동안 RGB를 이용해주셔서 감사합니다.")
	}
</script>
</head>
<body>
	<div class="wrap">
		<%-- 		<div class="top">
			<div class="header">
				<p class="Title">
					<strong>RGB : Room Guide Book</strong>
				</p>

				<c:if test="${not empty sessionScope.member}">
					<div class="user_info">${sessionScope.member.name}님,환영합니다.</div>
				</c:if>

				<div class="menu">
					<ul>
						<li class="menu1"><a href="/getFurnitureList">Store</a></li>
						<li class = "menu2"><a href="#">Community</a></li>
						<c:set
								var="session" value="${sessionScope.member}"></c:set> <c:choose>
								<c:when test="${not empty session}">
									<li class="menu3"><a href="/logout">Logout</a></li>
									<li class="menu4"><a href="/getCartList">Cart</a></li>
								</c:when>
								<c:otherwise>
									<li class="menu3"><a href="/login">Login</a>
									<li class="menu4"><a href="/registerMemberView">Join</a></li>
								</c:otherwise>
							</c:choose>
					</ul>
				</div>
			</div>
		</div>
 --%>
		<div class="middle"></div>
		<div class="container">
			<div class="leftSection">
				<p class="main_title">
					<strong>Today's BEST</strong>
				</p>
				<br>
				<div class="contentList">
					<!-- a태그 해서 게시물 아이디 추가하기 -->
					<c:forEach var="list" items="${boardImageList}" varStatus="status">
						<img class="image" src="${list.path}" width="200px" height="200px">
						<c:if test="${status.index eq 1}" var="nameHong" scope="session">
							<br>
						</c:if>
					</c:forEach>
				</div>
			</div>
			<div class="rightSection">
				<div class="fMenu">
					<ul>
						<li class="fmenu"><a href="">소파/침실가구</a>
						<li class="fmenu"><a href="">드레스룸</a>
						<li class="fmenu"><a href="">주방가구</a>
						<li class="fmenu"><a href="">학생/서재가구</a>
						<li class="fmenu"><a href="">수납가구</a>
						<li class="fmenu"><a href="">테이블/의자</a></li>
					</ul>
				</div>
				<br>
				<div class="main_title">
					<p>
						<strong>BEST가구</strong>
					</p>
				</div>
				<br>
				<div class="furnitureList">
					<c:forEach var="list" items="${productImageList}"
						varStatus="status">
						<a href="/getFurniture?id=${list.divisionId}"
							value="${list.divisionId}"> <img class="image"
							src="${list.path}" width="200px" height="200px">
						</a>
						<c:if test="${status.index eq 1}" var="nameHong" scope="session">
							<br>
						</c:if>

					</c:forEach>
				</div>

			</div>
		</div>

		<div class="bottom">
			<br>
		</div>
	</div>

</body>
</html>