<%@page import="dto.MemberDTO"%>
<%@page import="dto.CartDTO"%>
<%@page import="dto.ProductDTO"%>
<%@page import="dto.ImageDTO"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 구매</title>
<link rel="stylesheet" href="/resources/css/memberOrder.css">
</head>
<body>
	<div class="wrap">
		<div class="top">
			<div class="header">
				<p class="Title">
					<strong><p class="Title">RGB : Room Guide Book</p></strong>
			</div>
		</div>

		<div class="middle"></div>
		<%ArrayList<Object[]> furnitureList = (ArrayList<Object[]>) request.getAttribute("list"); 
		MemberDTO member = (MemberDTO)furnitureList.get(0)[0];
		pageContext.setAttribute("member", member);
		%>

		<div class="orderInfo">
			<h3>배송지</h3>
			<div class="deliveryAddress">
				<table id="table1">
					<tr>
						<th>받는 분</th>
						<td colspan="2"><input type="text" id="name" class="ip_text"
							name="${member.name}" value="${member.name}"></td>
					</tr>
					<tr>
						<th>우편번호</th>
						<td><input type="text" id="addressNum" class="ip_text"></td>
						<td><button type="button" id="changeBtn">변경</button></td>
					</tr>
					<tr>
						<th rowspan="2">주소</th>
						<td colspan="2"><input type="text" id="address"
							class="ip_text"></td>
					</tr>
					<tr>
						<td colspan="2"><input type="text" id="address2"
							class="ip_text" value="${member.address}"></td>
					</tr>
					<tr>
						<th>휴대전화</th>
						<td colspan="2"><input type="text" id="phoneNum"
							class="ip_text" value="${member.phoneNum}"></td>
					</tr>
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
							value="${member.name}"></td>
					</tr>
					<tr>
						<th>이메일</th>
						<td><input type="text" id="email" class="ip_text"
							value="${member.email}"></td>
					</tr>
					<tr>
						<th>휴대전화</th>
						<td><input type="text" id="ordererPhonenum" class="ip_text"
							value="${member.phoneNum}"></td>
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
						if(furnitureList.get(i)[1] != null){
							cart = (CartDTO) furnitureList.get(i)[1];
							pageContext.setAttribute("cart", cart);
						}
						
						ProductDTO product = (ProductDTO) furnitureList.get(i)[2];
						ImageDTO image = (ImageDTO) furnitureList.get(i)[3];
						
						pageContext.setAttribute("product", product);
						pageContext.setAttribute("image", image);
						
						%>
							
			<div class="orderItem">
				<Table id="table2">
					<tr>
						<th rowspan="2"><img class="itemImage" src="${image.path}"></th>
						<td>${product.name}</td>
					</tr>
					<tr>
					<% if(cart != null){%>
						<td> ${cart.count} | ${product.price}</td>
					<%}else{%>
						<td> 1 | ${product.price}</td>
					<%}%>
						
					</tr>
				</Table>
			</div>
				<%}%>
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
			</div>

			<Br>
			<hr>
			<Br>
			<h3>결제수단</h3>
			<div class="pay">
				<ul>
					<li><input type='radio' name='pay' value='card' checked />카드</li>
					<li><input type='radio' name='pay' value='deposit' checked />무통장입금</li>
				</ul>
				<button class="completeBtn" type="submit">결제하기</button>
			</div>
		</div>

		<div class="bottom"></div>

	</div>
</body>
</html>