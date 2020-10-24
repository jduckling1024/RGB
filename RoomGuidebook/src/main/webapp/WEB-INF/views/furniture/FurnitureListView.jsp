<%@page import="dto.ImageDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="dto.ProductDTO"%>
<%@ page import="java.util.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>

	<!-- 개인적으로 가구 색상도 코드로 넣는게 더 좋을 것 같다는 생각입니다. -->
	
	
	<%
		ArrayList<Object[]> list = (ArrayList<Object[]>) request.getAttribute("list");
	
		for (int i = 0; i < list.size(); i++) {
		pageContext.setAttribute("product", (ProductDTO) list.get(i)[0]);
		pageContext.setAttribute("image", (ImageDTO) list.get(i)[1]);
	%>

	<a href="/getFurniture?id=${product.id}"> <img alt=""
		src="${image.path}" width="300px" height="300px"> ${image.path}
		${product.name} ${product.price} ${product.brand}
	</a>
	<br>
	<%
		}
	%>


	<img src="/resources/image/image1.JPG" alt="" width="300px"
		height="300px">

</body>
</html>