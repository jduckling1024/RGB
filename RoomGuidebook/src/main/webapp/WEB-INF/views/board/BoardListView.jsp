<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>

	<c:forEach var="list" items="${boardList}">
		<a href = "/getBoard?no=${list.boardId}"><c:out value="${list.boardId} ${list.memberId} ${list.title}"/></a>
	</c:forEach>

	<form>
	
	</form>
</body>
</html>