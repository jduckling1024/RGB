<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/resources/css/header.css">
</head>
<body>
	<div class="top">
		<div class="header">
			<p class="Title">
				<strong>RGB : Room Guide Book</strong>
			</p>

			<c:if test="${not empty sessionScope.member}">
				<div class="user_info"><a href="/getMember">${sessionScope.member.name}</a>님, 환영합니다.</div>
			</c:if>

			<div class="menu">
				<ul>
					<li class="menu1"><a href="/getFurnitureList">Store</a></li>
					<li class="menu2"><a href="/getBoardList">Community</a></li>
					<c:set var="session" value="${sessionScope.member}"></c:set>
					<c:choose>
						<c:when test="${not empty session}">
							<li class="menu3"><a href="/logout">Logout</a></li>
							<li class="menu4"><a href="/getCartList">Cart</a></li>
						</c:when>
						<c:otherwise>
							<li class="menu3"><a href="/login">Login</a></li>
							<li class="menu4"><a href="/registerMemberView">Join</a></li>
						</c:otherwise>
					</c:choose>
				</ul>
			</div>
		</div>
	</div>
</body>
</html>