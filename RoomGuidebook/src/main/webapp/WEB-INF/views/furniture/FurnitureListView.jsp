<%@page import="dto.LikeDTO"%>
<%@page import="dto.BoardDTO"%>
<%@page import="dto.ImageDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="org.springframework.web.context.request.SessionScope"%>
<%@ page session="true"%>
<%@ page import="dto.ProductDTO"%>
<%@ page import="java.util.*"%>
<%@include file="../main/header.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<script>
	function submitBrand() {
		var brand = document.forms['brandForm'];
		var brandForm = document.brandForm;
		brand.product.value = "brand_" + brand.product.value;
		brandForm.action = "search?product";
		brandForm.method = "get";
		brandForm.submit();
	}

	function submitPrice() {
		var price = document.forms['priceInfoForm'];
		alert(price.min.value);
		alert(price.max.value);
		var range = document.forms['priceForm'];
		var target = document.priceForm;
		range.minToMax.value = "price_" + price.min.value + "~"
				+ price.max.value;
		target.action = "search?product";
		target.method = "get";
		target.submit();
	}
</script>

<title>스토어</title>
<link rel="stylesheet" href="/resources/css/FurnitureList.css">
</head>
<body>
	<div class="wrap">
		<%-- <div class="top">
			<div class="header">
				<p class="Title">
					<strong>RGB : Room Guide Book </strong>
				</p>

				<c:if test="${not empty sessionScope.member}">
					<div class="user_info">${sessionScope.member.name}님,환영합니다.</div>
				</c:if>
				<div class="menu">
					<ul>
						<li class="menu1"><a href="">Store</a>
						<li class="menu2"><a href="">Community</a>
						<li class="menu3"><a href="">Login</a>
						<li class="menu4"><a href="">Join</a></li>
					</ul>
				</div>
			</div>
		</div> --%>


		<div class="middle"></div>
		<div class="container">
			<form name="search" action="/search" method="post"></form>
			<div class="search">
				<form action="/search">
					<input type="search" style="display: inline-block;" name="product">
					<input class="searchButton" type="submit" value="검색"
						style="display: inline-block;">
				</form>
			</div>
			<br>
			<table>
				<tr>
					<td>카테고리</td>
					<td class="category">
						<ul>
							<li><a href="/search?product=category_소파침실" name="product"
								value="category_소파침실">소파 / 침실가구 </a></li>
							<li><a href="/search?product=category_드레스룸" name="product"
								value="category_드레스룸">드레스룸 </a></li>
							<li><a href="/search?product=category_학생서재가구" name="product"
								value="category_학생서재가구">학생 / 서재가구 </a></li>
							<li><a href="/search?product=category_수납가구" name="product"
								value="category_수납가구">수납가구 </a></li>
							<li><a href="/search?product=category_테이블의자" name="product"
								value="category_테이블의자">테이블 / 의자 </a></li>
							<li><a href="/search?product=category_주방가구" name="product"
								value="category_주방가구">주방가구</a></li>
						</ul>
					</td>
				</tr>
				<tr>
					<td>브랜드</td>
					<td class="category">
						<ul>
							<li><a href="/search?product=brand_이케아" name="product"
								value="brand_이케아">이케아 </a>
							<li><a href="/search?product=brand_한샘" name="product"
								value="brand_한샘">한샘 </a>
							<li><a href="/search?product=brand_마켓비" name="product"
								value="brand_마켓비">마켓비</a>
							<li><strong><p>직접입력</p></strong></li>
							<form name="brandForm">
								<li><input type="text" name="product">
								<li><input class="okButton" type="submit"
									onclick="submitBrand(this);" value="확인"></li>
							</form>

						</ul>
					</td>
				</tr>
				<tr>
					<td>가격</td>
					<td class="category">
						<ul>
							<li><a href="/search?product=price_0~50000">5만원 이하 </a></li>
							<li><a href="/search?product=price_50000~100000">5만원 ~
									10만원 </a></li>
							<li><a href="/search?product=price_100000~150000">10만원 ~
									15만원</a></li>
							<li><strong><p>직접입력</p></strong>
								<!-- <form name="priceInfoForm" style="display: inline-block"> -->
									<li><input type="text" name="min"></li>
									<li><p>~</p></li>
									<li><input type="text" name="max"></li>
									<li><input class="okButton" type="button"
										onclick="submitPrice()" value="확인"></li>
								<!-- </form> -->
								
								<form name="priceForm">
									<input type="hidden" name="minToMax">
								</form>
						</ul>
					</td>
				</tr>
				<tr>
					<td>색상</td>
					<td class="category">
						<ul>
							<li><a href="/search?product=color_red" title="빨간색"
								class="red">red</a>
							<li><a href="/search?product=color_orange" title="주황색"
								class="orange">orange</a>
							<li><a href="/search?product=color_yellow" title="노란색"
								class="yellow">yellow</a>
							<li><a href="/search?product=color_yellowGreen" title="연두색"
								class="yellow-green">yellow-green</a>
							<li><a href="/search?product=color_green" title="초록색"
								class="green">green</a>
							<li><a href="/search?product=color_skyBlue" title="하늘색"
								class="sky-blue">sky-blue</a>
							<li><a href="/search?product=color_navy" title="남색"
								class="navy">navy</a>
							<li><a href="/search?product=color_white" title="흰색"
								class="white">white</a>
							<li><a href="/search?product=color_gray" title="회색"
								class="gray">gray</a>
							<li><a href="/search?product=color_black" title="검은색"
								class="black">black</a></li>
						</ul>
					</td>
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
				
				<div class = "box">
					<a href="/getFurniture?id=${product.id}">
						
						<ul>
							<li><img class="image" src="${image.path}"></li>
							<li class="info">${product.name}</li>
							<li class="price">${product.price}</li>
							<li class = "likeIt">Like it: 15</li>
						</ul>
					</a>
				</div>

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