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

<script type="text/javascript">
	//Make the DIV element draggagle:
	dragElement(document.getElementById("mydiv"));

	function dragElement(elmnt) {
		var pos1 = 0, pos2 = 0, pos3 = 0, pos4 = 0;
		if (document.getElementById(elmnt.id + "header")) {
			/* if present, the header is where you move the DIV from:*/
			document.getElementById(elmnt.id + "header").onmousedown = dragMouseDown;
		} else {
			/* otherwise, move the DIV from anywhere inside the DIV:*/
			elmnt.onmousedown = dragMouseDown;
		}

		function dragMouseDown(e) {
			e = e || window.event;
			e.preventDefault();
			// get the mouse cursor position at startup:
			pos3 = e.clientX;
			pos4 = e.clientY;
			document.onmouseup = closeDragElement;
			// call a function whenever the cursor moves:
			document.onmousemove = elementDrag;
		}

		function elementDrag(e) {
			e = e || window.event;
			e.preventDefault();
			// calculate the new cursor position:
			pos1 = pos3 - e.clientX;
			pos2 = pos4 - e.clientY;
			pos3 = e.clientX;
			pos4 = e.clientY;
			// set the element's new position:
			elmnt.style.top = (elmnt.offsetTop - pos2) + "px";
			elmnt.style.left = (elmnt.offsetLeft - pos1) + "px";
		}

		function closeDragElement() {
			/* stop moving when mouse button is released:*/
			document.onmouseup = null;
			document.onmousemove = null;
			alert(elmnt.style.left);
		}
	}
</script>
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
					<li><a>방 정보 : ${productInfo.width} × ${productInfo.length}
							× ${productInfo.height} (cm)</a></li>
					<br>

					<br>
					<div class="arrangedImage" style="overflow: auto">
						<c:forEach var="list" items="${imageList}">
							<div class="imageClass">
								<img src="${list.path}" width="200px">
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