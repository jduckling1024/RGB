<%@page import="dto.ProductDTO"%>
<%@page import="dto.ImageDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.util.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 조회</title>
<link rel="stylesheet" href="/resources/css/product.css">


<script>
	var result = '${result}';

	if(result == "loginSucceeded"){
		alert('${sessionScope.seller.name}' + "님, 환영합니다.");
	}
	
	var ProductDeleteResult = '${ProductDeleteResult}';
	if(ProductDeleteResult == "success"){
		alert("상품 삭제를 완료하였습니다.");
	}else if(ProductDeleteResult == "fail"){
		alert("알 수 없는 오류가 발생했습니다.");
	}
</script>
</head>

<script type="text/javascript">
	function deleteList() {
 		<% List<Integer> checkedList = new ArrayList(); %>
		var list = document.getElementsByName("values");
		var cnt = 0;
		for (var i = 0; i < list.length; i++) {
			if (list[i].checked) {
				cnt++;
			}
		} 
		
		if(cnt == 0){
			alert("선택된 항목이 없습니다.");
		}else{
			var productInfo = document.productInfo;
			productInfo.action = "deleteProduct";
			productInfo.method = "post";
			productInfo.submit();
		}
	}
	
	function searchProduct(){
		var productId = document.getElementsByName("id")[0].value;
		var productName = document.getElementsByName("name")[0].value;
		
		if(productId != "" && productName != ""){
			alert("상품 명 또는 상품 번호 중 하나만 입력해주세요.");
		}else{
			if(productId == ""){
				document.getElementsByName("id")[0].value = "-1";
			}
			var productForm = document.productForm;
			productForm.action = "searchProduct";
			productForm.method = "post";
			productForm.submit();
		}
	}
</script>

<body id="page-top">

	<div id="adminSidenav" class="sidenav">
		<p class="seller">${sessionScope.seller.name}님,환영합니다.</p>
		<h3>
			<strong>상품 관리</strong>
		</h3>
		<a href="/getProductList">상품조회 및 수정</a> <a href="/getRegisterProductForm">상품 등록</a>
		<h3>
			<stong>주문 관리</stong>
		</h3>
		<a href="#">주문조회</a>
	</div>

	<div id="content-wrapper" class="content">

		<div class="filterWrapper">
			<div id="functionName">
				<h2>상품 조회 및 수정</h2>
			</div>

			<div class="filter">
				<form name="productForm">
					<table class="filterTable">
						<tr>
							<td class="menu">
								<h3>카테고리</h3>
							</td>
							<td class="category">
								<ul>
									<li><select name="parentCategory">
											<option value="300">상위 카테고리</option>
											<option value="301">소파</option>
											<option value="302">침실가구</option>
											<option value="303">드레스룸</option>
											<option value="304">학생/서재가구</option>
											<option value="305">수납가구</option>
											<option value="306">테이블</option>
											<option value="307">의자</option>
											<option value="308">주방가구</option>
									</select></li>

									<li><select name="childCategory">
											<option value="400">하위 카테고리</option>
											<option value="401">일반소파</option>
											<option value="402">좌식소파</option>
											<option value="403">침대</option>
											<option value="404">화장대</option>
											<option value="405">거울</option>
											<option value="406">옷장</option>
											<option value="407">식탁</option>
											<option value="408">주방수납</option>
											<option value="409">책상</option>
											<option value="410">책장</option>
											<option value="411">수납장</option>
											<option value="412">좌식테이블</option>
											<option value="413">일반의자</option>
											<option value="414">흔들의자</option>
											<option value="415">좌식의자</option>
									</select></li>
								</ul>
							</td>
						</tr>

						<tr>
							<td class="menu">
								<h3>상품명</h3>
							</td>
							<td class="category"><input type="text" name="name"></td>
						</tr>

						<tr>
							<td class="menu">
								<h3>상품번호</h3>
							</td>
							<td class="category"><input type="text" name="id"></td>
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
												<option>상품등록일</option>
												<option>A</option>
												<option>B</option>
												<option>C</option>
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
									<li><input type="button" class="searchBtn" value="검색"
										onclick="searchProduct();"></li>
								</ul>
							</td>
						</tr>
					</table>
				</form>
			</div>
		</div>

		<Div class="buttonGroup">
			<ul>
				<li><input type="button" class="modifyBtn" value="수정"></li>
				<li><input type="button" class="deleteBtn" value="삭제"
					onclick="deleteList();"></li>
			</ul>
			<br>
		</div>


		<div class="productList">
			<form name="productInfo">
				<table class="producTable">

					<tr>
						<th>선택</th>
						<th>이미지</th>
						<th>상위 카테고리</th>
						<th>하위 카테고리</th>
						<th>상품ID</th>
						<th>상품명</th>
						<th>재고</th>
						<th>상품등록일</th>
					</tr>
					<tbody id="table1">
						<%
							ArrayList<Object[]> list = (ArrayList<Object[]>) request.getAttribute("list");
						for (int i = 0; i < list.size(); i++) {
							ImageDTO image = (ImageDTO) list.get(i)[0];
							ProductDTO product = (ProductDTO) list.get(i)[1];
							pageContext.setAttribute("image", image);
							pageContext.setAttribute("product", product);
						%>
						<tr>
							<td><input type="checkbox" name="values"
								value="${product.id}"></td>
							<td><img alt="" src="${image.path}" width="100px"
								height="100px"></td>
							<td>${product.parentCategory}</td>
							<td>${product.childCategory}</td>
							<td>${product.id}</td>
							<td>${product.name}</td>
							<td>${product.stock}</td>
							<td>${product.registrationDate}</td>
						</tr>
						<%
							}
						%>

					</tbody>
				</table>
			</form>
		</div>
	</div>
</body>
</html>