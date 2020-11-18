<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/resources/css/insertInfo.css">
</head>

<script>
	function popupSubmit(){
		window.opener.name = "FurnitureInfo";
		var roomInfo = document.roomInfo;
		roomInfo.target = "FurnitureInfo";
		roomInfo.action = "arrange";
		roomInfo.method = "post";
		roomInfo.submit();
		self.close();
	}
</script>
<body>
    <form class="form" name = "roomInfo">
        <div class="popup">
            <h2>배치 정보 입력</h2>
            <h4 id = "productName">상품 명 : ${productName}</h4>

            <h4>사진선택</h4>
            <div class="input-file"> <input type="text" readonly="readonly" class="file-name" />
                <label for="upload01" class="file-label">파일 업로드</label>
                <input type="file" name="" id="upload01" class="file-upload" /> </div>
        </div>

        <h4>내 방 정보 (cm)</h4>
        가로:<br>
        <input type="text" name="widthSize"><br>
        세로:<br>
        <input type="text" name="heightSize">
        
        <input type="hidden" name="productName" value="${productName}">
      <input type="hidden" name="productId" value="${productId}">
        
    </form>
    <br>
    <hr>
    <br>
    <div class="buttonGroup">
    
        <button class="Button" onclick="popupSubmit();">확인</button>
        <button class="Button">취소</button>
    </div>
    </div>
</body>
</html>