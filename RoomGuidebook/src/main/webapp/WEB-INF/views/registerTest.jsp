<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>

<script>
	$(function() {
		$("#replyAddBtn").on("click", function() {
			alert("�� �ȵ�!!!");
			var id = 4;
			var memberId = $("#newReplyWriter").val();
			var content = $("#newReplyText").val();

			$.ajax({
				type : 'post',
				url : '/registerCommentTest',
				headers : {
					"Content-Type" : "application/json",
					"X-HTTP-Method-Override" : "POST"
				},
				dataType : 'text',
				data : JSON.stringify({
					commentId : id,
					memberId : memberId,
					content : content
				}),
				success : function(result) {
					if (result == 'SUCCESS') {
						alert("��� �Ϸ�");
					}
				}
			});
		});
	});
</script>

<title>Document</title>
</head>

<body>
	<div>
		<div>
			�ۼ���<input type="text" name="memberId" id="newReplyWriter">
		</div>
		<div>
			����<input type="text" name="content" id="newReplyText">
		</div>
		<button id="replyAddBtn">���</button>
	</div>
</body>
</html>