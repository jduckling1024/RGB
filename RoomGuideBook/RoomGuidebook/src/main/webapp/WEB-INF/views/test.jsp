<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>

<!-- <script src="/resources/plugins/jQuery/jQuery-2.1.4.min.js">
	var boardId = 1;
	$.getJSON("/getCommentList", function(data) {
		console.log(data.length);
		alert(data.length);
	});
</script>
 -->

<script src="https://code.jquery.com/jquery-3.5.1.js"></script>

<script>
        $(function () {
        	$.getJSON("/getCommentList", function(data) {
        		var str = "";
        		console.log(data.length);
        		
        		$(data).each(
        			function(){
        				str += "<li commentId='" + this.commentId +"' class = 'commentLi'>"
        				+ this.commentId + ":" + this.content 
        				+"</li>";
        			});
        			
        		$("#replies").html(str);	
        	}); /* 전체 목록에 대한 함수 처리 */
        });
    </script>
</head>
<body>
	<h2>댓글</h2>

	<ul id="replies">
	</ul>
</body>
</html>