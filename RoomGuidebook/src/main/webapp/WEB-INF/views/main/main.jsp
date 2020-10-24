<%@page import="org.springframework.web.context.request.SessionScope"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="true"%>
<%@ page import="dto.UserDTO"%>
<html>
<head>
<title>Home</title>
</head>
<body>
	<h1>Hello world!</h1>

	<form action="/logout">
		<button type="submit">로그아웃</button>
		<!-- 로그인, 로그아웃 버튼 바뀌는건 javascript로 가능 -->
	</form>

	<form action="/getMember" method="post">
		<button type="submit">회원정보 조회</button>
	</form>
	
	<!-- 게시판 목록으로 가는 것도 만들자 -->
	
	<form action="/getCartList" method="post">
		<button type="submit">장바구니 조회</button>
	</form>
	<!-- 일단 임시로 두었다. -->

	<c:out value="${sessionScope.member.name}" />
</body>

<script>

</script>
</html>
