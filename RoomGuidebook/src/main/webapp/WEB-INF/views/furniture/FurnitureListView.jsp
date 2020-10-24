<%@page import="dto.ImageDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="dto.ProductDTO"%>
<%@ page import="java.util.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>스토어</title>
<link rel="stylesheet" href="/resources/css/FurnitureList.css">
</head>
<body>
	<div class="wrap">
		<div class="top">
			<div class="header">
				<p class="Title">
					<strong>RGB : Room Guide Book 
				</p>
				</strong>
				<div class="menu">
					<ul>
						<li class="menu1"><a href="">Store</a>
						<li class="menu2"><a href="">Community</a>
						<li class="menu3"><a href="">Login</a>
						<li class="menu4"><a href="">Join</a></li>
					</ul>
				</div>
			</div>
		</div>


		<div class="middle"></div>
		<div class="container">

			<div class="text">
				<ul>
					<li>category1
					<li>>
					<li>category2</li>
				</ul>
			</div>
			<br> <br>
			<table>
				<tr>
					<td>카테고리</td>
					<td class="category">
						<ul>
							<li a href="">소파 / 침실가구 </a>
							<li a href="">드레스룸 </a>
							<li a href="">학생 / 서재가구 </a>
							<li a href="">수납가구 </a>
							<li a href="">테이블 / 의자 </a> <lia href="">주방가구</a></li>
						</ul>
					</td>
				</tr>
				<tr>
					<td>브랜드</td>
					<td class="category">
						<ul>
							<li a href="">이케아 </a>
							<li a href="">한샘 </a>
							<li a href="">마켓비</a>
							<li a>직접입력</a></li>


						</ul>
					</td>
				</tr>
				<tr>
					<td>가격</td>
					<td class="category">
						<ul>
							<li a href="">5만원 이하 </a>
							<li a href="">5만원 ~ 10만원 </a>
							<li a href="">10만원 ~ 15만원</a>
							<li a>직접입력</a></li>
						</ul>
					</td>
				</tr>
				<tr>
					<td>색상</td>
					<td class="category"><a>직접입력</a></td>
				</tr>
			</table>


			<br> <br>
			<div class="pList">
				<%
					ArrayList<Object[]> list = (ArrayList<Object[]>) request.getAttribute("list");

				for (int i = 0; i < list.size(); i++) {
					pageContext.setAttribute("product", (ProductDTO) list.get(i)[0]);
					pageContext.setAttribute("image", (ImageDTO) list.get(i)[1]);
				%>
				<a href="/getFurniture?id=${product.id}">
					<ul>
						<li><img class="image" src="${image.path}"></li>
						<li class="info">${product.name}</li>
						<li class="price">${product.price}</li>
					</ul>
				</a>

				<%
					if (i % 3 == 2) {
				%>
				<br>
				<%
					}
				%>

				<%
					}
				%>

			</div>
			<br>
		</div>

		<br>

		<div class="bottom"></div>

	</div>
</body>
</html>