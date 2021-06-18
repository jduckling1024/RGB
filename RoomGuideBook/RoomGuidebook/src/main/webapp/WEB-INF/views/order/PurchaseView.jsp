<%@page import="dto.MemberDTO"%>
<%@page import="dto.CartDTO"%>
<%@page import="dto.ProductDTO"%>
<%@page import="dto.ImageDTO"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@include file="../main/header.jsp"%>

<!--
Author: W3layouts
Author URL: http://w3layouts.com
License: Creative Commons Attribution 3.0 Unported
License URL: http://creativecommons.org/licenses/by/3.0/
-->
<!DOCTYPE HTML>
<html>

<head>
<title>RoomGuideBook_USER_PURCHASE</title>
<link href="/resources/css/style.css" rel='stylesheet' type='text/css' />
<link href="/resources/css/purchase.css" rel='stylesheet'
	type='text/css' />
<meta name="viewport" content="width=device-width, initial-scale=1">
<script type="application/x-javascript">
	 addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } 
</script>
</script>
<!----webfonts---->
<link
	href='http://fonts.googleapis.com/css?family=Open+Sans:400,300,600,700,800'
	rel='stylesheet' type='text/css'>
<!----//webfonts---->
<!----start-alert-scroller---->
<script src="/resources/js/jquery.min.js"></script>
<script type="text/javascript" src="/resources/js/jquery.easy-ticker.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$('#demo').hide();
		$('.vticker').easyTicker();
	});
</script>
<!----start-alert-scroller---->
<!-- start menu -->
<link href="/resources/css/megamenu.css" rel="stylesheet"
	type="text/css" media="all" />
<script type="text/javascript" src="/resources/js/megamenu.js"></script>
<script>
	$(document).ready(function() {
		$(".megamenu").megamenu();
	});
</script>
<script src="/resources/js/menu_jquery.js"></script>
<!-- //End menu -->
<!---slider---->
<link rel="stylesheet" href="/resources/css/slippry.css">
<script src="/resources/js/jquery-ui.js" type="text/javascript"></script>
<script src="/resources/js/scripts-f0e4e0c2.js" type="text/javascript"></script>
<script>
	jQuery('#jquery-demo').slippry({
		// general elements & wrapper
		slippryWrapper : '<div class="sy-box jquery-demo" />', // wrapper to wrap everything, including pager
		// options
		adaptiveHeight : false, // height of the sliders adapts to current slide
		useCSS : false, // true, false -> fallback to js if no browser support
		autoHover : false,
		transition : 'fade'
	});
</script>
<!---move-top-top---->
<script type="text/javascript" src="/resources/js/move-top.js"></script>
<script type="text/javascript" src="/resources/js/easing.js"></script>
<script type="text/javascript">
	jQuery(document).ready(function($) {
		$(".scroll").click(function(event) {
			event.preventDefault();
			$('html,body').animate({
				scrollTop : $(this.hash).offset().top
			}, 1200);
		});
	});
</script>
<script type="text/javascript">
	document.domain = "roomguidebook.cf";

	function goPopup() {
		var pop = window.open("addressPopup.jsp", "pop",
				"width=570,height=420, scrollbars=yes, resizable=yes");
	}
	
	function buy(){
		var address = document.getElementsByName("address")[0].value;
		var name = document.getElementsByName("name")[0].value;
		var email = document.getElementsByName("email")[0].value;
		var phoneNum = document.getElementsByName("phoneNum")[0].value;
		
		if(address != "" && name != "" && email != "" && phoneNum != ""){
			if(confirm("상품을 구입하시겠습니까?")){
				var payForm = document.payForm;
				payForm.action = "purchase";
				payForm.method = "post";
				payForm.submit();
			}
		}else{
			alert("필수 항목이 누락되었습니다.");
		}
	}

	function jusoCallBack(roadFullAddr, zipNo) {
		
		if (String(roadFullAddr).length > 50) {
			$("#address").attr("value", String(roadFullAddr));
			$("#address2").attr("value", String(roadFullAddr));
		} else
			$("#address").attr("value", String(roadFullAddr));
		
		$("#addressNum").attr("value", String(zipNo));
	}
