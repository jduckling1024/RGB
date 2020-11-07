<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Product</title>
<link rel="stylesheet" href="/resources/css/productRegister.css">


<script>
        function setThumbnail1(event) {
			var container1 = document.getElementById("image_container1");
            while(container1.hasChildNodes()){
                container1.removeChild(container1.firstChild);
            }
            
            for (var image of event.target.files) {
                var reader = new FileReader();
                reader.onload = function (event) {
                    var img = document.createElement("img");
                    img.setAttribute("src", event.target.result);
                    img.setAttribute("height", "250px");
                    img.setAttribute("width", "20%");
                    img.style.marginLeft = "2.5%";
                    img.style.marginRight = "2.5%";
                    document.querySelector("div#image_container1").appendChild(img);
                };
                console.log(image);
                reader.readAsDataURL(image);
            }
        }
    
        function setThumbnail2(event) {
			var container2 = document.getElementById("image_container2");
            while(container2.hasChildNodes()){
                container2.removeChild(container2.firstChild);
            }
            
            for (var image of event.target.files) {
                var reader = new FileReader();
                reader.onload = function (event) {
                    var img = document.createElement("img");
                    img.setAttribute("src", event.target.result);
                    img.setAttribute("src", event.target.result);
                    img.setAttribute("height", "250px");
                    img.setAttribute("width", "20%");
                    img.style.marginLeft = "2.5%";
                    img.style.marginRight = "2.5%";
                    document.querySelector("div#image_container2").appendChild(img);
                };
                console.log(image);
                reader.readAsDataURL(image);
            }
        }
        
       	function registerProduct(){	
       		var name = document.getElementsByName("name")[0].value;
            var price = document.getElementsByName("price")[0].value;
            var stock = document.getElementsByName("stock")[0].value;
            var width = document.getElementsByName("width")[0].value;
            var length = document.getElementsByName("length")[0].value;
            var height = document.getElementsByName("height")[0].value;

            if (name == '' || price == '' || stock == '' || width == '' || length == '' || height == '') {
                alert("필수 항목이 누락되었습니다.");
            } else {
                var registerProductInfo = document.registerProductInfo;

                registerProductInfo.action = "registerProduct";
                registerProductInfo.enctype = "multipart/form-data";
                registerProductInfo.method = "post";
                registerProductInfo.submit();
            }
       	}
    
    </script>
</head>

<body id="page-top">

	<div id="adminSidenav" class="sidenav">
		<h3>
			<strong>상품 관리</strong>
		</h3>
		<a href="#">상품조회 및 수정</a> <a href="#">상품 등록</a>
		<h3>
			<stong>주문 관리</stong>
		</h3>
		<a href="#">주문조회</a>
	</div>

	<form name="registerProductInfo">
		<!-- action="/registerProduct"  method="post"
		enctype="multipart/form-data" -->
		<div id="content-wrapper" class="content">
			<div class="infoWrapper">
				<div id="functionName">
					<h2>상품 등록</h2>
				</div>

				<div class="filter">
					<table class="productInfo">
						<tr>
							<td class="menu">
								<h3>카테고리</h3>
							</td>
							<td class="category">
								<ul>
									<li>
										<form class="box">
											<select>
												<option>상위 카테고리</option>
												<option>침실가구</option>
												<option>거실가구</option>
												<option>수납가구</option>
												<option>서재/사무용 가구</option>
											</select>
										</form>
									</li>

									<li>
										<form class="box">
											<select>
												<option>하위 카테고리</option>
												<option>A</option>
												<option>B</option>
												<option>C</option>
											</select>
										</form>
									</li>
								</ul>
							</td>

							<td class="menu">
								<h3>상품번호</h3> <!-- 일단 보류 -->
							</td>
							<td colspan="3" class="category"><input id="productId"
								type="text"></td>
						</tr>

						<tr>
							<td class="menu">
								<h3>상품 명</h3>
							</td>
							<td class="category"><input id="productName" type="text"
								name="name"></td>
							<td class="menu">
								<h3>판매가</h3>
							</td>
							<td class="category"><input id="price" type="text"
								name="price"></td>

							<td class="menu">
								<h3>재고수량</h3>
							</td>
							<td class="category"><input id="count" type="text"
								name="stock"></td>
						</tr>

						<tr>
							<td class="menu">
								<h3>제품크기</h3>
							</td>
							<td colspan="2" class="category">
								<ul>
									<li>
										<h3>가로</h3>
									</li>
									<li><input id="num1" type="text" name="width"></li>
									<li>
										<h3>cm</h3>
									</li>

									<li>
										<h3>세로</h3>
									</li>
									<li><input id="num2" type="text" name="length"></li>
									<li>
										<h3>cm</h3>
									</li>

									<li>
										<h3>높이</h3>
									</li>
									<li><input id="num3" type="text" name="height"></li>
									<li>
										<h3>cm</h3>
									</li>
								</ul>
							</td>

							<td colspan="2" class="category">
								<ul>
									<li><input type="button" class="insertBtn" value="등록"
										onclick="registerProduct();"></li>
									<li><input type="button" class="cancelBtn" value="취소"></li>
								</ul>
							</td>
						</tr>
					</table>
				</div>

			</div>


			<div class="uploadImage">
				<div class="productImage">
					<ul>
						<li>
							<h3>상품 이미지</h3>
						</li>
						<li>
							<div class="upload1-btn-wrapper">
								<button class="btn">Upload a file</button>
								<input type="file" name="myFile1" id="image" accept="image/*"
									onchange="setThumbnail1(event);" multiple />
							</div>
						</li>
					</ul>
				</div>

				<div id="image_container1"></div>
				<div class="arrangeImage">
					<ul>
						<li>
							<h3>배치 이미지</h3>
						</li>
						<li>
							<div class="upload2-btn-wrapper">
								<button class="btn">Upload a file</button>
								<input type="file" name="myFile2" id="image" accept="image/*"
									onchange="setThumbnail2(event);" multiple />
							</div>
						</li>
					</ul>
				</div>

				<div id="image_container2"></div>
			</div>
		</div>
	</form>
</body>

</html>