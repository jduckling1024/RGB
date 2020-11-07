<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="org.springframework.web.context.request.SessionScope"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../main/header.jsp"%> 

<%@ page session="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가구 배치하기</title>
<link rel="stylesheet" href="/resources/css/arrange.css">
</head>
<body>
	<div class="wrap">
		<!-- <div class="top">
			<div class="header">
				<p class="Title">
					<strong>RGB : Room Guide Book</strong>
				</p>

				<div class="menu">
					<ul>
						<li class="menu1"><a href="">Store</a>
						<li class="menu2"><a href="">Community</a>
						<li class="menu4"><a href="">Logout</a></li>
					</ul>
				</div>
			</div>
		</div> -->

		<div class="middle"></div>
		<div class="container">
			<div class="leftSection">
				<img class="sample" src="${myRoomPath}" width="550px" height="450px">
				<!-- 이미지 비율 받아서 이쪽으로 넘기는 것도 필요하겠다 -->
			</div>

			<div class="rightSection">
				<ul>
					<li class=buttonBack><button type="button" class="btn_back"
							onclick="history.back(-1)">돌아가기</button> <br> <br>
					<li><a>모델명 : ${productName}</a>
					<li><a>방 정보 : ${productInfo.width} × ${productInfo.length} × ${productInfo.height} (cm)</a></li>
					<br>
					
					<br>
					<div class="arrangedImage" style="overflow: auto">
						<c:forEach var="list" items="${imageList}">
							<div class="imageClass">
								<img src="${list.path}" width = "200px">
							</div>
						</c:forEach>
					</div>
					<br>
					

					<br>
			</div>
		</div>
		<hr>

		<div class="bottom">
			<br>
		</div>

	</div>
</body>
</html>