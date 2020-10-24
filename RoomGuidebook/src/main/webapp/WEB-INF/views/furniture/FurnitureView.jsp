<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.util.*"%>
<%@ page import="dto.ProductDTO"%>
<%@ page import="dto.ImageDTO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>가구 상세</title>
<link rel="stylesheet" href="/resources/css/Furniture.css">
</head>
<body>

	<% ProductDTO product = (ProductDTO)request.getAttribute("product");
   ArrayList<ImageDTO> imageList = (ArrayList<ImageDTO>)request.getAttribute("image");

   pageContext.setAttribute("product", product);
   pageContext.setAttribute("mainImage", imageList.get(0));
   %>

	<div class="wrap">
		<div class="top">
			<div class="header">
				<p class="Title">
					<strong>RGB : Room Guide Book</strong>
				</p>

				<div class="menu">
					<ul>
						<li class="menu1"><a href="">Store</a></li>
						<li class="menu2"><a href="">Community</a></li>
						<li class="menu4"><a href="">Logout</a></li>
					</ul>
				</div>
			</div>
		</div>

		<div class="middle"></div>
		<div class="container">
			<div class="leftSection">
				<img class="sample" src="${mainImage.path}" width="450px"
					height="450px">

			</div>

			<div class="rightSection">
				<ul>
					<li>${product.name}</li>
					<li>${product.price}</li>
					<br>

					<hr>
					<br>
					<table>
						<tr>
							<td>${product.brand}/</td>
							<td>${product.stock}/</td>
							<td>Item Price</td>
						</tr>
					</table>
					<br>
					<hr>
					<br>
					<br>
					<p>========== total Price ==========</p>
					<br>
					<br>
					<hr>
				</ul>
				<br>
				<div class="buttonGroup">
					<button>Buy Now</button>
					<button>Add Cart</button>
					<button>Arrange</button>
				</div>
			</div>
		</div>
		<hr>

		<div class="info">
			<br> <br>
			<p>
				<strong>${product.info}</strong>
			</p>
			<% 
   for(int i = 1; i < imageList.size(); i++){
      pageContext.setAttribute("image", imageList.get(i));
   %>
			<img alt="" src="${image.path}" width="300px" height="300px">
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