<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="dto.ProductDTO"%>
<%@ page import="dto.ImageDTO"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="org.springframework.web.context.request.SessionScope"%>
<%@ page session="true"%>
<%@include file="../main/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가구 상세</title>
<link rel="stylesheet" href="/resources/css/Furniture.css">
</head>

<script>
	var result = '${registerCartResult}';
	if(result == "success"){
		if(confirm("장바구니에 담았습니다. 장바구니로 이동하시겠습니까?")){
			window.location.href="http://localhost:8080/getCartList";
		}
	}else if(result == "fail"){
		alert("해당 작업을 다시 시도해주시기 바랍니다.");
	}

	function openPopup() {
		//        productId = document.getElementById("productId");
		//        productName = document.getElementById("productName");
		//        console.log(productId.value);
		//        console.log(productName.value);
		//        window.open("/insertArrangeInfo, "배치정보입력", "width=450,height=500","resizable=no");

		//    	productId = document.getElementById("productId");
		//        productName = document.getElementById("productName");

		var title = "input";

		window.open("", title, "width=450,height=500", "resizable=no");

		var productInfo = document.productInfo;
		productInfo.target = title;
		productInfo.action = "insertArrangeInfo";
		productInfo.method = "post";
		productInfo.submit();
	}
	
	function addCart(){
		var myId = document.getElementsByName("memberId")[0].value;
		
		if(myId == "" || myId == null || myId == undefined || ( myId != null && typeof myId == "object" && !Object.keys(myId).length())){
			alert("로그인이 필요한 요청입니다.");
		}else{
			var cartForm = document.cartForm;
			cartForm.action = "registerCart";
			cartForm.method = "post";
			cartForm.submit();
		}
	}
	
</script>

<body>
	
	<c:set var="myId" value="${sessionScope.member.id}"></c:set>
	<%
		ProductDTO product = (ProductDTO) request.getAttribute("product");
	ArrayList<ImageDTO> imageList = (ArrayList<ImageDTO>) request.getAttribute("image");

	pageContext.setAttribute("product", product);
	pageContext.setAttribute("mainImage", imageList.get(0));
	%>

	<div class="wrap">
		<%-- <div class="top">
			<div class="header">
				<p class="Title">
					<strong>RGB : Room Guide Book</strong>
				</p>

				<c:if test="${not empty sessionScope.member}">
					<div class="user_info">${sessionScope.member.name}님,환영합니다.</div>
				</c:if>
				<div class="menu">
					<ul>
						<li class="menu1"><a href="">Store</a></li>
						<li class="menu2"><a href="">Community</a></li>
						<li class="menu4"><a href="">Logout</a></li>
					</ul>
				</div>
			</div>
		</div> --%>

		<div class="middle"></div>
		<div class="container">
			<div class="leftSection">
				<img class="sample" src="${mainImage.path}" width="450px"
					height="450px">
			</div>

			<div class="rightSection">
				<ul>
					<li><h1>${product.name}</h1></li>
					<br>
					<li><h3>${product.price}원</h3></li>
					<br>

					<hr>
					<br>
					<table>
						<tr>
							<td>Brand : ${product.brand}</td>
							<td>/</td>
							<td>Stock : ${product.stock}</td>
						</tr>
					</table>
					<br>
					<hr>
					<br>
					<br>
					<p>Size : ${product.width} × ${product.length} ×
						${product.height} (cm)</p>
					<p>${product.info}</p>
					<br>
					<br>
					<hr>
				</ul>
				<br>
				<div class="buttonGroup">
					<button class="buttons" type = "submit">Buy Now</button>
					<form name="cartForm"> <!-- action = "/registerCart" method="post" -->
						<input type="hidden" name="memberId" value="${sessionScope.member.id}">
						<input type="hidden" name="productId" value="${product.id}">
						<input type="hidden" name="count" value="1"> <!-- 일단 이렇게 하는데 개수 정하는 뷰 있으면 그걸로 대체해야지 ㅋ -->
					</form>
					<button onclick="addCart();" class="buttons">Add Cart</button>
					<button onclick="openPopup();" class="buttons">Arrange</button>
					<form name="productInfo">
						<input type="hidden" id="productId" name="productId"
							value="${product.id}" /> <input type="hidden" id="productName"
							name="productName" value="${product.name}" />
					</form>
				</div>
			</div>
		</div>
		<hr>

		<div class="info" style="text-align: center">
			<br> <br>
			<p>
				<b2>====== Product Information ======</b2>
			</p>
			<br> <br>
			<%
				for (int i = 1; i < imageList.size(); i++) {
				pageContext.setAttribute("image", imageList.get(i));
			%>
			<img alt="" src="${image.path}"> <br>
			<%
				}
			%>
		</div>

		<br> <br>
		<div class="bottom">
			<br>
		</div>

	</div>
</body>
</html>