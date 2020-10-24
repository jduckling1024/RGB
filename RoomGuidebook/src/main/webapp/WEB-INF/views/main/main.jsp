<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/resources/css/main.css">
</head>
<body>
	<div class="wrap">
		<div class="top">
			<div class="header">
				<p class="Title">
					<strong>RGB : Room Guide Book</strong>
				</p>
				<div class="menu">
					<ul>
						<li class="menu1"><a href="">Store</a>
						<li class="menu2"><a href="">Community</a>
						<li class="menu3"><a href="/login">Login</a>
						<li class="menu4"><a href="">Join</a></li>
					</ul>
				</div>
			</div>
		</div>

		<div class="middle"></div>
		<div class="container">
			<div class="leftSection">
				<p class="main_title">
					<strong>Today's BEST</strong>
				</p>
				<br>
				<div class="contentList">
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
						<a href="#"> <img class="image" src="${list.path}"
							width="200px" height="200px">
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