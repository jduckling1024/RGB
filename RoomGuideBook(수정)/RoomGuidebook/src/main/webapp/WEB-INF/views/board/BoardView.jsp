<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
           getCommentList();
           
           /* 댓글 등록 */
            $("#registerComment").on("click", function() {
             var id = $("#boardId").val();
             //var memberId = $("memberId").val();
             var content = $("#commentContent").val();
             //var date = $("#now").val();
             
             $.ajax({
                type : 'post',
                url : '/comments',
                headers : {
                   "Content-Type" : "application/json",
                   "X-HTTP-Method-Override" : "POST"
                },
                dataType : 'text',
                data : JSON.stringify({
                   //commentId : id,
                   //memberId : memberId,
                   boardId : ${board.boardId},
                   content : content
                   //date : date
                }),
                success : function(result) {
                   if (result == 'SUCCESS') {
                      alert("댓글 등록이 완료되었습니다.");
                      getCommentList();
                   }
                }
             });   
          });
           
           
           $(".commentList").on("click", "ul li .deleteBtn", function(){
        		   var comment = $(this).parent().prev().prev().prev(); // 댓글 객체
                   
        		   var no = comment.parent().attr("data-no");
                   var commentText = comment.text();
                   var memberId = comment.prev().text();
                   
                   var id = '${sessionScope.member.id}';
                   
                   if(id == memberId){
                	   if(confirm("댓글을 삭제하시겠습니까?")){
                	   $.ajax({
                           type : 'delete',
                           url : '/comments/' + no,
                           headers : {
                              "Content-Type" : "application/json",
                              "X-HTTP-Method-Override" : "DELETE"
                           },
                           dataType : 'text',
                           success : function(result){
                              console.log("result " + result);
                              if(result == 'SUCCESS'){
                                 alert("댓글 삭제가 완료되었습니다.");
                                 getCommentList();
                              }
                           }
                        });
                	   }
                   }else{
                	   alert("댓글 삭제 권한이 없습니다.");
                   }
           });
           
           $(".commentList").on("click", "ul li .modifyBtn", function () {
        	   var content = $(this).parent().prev().prev(); 
        	   var memberId = content.prev().text();
        	   var id = '${sessionScope.member.id}';
        	   
        	   if(id == memberId){
        		   content.hide(); // 댓글 숨김
                   $(this).parent().prev().hide(); // 댓글 버튼 숨김
                   $(this).parent().hide(); // 수정 버튼 숨김
                   $(this).parent().next().hide(); // 삭제 버튼 숨김
                   $(this).parent().parent().append("<li><input type=\"text\" style=\"margin-left: 10px;\" name=\"content\" value=\""+ content.text() +"\"></li>");
                   $(this).parent().parent().append("<li><input type=\"button\" class = \"modifyCommentBtn\" value=\"수정\"></li>");
        	   }else{
        		   alert("댓글 수정 권한이 없습니다.");
        	   }
           });
           
           $(".commentList").on("click", "ul li .modifyCommentBtn", function () {
        	   
        	   if(confirm("댓글을 수정하시겠습니까?")){
        		   var comment = $(this).parent().prev().children('input');
            	   var no = comment.parent().parent().attr("data-no");
            	   var content = $(this).parent().prev().children('input').val();
            	   var memberId = comment.parent().parent().children(".userId").text();
            	   
            	   $.ajax({
                           type : 'patch',
                           url : '/comments/' + no,
                           headers : {
                              "Content-Type" : "application/json",
                              "X-HTTP-Method-Override" : "PATCH"
                           },
                           dataType : 'text',
                           data : JSON.stringify({
                              commentId : no,
                              memberId : memberId,
                              boardId : ${board.boardId},
                              content : content
                              //date : date
                           }),
                           success : function(result) {
                              if (result == 'SUCCESS') {
                                 alert("댓글 수정이 완료되었습니다.");
                                 getCommentList();
                              }
                           }
                   });   
        	   }  
           });
        });
             
        
        function getCommentList(){
           $.getJSON("/comments/getCommentList", {"no": "<c:out value="${board.boardId}"/>"} ,function(data) {
              var str = "";
              console.log(data.length);
       
              $(data).each(
                 function(){
                    var margin = 20 * this.level;
                      console.log(margin);
                    str += "<ul data-no='"+ this.commentId +"'style='margin-left: "+ margin + "px;'> <li class = 'userId'>" + this.memberId + "</li> <li class = 'comment'>" + 
                    this.content + "</li> <li><input type='button' class='commentBtn' value='댓글'></li> <li><input type='button' class='modifyBtn' value='수정'></li>"  
                    + "<li><input type='button' class='deleteBtn' value='삭제'></li> </ul> <br> <br>";
                    
                    /* str += "<ul style='margin-left: "+ margin + "px;'> <li data-no='"+ this.commentId +"' class = 'userId'>" + this.memberId + "</li> <li class = 'comment'>" + 
                    this.content + "</li> <li><input type='button' class='commentBtn' value='댓글'></li> <li><input type='button' class='modifyBtn' value='수정'></li>"  
                    + "<li><input type='button' class='deleteBtn' value='삭제'></li> </ul> <br> <br>"; */
                 });
                 
              $("#replies").html(str);   
           });
        }
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
				<br> <br>
				<p class="main_title">
					<strong style="font-size: 25px;">${board.title}</strong>
				</p>
				<br>
				<div class="content">
					<img class="image" src="${image.path}" width="100%">
					<p>${board.content}</p>
				</div>
			</div>

			<div class="rightSection">
				<div class="insertComment">
					<ul>
						<li><input id="commentContent" type="text"
							style="display: inline-block; width: 400px;"> <input
							type="button" class="insertBtn" value="등록" id="registerComment"></li>
						<input type="hidden" id="boardId" val="${board.boardId}">
					</ul>
				</div>

				<br> <br> <br>


				<div class="commentList" id="replies">
					<!--  <ul>
                       <li class = "userId"><a>userId</a></li>
                       <li class = "comment"><a>comment</a></li>
                       <li><input type="button" class="modifyBtn" value="수정"></li>
                       <li><input type="button" class="deleteBtn" value="삭제"></li>
                   </ul> -->
				</div>

			</div>
		</div>

		<div class="bottom"></div>

	</div>
</body>
</html>