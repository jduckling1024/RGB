<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>방 정보 입력</title>
<link rel="stylesheet" href="/resources/css/insertInfo.css">
</head>

<script type="text/javascript"
	src="http://code.jquery.com/jquery-3.2.1.min.js">
	
</script>

<script>
	function popupSubmit() {
		window.opener.name = "FurnitureInfo";
		var roomInfo = document.roomInfo;
		roomInfo.target = "FurnitureInfo";
		roomInfo.action = "objectdetect";
		roomInfo.method = "post";
		roomInfo.submit();
		self.close();
	}

	(function($) {

		var $fileBox = null;

		$(function() {
			init();
		})

		function init() {
			$fileBox = $('.input-file');
			fileLoad();
		}

		function fileLoad() {
			$.each($fileBox, function(idx) {
				var $this = $fileBox.eq(idx), $btnUpload = $this
						.find('[type="file"]'), $label = $this
						.find('.file-label');

				$btnUpload
						.on('change',
								function() {
									var $target = $(this), fileName = $target
											.val(), $fileText = $target
											.siblings('.file-name');
									$fileText.val(fileName);
								})

				$btnUpload.on('focusin focusout', function(e) {
					e.type == 'focusin' ? $label.addClass('file-focus')
							: $label.removeClass('file-focus');
				})
			})
		}
	})(jQuery);
</script>

<body>

	<div class="popup">
		<form class="form" name="roomInfo" enctype="multipart/form-data">
			<h2>배치 정보 입력</h2>
			<h4>사진선택</h4>
			<div class="input-file">
				<input type="text" readonly="readonly" class="file-name" /> <label
					for="upload01" class="file-label">파일 업로드</label> 
					<input type="file" name="file" id="upload01" class="file-upload" />
			</div>

			<h4>내 방 정보 (cm)</h4>
			가로:<br> <input type="text" name="widthSize"><br>
			세로:<br> <input type="text" name="heightSize"> <input
				type="hidden" name="productName" value="${productName}"> <input
				type="hidden" name="productId" value="${productId}">
		</form>
	</div>
	<hr>
	<br>
	<div class="buttonGroup">
		<input class="Button" onclick="popupSubmit();" value="확인">
		<button class="Button">취소</button>
	</div>

</body>

</html> --%>


<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>방 정보 입력</title>
<link rel="stylesheet" href="/resources/css/insertInfo.css">
    
    <script type="text/javascript" src = "http://code.jquery.com/jquery-3.2.1.min.js"></script>
    <script>
    
	function popupSubmit(){
		window.opener.name = "FurnitureInfo";
		var roomInfo = document.roomInfo;
		roomInfo.target = "FurnitureInfo";
		roomInfo.action = "objectdetect";
		roomInfo.method = "post";
		roomInfo.submit();
		self.close();
	}
</script>
</head>

<body resizable="no">
  <form class="form" name = "roomInfo" enctype="multipart/form-data">
    <div class = "popup">
        <h3>배치 정보 입력</h3>
        <hr>
        <h4 id = "productName">상품 명 : ${productName}</h4>
        <h4>사진선택</h4>
        <div class="input-file"> 
          <input type="text" readonly="readonly" class="file-name" />
          <label for="upload01" class="file-label">파일 업로드</label>
          <input type="file" name="file" id="upload01" class="file-upload"/> 
        </div>
            <h4>내 방 정보 (cm)</h4>
            <span>가로&nbsp; : &nbsp;<input type="text" name="widthSize">
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            세로&nbsp; : &nbsp;<input type="text" name="heightSize"></span><br>
            <input type="hidden" name="productName" value="${productName}">
            <input type="hidden" name="productId" value="${productId}">
        </form>
       <br>
       <hr>
       <br>
        <input class = "okBtn" type = "submit" value="확인" onclick="popupSubmit();">
        <button class = "cancelBtn">취소</button>
    </div>
</body>
<script>

(function($){
  
  var $fileBox = null;
  
  $(function() {
    init();
  })
  
  function init() {
    $fileBox = $('.input-file');
    fileLoad();
  }
  
  function fileLoad() {
    $.each($fileBox, function(idx){
      var $this = $fileBox.eq(idx),
          $btnUpload = $this.find('[type="file"]'),
          $label = $this.find('.file-label');
      
      $btnUpload.on('change', function() {
        var $target = $(this),
            fileName = $target.val(),
            $fileText = $target.siblings('.file-name');
        $fileText.val(fileName);
      })
      
      $btnUpload.on('focusin focusout', function(e) {
        e.type == 'focusin' ?
          $label.addClass('file-focus') : $label.removeClass('file-focus');
      })
      
    })
  }
  
  
})(jQuery);


</script>
