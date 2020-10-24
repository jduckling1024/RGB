<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<p>${member.id}</p>
	<p>${member.name}</p>
	<p>${member.phoneNum}</p>
	<p>${member.address}</p>
	<p>${member.email}</p>
	<form action="/updateMemberView" method="post">
		<input type="hidden" name="id" value="${member.id}">
		<input type="hidden" name="name" value="${member.name}">
		<input type="hidden" name="phoneNum" value="${member.phoneNum}">
		<input type="hidden" name="address" value="${member.address}">
		<input type="hidden" name="email" value="${member.email}">
		<input type="submit" value = "회원정보 수정">
	</form>
	<form action = "/deleteMember" method="post">
		<input type="submit" value="회원 탈퇴">
	</form>
</body>
</html>