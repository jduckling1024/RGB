<%@page import="dto.CartDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="dto.ProductDTO" %>
<%@ page import="dto.ImageDTO" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>장바구니</title>
</head>
<body>
	<%
	ArrayList<Object[]> cartList = (ArrayList<Object[]>)request.getAttribute("cartList"); 
	
	for(int i = 0; i < cartList.size(); i++){
		CartDTO cart = (CartDTO)cartList.get(i)[0];
		ProductDTO product = (ProductDTO)cartList.get(i)[1];
		ImageDTO image = (ImageDTO)cartList.get(i)[2];
		
		pageContext.setAttribute("cart", cart);
		pageContext.setAttribute("product", product);
		pageContext.setAttribute("image", image);
	%>
	
	<img alt="" src="${image.path}" width="500px" height="500px">
	<!-- 크기 조절은 나중에 뷰 오면 합시다 -->
	<p>수량 : ${cart.count}</p>
	<p>${product.name}</p>
	<p>${product.price}</p>
	<p>${product.brand}</p>
	<p>${product.color}</p>
	<%
	}
	%>
</body>
</html>