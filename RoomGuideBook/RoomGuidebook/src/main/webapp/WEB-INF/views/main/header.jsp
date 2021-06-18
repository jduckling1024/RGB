<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="org.springframework.web.context.request.SessionScope"%>
<%@ page session="true"%>

<!DOCTYPE html>
<html>
<head>
<style>
ul {
	margin: 0;
}
</style>
<meta charset="UTF-8">
<title></title>
<link rel="stylesheet" href="/resources/css/style.css" type='text/css'>
</head>
<body>
	<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
	<!---start-header---->
	<div class="header">
		<div class="top-header">
			<div class="wrap">
				<div class="top-header-left">
					<ul>
						<!---cart-tonggle-script---->
						<script type="text/javascript">
                            $(function () {
                                var $cart = $('#cart');
                                $('#clickme').click(function (e) {
                                    e.stopPropagation();
                                    if ($cart.is(":hidden")) {
                                        $cart.slideDown("slow");
                                    } else {
                                        $cart.slideUp("slow");
                                    }
                                });
                                $(document.body).click(function () {
                                    if ($cart.not(":hidden")) {
                                        $cart.slideUp("slow");
                                    }
                                });
                            });
                        </script>
						<!---//cart-tonggle-script---->
						<li><a class="cart" href="/getCartList"><span id="clickme"> </span></a></li>
						<!---start-cart-bag---->
						<div id="cart">
							Your Cart is Empty <span>(0)</span>
						</div>
						<!---start-cart-bag---->
						<li><a class="info" href="#"><span> </span></a></li>
					</ul>
				</div>
				<div class="top-header-center">
					<div class="top-header-center-alert-left">
					</div>
					<div class="top-header-center-alert-right">
						<div class="vticker">
							<ul>
								<li>Welcome to RGB: Room Guide Book</li>
							</ul>
						</div>
					</div>
					<div class="clear"></div>
				</div>
				<div class="top-header-right">
					<ul>
					<c:set var="session" value="${sessionScope.member}"></c:set>
						<c:choose>
							<c:when test="${not empty session}">
								<li><a href="/getMember">Welcome to RGB, ${sessionScope.member.name}</a><span> </span></li>
								<li><a href="/logout">Logout</a></li>
							</c:when>
							<c:otherwise>
								<li><a href="/login">Login</a><span> </span></li>
								<li><a href="/registerMemberView">Join</a></li>
							</c:otherwise>
						</c:choose>
					</ul>
				</div>
				<div class="clear"></div>
			</div>
		</div>

		<!----start-mid-head---->
		<div class="mid-header">
			<div class="wrap">
				<div class="mid-grid-left">
					<form action="/search" method="get">
						<input type="text" name="product"
							placeholder="What Are You Looking for?" />
					</form>
				</div>
				<div class="mid-grid-right">
					<a class="logo" href="/main"><span>
					  <img src="/resources/others/logo.PNG" style="width: 8%; float: right">
					 </span></a>
				</div>
				<div class="clear"></div>
			</div>
		</div>
		<!----//End-mid-head---->

		<!----start-bottom-header---->
		<div class="header-bottom">
			<div class="wrap">
				<!-- start header menu -->
				<ul class="megamenu skyblue">
					<li class="grid"><a class="color2" href="/getFurnitureList">STORE</a>
						<div class="megapanel">
							<div class="row">
								<div class="col1">
									<div class="h_nav">
										<h4>거실가구</h4>
										<ul>
											<li><a href="/search?product=category_소파">소파</a></li>
											<li><a href="/search?product=category_거실수납장TV장">거실수납장/TV장</a></li>
											<br>
										</ul>
									</div>
									<div class="h_nav">
										<h4 class="top">학생/서재가구</h4>
										<ul>
											<li><a href="/search?product=category_책상">책상</a></li>
											<li><a href="/search?product=category_책장">책장</a></li>
											<br>
										</ul>
									</div>
								</div>

								<div class="col1">
									<div class="h_nav">
										<h4>침실가구</h4>
										<ul>
											<li><a href="/search?product=category_침대">침대</a></li>
											<li><a href="/search?product=category_화장대">화장대</a></li>
											<li><a href="/search?product=category_거울">거울</a></li>
										</ul>
									</div>
									<div class="h_nav">
										<h4 class="top">수납가구</h4>
										<ul>
											<li><a href="/search?product=category_수납장">수납장</a></li>
											<br>
											<br>
										</ul>
									</div>
								</div>

								<div class="col1">
									<div class="h_nav">
										<h4>드레스룸</h4>
										<ul>
											<li><a href="/search?product=category_옷장">옷장</a></li>
											<li><a href="/search?product=category_행거">행거</a></li>
											<br>
										</ul>
									</div>
									<div class="h_nav">
										<h4 class="top">테이블</h4>
										<ul>
											<li><a href="/search?product=category_좌식테이블">좌식테이블</a></li>
											<br>
											<br>
										</ul>
									</div>
								</div>
								<div class="col1">
									<div class="h_nav">
										<h4>주방가구</h4>
										<ul>
											<li><a href="/search?product=category_식탁">식탁</a></li>
											<li><a href="/search?product=category_주방수납">주방수납</a></li>
											<br>
										</ul>
									</div>
									<div class="h_nav">
										<h4 class="top">의자</h4>
										<ul>
											<li><a href="/search?product=category_일반의자">일반의자</a></li>
											<li><a href="/search?product=category_좌식의자">좌식의자</a></li>
											<li><a href="/search?product=category_스툴">스툴</a></li>
										</ul>
									</div>
								</div>


							</div>
						</div></li>
					<li class="active grid"><a class="color4" href="/getBoardList">COMMUNITY</a></li>

					<li><a class="color8" href="#">OTHER</a>
						<div class="megapanel">
							<div class="row">
								<div class="col1">
									<div class="h_nav">
										<h4>회원관리</h4>
										<ul>
											<li><a href="/getMember">회원정보 조회</a></li>
										</ul>
									</div>
								</div>
							</div>
						</div></li>
					</ul>
			</div>
		</div>
	</div>
</body>
</html>