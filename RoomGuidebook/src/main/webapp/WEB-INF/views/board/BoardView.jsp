<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page session="true"%>
<%@include file="../main/header.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script src="https://code.jquery.com/jquery-3.5.1.js"></script>

<script>
        $(function () {
        	/* 전체 댓글 목록 조회 */
        	$.getJSON("/getCommentList", {"no": "<c:out value="${board.boardId}"/>"} ,function(data) {
        		var str = "";
        		console.log(data.length);
       
        		$(data).each(
        			function(){
        				var margin = 20 * this.level;
                		console.log(margin);
        				str += "<ul style='margin-left: "+ margin + "px;'> <li class = 'userId'>" + this.memberId + "</li> <li class = 'comment'>" + this.content + "</li> <li><input type='button' class='modifyBtn' value='수정'></li> <li><input type='button' class='deleteBtn' value='삭제'></li> </ul> <br> <br>";
                            
        				/* str += "<li commentId='" + this.commentId +"' class = 'commentLi'>"
        				+ this.commentId + ":" + this.content 
        				+"</li>"; */
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
    
    <link rel="stylesheet" href="/resources/css/board.css">
</head>
<body>
    <div class="wrap">
<!--         <div class="top">
            <div class="header">
                <p class="Title"><strong>RGB : Room Guide Book</p></strong>
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

        <div class="container">
            <div class="leftSection">
                <br>
                <br>
                <p class="main_title"><strong style="font-size: 25px;">${board.title}</strong></p>
                <br>
                <div class="content">
                    <img class="image" src="${image.path}" width="100%">
                    <p>${board.content} </p>
                </div>
            </div>

            <div class="rightSection">
                <div class="insertComment">
                    <ul>
                        <li><input type="text" style="display: inline-block; width: 400px;">
                        <input type="button" class="insertBtn" value="등록"></li>
                    </ul>
                </div>

                <br> <br> <br>


               <div class = "commentList" id="replies">
                  <!--  <ul>
                       <li class = "userId"><a>userId</a></li>
                       <li class = "comment"><a>comment</a></li>
                       <li><input type="button" class="modifyBtn" value="수정"></li>
                       <li><input type="button" class="deleteBtn" value="삭제"></li>
                   </ul> -->
               </div>

            </div>
        </div>
        
        <!-- 테스트용 -->
           <ul id="replies"></ul>
        


        <div class="bottom">

        </div>

    </div>
</body>
</html>