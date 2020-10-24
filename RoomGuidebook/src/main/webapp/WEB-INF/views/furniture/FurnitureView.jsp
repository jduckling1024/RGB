<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.util.*"%>
<%@ page import="dto.ProductDTO" %>
<%@ page import="dto.ImageDTO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<% ProductDTO product = (ProductDTO)request.getAttribute("product");
	ArrayList<ImageDTO> imageList = (ArrayList<ImageDTO>)request.getAttribute("image");

	pageContext.setAttribute("product", product);
	pageContext.setAttribute("mainImage", imageList.get(0));
	%> 
		
		<img alt="" src="${mainImage.path}" width="500px" height="500px">
		<br>
		<p>${product.name}</p>
		<p>${product.price}</p>
		<p>${product.info}</p>
		<p>${product.brand}</p>
		<p>${product.color}</p>
	<% 
	for(int i = 1; i < imageList.size(); i++){
		pageContext.setAttribute("image", imageList.get(i));
	%>
		<img alt="" src="${image.path}" width="300px" height="300px">
	<%
	}
	%>

</body>
</html>