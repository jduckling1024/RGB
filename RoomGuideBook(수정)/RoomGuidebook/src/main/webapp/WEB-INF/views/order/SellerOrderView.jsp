<%@page import="dto.PaymentDTO"%>
<%@page import="dto.OrderDTO"%>
<%@page import="dto.ProductDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 목록</title>
<link rel="stylesheet" href="/resources/css/sellerOrder.css">
</head>
<body id="page-top">
	<div id="adminSidenav" class="sidenav">
		<h3>
			<strong>상품 관리</strong>
		</h3>
		<a href="/getProductList">상품조회 및 수정</a> 
		<a href="/getRegisterProductForm">상품 등록</a>
		<h3>
			<strong>주문 관리</strong>
		</h3>
		<a href="/getListForSeller">주문조회</a>
	</div>

	<div id="content-wrapper" class="content">

		<div class="filterWrapper">
			<div id="functionName">
				<h2>주문 조회</h2>
			</div>

			<div class="filter">
				<table class="filterTable">
					<tr>
						<td class="menu">
							<h3>상세조건</h3>
						</td>
						<td class="category">
							<ul>
								<li>
									<form class="box">
										<select>
											<option>주문번호</option>
											<option>구매자ID</option>
											<option>상품ID</option>
										</select>
									</form>
								</li>
								<li><input type="text"></li>
								<li><input type="button" class="searchBtn" value="검색"></li>

							</ul>
						</td>
					</tr>

					<tr>
						<td class="menu">
							<h3>기간</h3>
						</td>
						<td class="category">
							<ul>
								<li>
									<form class="box">
										<select>
											<option>주문일</option>
											<option>결제일</option>
										</select>
									</form>
								</li>

								<li><input type="date" name="dateStart"></li>
								<li>
									<div class="text">
										<h2>
											<strong>~</strong>
										</h2>
									</div>
								</li>
								<li><input type="date" name="dateEnd"></li>
								<li><input type="button" class="searchBtn2" value="검색"></li>
							</ul>
						</td>
					</tr>
				</table>

			</div>
		</div>

		<Div class="buttonGroup">
			<ul>
				<li><input type="button" class="modifyBtn" value="수정"></li>
				<li><input type="button" class="deleteBtn" value="삭제"></li>
				<!-- 수정, 삭제는 요구사항에 있는 내용들이 아니었음 넣으면 그나마 검색정도 있어도 될 듯-->
			</ul>
			<br>
		</div>


		<div class="orderList">
			<table class="orderTable">
				<tr>
					<th>선택</th>
					<th>주문번호</th>
					<th>구매자ID</th>
					<th>상품 명</th>
					<th>수량</th>
					<th>결제예정금액</th>
					<th>결제금액</th>
					<th>주문상태</th>
					<th>주문일시</th>
				</tr>

				<tbody id="table2">
					<%
						List<Object[]> list = (ArrayList<Object[]>) request.getAttribute("list");

					for (int i = 0; i < list.size(); i++) {
						pageContext.setAttribute("product", (ProductDTO)list.get(i)[0]);
						pageContext.setAttribute("order", (OrderDTO)list.get(i)[1]);
						pageContext.setAttribute("payment", (PaymentDTO)list.get(i)[2]);
					%>
					<tr>
						<td><input type="checkbox" name="values"
							value="${order.orderId}"></td>
						<td>${order.orderId}</td>
						<td>${order.userId}</td>
						<td>${product.name}</td>
						<td>${order.amount}</td>
						<td>${payment.amountSum}</td>
						<td>${payment.paidAmount}</td>
						<td>${payment.progress}</td>
						<td>${order.purchaseDate}</td>
					</tr>
					<%
						}
					%>
				</tbody>
			</table>
		</div>
	</div>
</body>
</html>