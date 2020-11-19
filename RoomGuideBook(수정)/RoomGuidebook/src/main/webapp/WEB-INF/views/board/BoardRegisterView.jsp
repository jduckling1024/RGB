<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../main/header.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시물 등록</title>

<script>
    function setThumbnail1(event) {
    	// 일단 자식 없애는 구문도 추가되어야 할 것 같아요
        for (var image of event.target.files) {
            var reader = new FileReader();
            reader.onload = function (event) {
                var img = document.createElement("img");
                img.onclick = function () { document.getElementById('image_container1').removeChild(this) }; // 이미지를 다시 한번 더 클릭하면 삭제
                img.setAttribute("src", event.target.result);
                img.style.marginTop='10px';
                img.style.width='350px ';
                img.style.height='350px'
                document.querySelector("div#image_container1").appendChild(img);
            };
            console.log(image);
            reader.readAsDataURL(image);
        }
    }
</script>

<link rel="stylesheet" href="/resources/css/boardRegister.css">
</head>
<body>
	<div class="wrap">
		<!-- 		<div class="top">
			<div class="header">
				<p class="Title">
					<strong>RGB : Room Guide Book </p>
				</strong>
				<div class="menu">
					<ul>
						<li class="menu1"><a href="">Store</a>
						<li class="menu2"><a href="">Community</a>
						<li class="menu3"><a href="">Login</a>
						<li class="menu4"><a href="">Join</a></li>
					</ul>
				</div>
			</div>
		</div> -->

		<div class="middle"></div>

		<div class="board">
			<form action="/registerBoard" method="post" enctype="multipart/form-data">
				<div class="imageSection">
					<div class="upload-btn-wrapper">
						<button class="btn">Upload a file</button>
						<input type="file" name="myfile" accept="image/*"
							onchange="setThumbnail1(event);" enctype="multipart/form-data"/>


						<div id="image_container1"></div>

					</div>
				</div>
				<div class="contentSection">
					<input type="text" id="content2" placeholder="제목을 입력해주세요"
						name="title">
					<textarea cols="45" rows="15" id="content"
						placeholder="사진에 대해서 설명해주세요" name="content"></textarea>
				</div>

				<button type="submit" id="addBtn">올리기</button>
			</form>
		</div>

		<div class="bottom">
			<br>
		</div>

	</div>
</body>

</html>