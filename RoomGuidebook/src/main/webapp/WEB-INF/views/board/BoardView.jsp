<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page session="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>

<script src="https://code.jquery.com/jquery-3.5.1.js"></script>

<script>
        $(function () {
        	/* 전체 댓글 목록 조회 */
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
        	});
        	
        	/* 댓글 등록 */
            $("#registerBtn").on("click", function() {
    			var id = $("#boardId").val();
    			var memberId = $("memberId").val();
    			var content = $("#content").val();
    			var date = $("#now").val();

    			console.log(id);
    			console.log(memberId);
    			console.log(content);
    			console.log(date);
    			//$.ajax({
    			//	type : 'post',
    			//	url : '/registerCommentTest',
    			//	headers : {
    			//		"Content-Type" : "application/json",
    			//		"X-HTTP-Method-Override" : "POST"
    			//	},
    			//	dataType : 'text',
    			//	data : JSON.stringify({
    			//		commentId : id,
    			//		memberId : memberId,
    			//		baordId : ${board.boardId},
    			//		content : content,
    			//		date : date
    			//	}),
    			//	success : function(result) {
    			//		if (result == 'SUCCESS') {
    			//			alert("등록 완료");
    			//		}
    			//	}
    			//});
    		});
        });      
    </script>
</head>
<body>
	<p>${board.boardId}</p>
	<p>${board.memberId}</p>
	<p>${image.path}</p>

	<br>
	<h2>댓글</h2>

	<!-- 댓글 작성 -->
	<c:set var="now" value="<%=new java.util.Date()%>" />
	<c:set var="date">
		<fmt:formatDate value="${now}" pattern="yyyy-mm-dd" />
	</c:set>

	<div>
		<div>
			작성자<input type="text" name="memberId" id="memberId">
		</div>
		<div>
			내용<input type="text" name="content" id="content">
		</div>
 		<input type="hidden" value="${sessionScope.member.name}" id="commentId">
		<input type="hidden" value="${date}" id="now">
		<button id="registerBtn">등록</button>
	</div>

	<!-- 댓글 조회 -->
	<ul id="replies">
	</ul>


</body>
</html>