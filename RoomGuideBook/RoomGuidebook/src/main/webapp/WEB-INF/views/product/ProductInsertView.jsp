<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Product</title>
<link rel="stylesheet" href="/resources/css/productRegister.css">
<style>
.filebox label {
	display: inline-block;
	padding: .5em .75em;
	color: #999;
	font-size: inherit;
	line-height: normal;
	vertical-align: middle;
	border: 2px solid gray;
	background: #424242;
	color: white;
	cursor: pointer;
	border: 1px solid #ebebeb;
	border-bottom-color: #e2e2e2;
	border-radius: .25em;
}

.filebox input[type="file"] { /* 파일 필드 숨기기 */
	position: absolute;
	width: 1px;
	height: 1px;
	padding: 0;
	margin: -1px;
	overflow: hidden;
	clip: rect(0, 0, 0, 0);
	border: 0;
}
</style>

<script src="https://code.jquery.com/jquery-3.5.1.js"></script>

<script>

$(function () {
	   $("#colorList").on("click", "li", function(){
	      $("#colorList").children('li').css("border", "1px solid black");
	      
	      var color = $(this).text();
	      $(this).css("border", "3px solid red");
	      $("#color").val(color);
	   });
	});

function setThumbnail1(event) {
    for (var image of event.target.files) {
        var reader = new FileReader();
        reader.onload = function (event) {
            var img = document.createElement("img");
            img.setAttribute("src", event.target.result);
            img.style.marginLeft = "5px";
            img.style.marginRight = "5px"; 
            document.querySelector("div#image_container1").appendChild(img);
        };
        console.log(image);
        reader.readAsDataURL(image);
    }
}

function setThumbnail2(event) {
    for (var image of event.target.files) {
        var reader = new FileReader();
        reader.onload = function (event) {
            var img = document.createElement("img");
            img.setAttribute("src", event.target.result);
            img.setAttribute("src", event.target.result);
            img.setAttribute("height", "250px");
            img.setAttribute("width", "250px");
            img.style.marginLeft = "5px";
            img.style.marginRight = "5px";
            document.querySelector("div#image_container2").appendChild(img);
        };
        console.log(image);
        reader.readAsDataURL(image);
    }
}

function setThumbnail3(event) {
    for (var image of event.target.files) {
        var reader = new FileReader();
        reader.onload = function (event) {
            var img = document.createElement("img");
            img.setAttribute("src", event.target.result);
            img.setAttribute("src", event.target.result);
            img.setAttribute("height", "250px");
            img.setAttribute("width", "250px");
            img.style.marginLeft = "2.5%";
            img.style.marginRight = "2.5%";
            document.querySelector("div#image_container3").appendChild(img);
        };
        console.log(image);
        reader.readAsDataURL(image);
    }
}


var parentCategory = 0;
var childCategory = 0;
function getParentCategory(selectObj){
    if (selectObj.selectedIndex != 0){
    	parentCategory = selectObj.options[selectObj.selectedIndex].value;
    }
}