</script>
<!---//move-top-top---->
</head>
<body>
	<!---start-wrap---->
	<!--- start-content---->
	<div class="content product-box-main">
		<div class="wrap">
			<form name="payForm">
				<%
					ArrayList<Object[]> furnitureList = (ArrayList<Object[]>) request.getAttribute("list");
				MemberDTO member = (MemberDTO) furnitureList.get(0)[0];
				pageContext.setAttribute("member", member);
				%>
				<div class="orderInfo">
					<h3>배송지</h3>
					<div class="deliveryAddress">
						<table id="table1">
							<%-- <tr>
                            <th>받는 분</th>
                            <td colspan="2">
                                <input type="text" id="name" class = "ip_text" name="${member.name}" value="${member.name}">
                            </td>
                        </tr> --%>
							<tr>
								<th>우편번호</th>
								<td><input type="text" id="addressNum" class="ip_text"></td>
								<td><button type="button" id="changeBtn"
										onClick="goPopup();">변경</button></td>
							</tr>
							<tr>
								<th rowspan="2">주소</th>
								<td colspan="2"><input type="text" id="address" name="address"
									class="ip_text" value="${member.address}"></td>
							</tr>
							<%-- <tr>
                            <td colspan="2"><input type="text" id="address2" class = "ip_text" value="${member.address}"></td>
                        </tr> --%>
							<%-- <tr>
                            <th>휴대전화</th>
                            <td colspan="2"><input type="text" id="phoneNum" class = "ip_text" value="${member.phoneNum}"></td>
                        </tr> --%>
						</table>
					</div>

					<Br>
					<hr>
					<Br>
					<h3>주문자</h3>
					<div class="orderer">
						<table id="table1">
							<tr>
								<th>이름</th>
								<td><input type="text" id="ordererName" class="ip_text"
									name="name" value="${member.name}"></td>
							</tr>
							<tr>
								<th>이메일</th>
								<td><input type="text" id="email" class="ip_text"
									name="email" value="${member.email}"></td>
							</tr>
							<tr>
								<th>휴대전화</th>
								<td><input type="text" id="ordererPhonenum" class="ip_text"
									name="phoneNum" value="${member.phoneNum}"></td>
							</tr>
						</table>
					</div>

					<Br>
					<hr>
					<Br>
					<h3>주문상품</h3>
					<%
						for (int i = 0; i < furnitureList.size(); i++) {
						CartDTO cart = null;
						if (furnitureList.get(i)[1] != null) {
							cart = (CartDTO) furnitureList.get(i)[1];
							pageContext.setAttribute("cart", cart);
						}

						ProductDTO product = (ProductDTO) furnitureList.get(i)[2];
						ImageDTO image = (ImageDTO) furnitureList.get(i)[3];

						pageContext.setAttribute("product", product);
						pageContext.setAttribute("image", image);
					%>
					<div class="orderItem">
					<input type="hidden" name="productId" value="${product.id}">
						<ul>
							<li><img class="itemImage" src="${image.path}"></li>
							<li><a>${product.name}<Br> 
							<% if(cart != null){ %> 
							<span> ${cart.amount} | ${product.price}</span> 
							<input type="hidden" name="amount" value="${cart.amount}">
							<% }else{ %> 
							<span> 1 | ${product.price}</span> 
							<input type="hidden" name="amount" value="1">
							<% }%>
							</a>
							</li>
						</ul>
					</div>
					<%
						}
					%>
					<Br>
					<hr>
					<Br>
					<h3>최종 결제 금액</h3>
					<div class="totalPrice">
						<table id="table3">
							<tr>
								<th>총 상품금액</th>
								<td>${productSum}</td>
							</tr>
							<tr>
								<th>배송비</th>
								<td>${delevaryFee}</td>
							</tr>
							<tr>
								<td colspan="2">${priceSum}</td>
							</tr>
						</table>
						<input type="hidden" name="productSum" value="${productSum}">
						<input type="hidden" name="delevaryFee" value="${delevaryFee}">
						<input type="hidden" name="priceSum" value="${priceSum}">
					</div>
				</div>
				<Br>
				<hr>
				<Br>
				<h3>결제수단</h3>
				<div class="pay">
					<ul>
						<li><input type='radio' name='paymentMethod' value='0' checked />카드</li>
						<li><input type='radio' name='paymentMethod' value='1' checked />무통장입금</li>
					</ul>
					<button class="completeBtn" type="button" onclick="buy();">결제하기</button>
				</div>
			</form>
		</div>


		<div class="clear"></div>
	</div>

	<!---- start-bottom-grids---->
	<div class="bottom-grids">

		<div class="bottom-bottom-grids"></div>
	</div>
	<!---- //End-bottom-grids---->
	<!--- //End-content---->
	<!---start-footer---->
	<div class="footer">
		<div class="wrap">
			<div class="footer-left">
				<ul>
					<li><a href="#">RoomGuideBook</a> <span> </span></li>
				</ul>
			</div>

			<div class="clear"></div>
		</div>
	</div>
	<!---//End-footer---->
	<!---//End-wrap---->
</body>

</html>