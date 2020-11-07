<%@page import="org.springframework.web.context.request.SessionScope"%>
<%@page import="dto.CartDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="dto.ProductDTO"%>
<%@ page import="dto.ImageDTO"%>
<%@ page session="true"%>
<%@include file="../main/header.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니</title>
<link rel="stylesheet" href="/resources/css/cart.css">
<script type="text/javascript">
	var result = '${deleteCartResult}';

	if(result == "success"){
		alert("장바구니 내역 삭제를 완료하였습니다.");
	}else if(result == "fail"){
		alert("알 수 없는 오류로 인해 장바구니 삭제 처리를 실패했습니다.");	
	}
	
	function deleteCartList() {
		
		var list = document.getElementsByName("checked");
		var cnt = 0;
		for (var i = 0; i < list.length; i++) {
			if (list[i].checked) {
				cnt++;
			}
		} 
		
		if(cnt == 0){
			alert("선택한 상품이 없습니다.");
		}else{
			if(confirm("정말로 삭제하시겠습니까?")){
				var cartForm = document.cartForm;
				cartForm.action = "deleteCart";
				cartForm.method = "post";
				cartForm.submit();
			}
		}
	}
</script>
</head>
<body>

	<div class="wrap">
		<!-- <div class="top">
			<div class="header">
				<p class="Title">
					<strong>RGB : Room Guide Book </strong> 
				</p>
				<div class="menu">
					<ul>
						<li class="menu1"><a href="">Store</a>
						<li class="menu2"><a href="">Community</a>
						<li class="menu4"><a href="">Logout</a></li>
					</ul>
				</div>
			</div>
		</div>   -->

		<div class="middle"></div>
		<div class="container">
			<form name="cartForm">
				<div class="leftSection">
					<p class="main_title">
						<strong>주문내역</strong>
						<button type="button" class="deleteBtn"
							onclick="deleteCartList();">삭제</button>
					</p>
					<br>
					<div class="cartList">
						<%
							ArrayList<Object[]> cartList = (ArrayList<Object[]>) request.getAttribute("cartList");

						for (int i = 0; i < cartList.size(); i++) {
							CartDTO cart = (CartDTO) cartList.get(i)[0];
							ProductDTO product = (ProductDTO) cartList.get(i)[1];
							ImageDTO image = (ImageDTO) cartList.get(i)[2];

							pageContext.setAttribute("cart", cart);
							pageContext.setAttribute("product", product);
							pageContext.setAttribute("image", image);
						%>
						<div class="each">
							<img src="${image.path}" alt="" class="productImage"
								width="140px" height="140px">
							<div class="infoSection">
								<ul>
									<li class="list">
										<p>상품명</p>
									</li>
									<li class="list">
										<p>${product.name}</p>
									</li>
								</ul>
								<br>

								<ul>
									<li class="list">
										<p>개수</p>
									</li>
									<li class="list">
										<p>${cart.count}</p>
									</li>
								</ul>
								<br>

								<ul>
									<li class="list">
										<p>가격</p>
									<li class="list">
										<p>${product.price}</p>
									</li>
								</ul>
								<br>
								<div class="checkForDelete">
									<input type="checkbox" name="checked" value="${product.id}">
								</div>
							</div>
						</div>
						<%
							}
						%>
					</div>
				</div>


				<div class="rightSection">
					<div class="perchaseSection">
						<div class="priceInfo">
							<table>
								<tr>
									<td>총 상품금액 :</td>
									<td>${productSum}</td>
								</tr>
								<tr>
									<td>총 배송비 :</td>
									<td>${delevaryFee}</td>
								</tr>
								<tr>
									<td>결제금액 :</td>
									<td>${priceSum}</td>
								</tr>
							</table>
						</div>
						<br>
						<button type="button" class="btn_purchase" disabled>구매하기</button>
					</div>
				</div>
			</form>
		</div>

		<br>
		<div class="bottom"></div>

	</div>
</body>
</html>