function getChildCategory(selectObj){
    if (selectObj.selectedIndex != 0){
    	childCategory = selectObj.options[selectObj.selectedIndex].value;
    }
}
        
       	function registerProduct(){	
       		var name = document.getElementsByName("name")[0].value;
            var price = document.getElementsByName("price")[0].value;
            var stock = document.getElementsByName("stock")[0].value;
            var width = document.getElementsByName("width")[0].value;
            var length = document.getElementsByName("length")[0].value;
            var height = document.getElementsByName("height")[0].value;
            var brand = document.getElementsByName("brand")[0].value;
            var info = document.getElementsByName("info")[0].value;

            if (name == '' || price == '' || stock == '' || width == '' || length == '' || height == '' || parentCategory == 0 || childCategory == 0 || brand == 0) {
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
		<a href="/getProductList">상품조회 및 수정</a> <a
			href="/getRegisterProductForm">상품 등록</a>
		<h3>
			<strong>주문 관리</strong>
		</h3>
		<a href="/getListForSeller">주문조회</a>
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
										<div class="box">
											<select class="sel" onchange="getParentCategory(this)"
												name="parentCategory">
												<option value="0">상위 카테고리</option>
												<option value="301">거실가구</option>
												<option value="302">침실가구</option>
												<option value="303">드레스룸</option>
												<option value="304">학생/서재 가구</option>
												<option value="305">수납가구</option>
												<option value="306">테이블</option>
												<option value="307">의자</option>
												<option value="308">주방가구</option>
											</select>
										</div>
									</li>

									<li>
										<div class="box">
											<select class="sel" onchange="getChildCategory(this)"
												name="childCategory">
												<option value="0">하위 카테고리</option>
												<option value="401">소파</option>
												<option value="402">거실수납장</option>
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
												<option value="414">스툴</option>
												<option value="415">좌식의자</option>
												<option value="416">TV장</option>
												<option value="417">행거</option>
											</select>
										</div>
									</li>
								</ul>

							</td>

							<!-- <td class="menu">
                                <h3>상품번호</h3> 일단 보류
                            </td>
                            <td colspan="3" class="category"><input id="productId" type="text"></td> -->
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

						<tr>
							<td class="menu">
								<h3>제품 설명</h3>
							</td>
							<td colspan="2" class="category">
								<ul>
									<li><input type="text" id="num4" style="width: 600px;"
										name="info"></li>
								</ul>
							</td>
							<td class="menu">
								<h3>브랜드</h3>
							</td>
							<td colspan="2" class="category">
								<ul>
									<li><input type="text" style="width: 200px;" name="brand">
									</li>
								</ul>
							</td>
						</tr>
						<tr>
							<td class="menu">
								<h3>색상</h3>
							</td>
							<td colspan="2" class="category">
								<ul id = "colorList">
									<li class="red" value="red">red</li>
									<li class="orange" value="orange" onclick="selectColor();">orange</li>
									<li class="yellow" value="yellow" onclick="selectColor();">yellow</li>
									<li class="yellow-green" value="yellow-green"
										onclick="selectColor();">yellow-green</li>
									<li class="green" value="green">green</li>
									<li class="sky-blue" value="sky-blue">sky-blue</li>
									<li class="navy" value="navy">navy</li>
									<li class="white" value="white">white</li>
									<li class="gray" value="gray">gray</li>
									<li class="black" value="black">black</li>
								</ul>
							</td>
						</tr>
					</table>
				</div>

			</div>
		</div>

		<div class="imageWrapper">
			<div class="mainImage" style="width: 26%">
				<ul>
					<li style="font-size: 20px; font-weight: 700; margin-right: 2%;">메인
						이미지</li>
					<li>
						<div class="filebox">
							<label for="ex_file">Upload a file</label> <input type="file"
								name="myFile3" id="ex_file" accept="image/*"
								onchange="setThumbnail3(event);">
						</div>

					</li>
				</ul>
				<div id="image_container3" style="width: 100%; margin-top: 2%"></div>
			</div>

			<div class="productImage" style="width: 70%">
				<ul>
					<li style="font-size: 20px; font-weight: 700;">상품 이미지</li>
					<li>
						<div class="filebox">
							<label for="ex_file2">Upload a file</label> <input type="file"
								name="myFile1" id="ex_file2" accept="image/*"
								onchange="setThumbnail1(event);" multiple="multiple">
						</div>
					</li>
				</ul>
				<div id="image_container1" style="width: 100%; margin-top: 1%"></div>
			</div>


			<div class="arrangeImage" style="width: 100%">
				<ul>
					<li style="font-size: 20px; font-weight: 700; margin-right: 2%;">
						배치 이미지</li>
					<li>
						<div class="filebox">
							<label for="ex_file3">Upload a file</label> <input type="file"
								name="myFile2" id="ex_file3" accept="image/*"
								onchange="setThumbnail2(event);" multiple="">
						</div>
					</li>
				</ul>
			</div>
			<div id="image_container2"></div>
		</div>
		<input type = "hidden" id = "color" name = "color">
		</div>
		</div>
	</form>
</body>

</html>