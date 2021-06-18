<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page session="true"%>
<%@include file="../main/header.jsp"%>

<!--
Author: W3layouts
Author URL: http://w3layouts.com
License: Creative Commons Attribution 3.0 Unported
License URL: http://creativecommons.org/licenses/by/3.0/
-->
<!DOCTYPE HTML>
<html>

<head>
<title>RoomGuideBook_USER_PRODUCTDETAIL</title>
<link href="/resources/css/style.css" rel='stylesheet' type='text/css' />
<link href="/resources/css/boardDetail.css" rel='stylesheet'
	type='text/css' />
<meta name="viewport" content="width=device-width, initial-scale=1">
<script type="application/x-javascript">
	
	
	 addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } 


</script>
<!----webfonts---->
<link
	href='http://fonts.googleapis.com/css?family=Open+Sans:400,300,600,700,800'
	rel='stylesheet' type='text/css'>
<!----//webfonts---->
<!----start-alert-scroller---->
<script src="/resources/js/jquery.min.js"></script>
<script type="text/javascript" src="/resources/js/jquery.easy-ticker.js"></script>

<script type="text/javascript">
        $(document).ready(function () {
            $('#demo').hide();
            $('.vticker').easyTicker();
            
            /* by jin */
            
            var boardUpdateResult = '${boardUpdateResult}';
            
            if(boardUpdateResult == "succeed"){
            	alert("게시물 수정을 완료하였습니다.");
            }else if(boardUpdateResult == "fail"){
            	alert("게시물 수정 중 오류가 발생하였습니다.");
            }
            
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
            
            
             $(".commentList").on("click", "ul li #delete", function(){
      		   var comment = $(this).prev(); // 댓글 객체
                 
      		   var no = comment.parent().parent().attr("data-no");
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
             
         
         $(".commentList").on("click", "ul li #modify", function () {
      	   var comment = $(this).prev().prev(); 
      	   var memberId = comment.prev().text();
      	   var id = '${sessionScope.member.id}';
      	   
      	   if(id == memberId){
      		     comment.hide(); // 댓글 숨김
                 $(this).prev().hide(); // 삭제 버튼 숨김
                 $(this).hide(); // 수정 버튼 숨김
                 $(this).next().hide(); // 등록 버튼 숨김
                 $(this).parent().append("<div style='display: inline-block;'><input type=\"text\" style=\"margin-left: 10px;\" name=\"content\" value=\""+ comment.text() +"\"></div>");
                 $(this).parent().append("<div style='display : inline-block;'><input type=\"button\" class = \"modifyBtn\" value=\"수정\"></div>");
      	   }else{
      		   alert("댓글 수정 권한이 없습니다.");
      	   }
         });
         
         
         $("#likeBtn").on("click", function(){
        	 var boardId = ${board.boardId};
        	 
        	 $.ajax({
                 type : 'post',
                 url : '/likeIt',
                 headers : {
                    "Content-Type" : "application/json",
                    "X-HTTP-Method-Override" : "POST"
                 },
                 dataType : 'text',
                 data : JSON.stringify({
                	 boardId : ${board.boardId},
                 }),
                 success : function(result) {
                	var nowCnt = document.getElementById("likeIt").innerHTML;
                    if (result == 'LIKE') {
                       document.getElementById("likeImg").src = "/resources/others/like2.png";
                       document.getElementById("likeIt").innerHTML = parseInt(nowCnt) + 1;
                       // 여기에 그 이미지 바뀌는거 적용하면 될 듯
                    }else if(result == 'DONT_LIKE'){
                       document.getElementById("likeImg").src = "/resources/others/tmp.png";
                       document.getElementById("likeIt").innerHTML = parseInt(nowCnt) - 1;
                    }
                 }
         }); 
        	 
         });
         
         $(".commentList").on("click", "ul li .modifyBtn", function () {
      	   
      	   if(confirm("댓글을 수정하시겠습니까?")){
      		   var comment = $(this).parent().prev().children('input');
          	   var no = comment.parent().parent().parent().attr("data-no");
          	   var content = comment.val();
          	   var memberId = comment.parent().parent().children('.userId').text();
          	   
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
                	var p = "";
                	  
                	for (var i = 0; i < this.level; i++) {
						p += "↳ ";
					}
                    //var margin = 20 * this.level;
                    //console.log(margin);
                     str += "<ul data-no='" + this.commentId + "' id='firstComment'> <li>" + p + "<div class = 'userId' style='display: inline-block;'>" + this.memberId +"</div>"+  "&nbsp; "+ "<div class = 'comment' style='display: inline-block;'>" + this.content + "</div> <Button id='delete' type='button'>삭제</Button> &nbsp; <Button id='modify' type='button'>수정</Button>&nbsp; <Button id='reply' type='button'>댓글</Button> </li></ul>";
                     
                     console.log(str);
                     /* str += "<ul style='margin-left: "+ margin + "px;'> <li data-no='"+ this.commentId +"' class = 'userId'>" + this.memberId + "</li> <li class = 'comment'>" + 
                     this.content + "</li> <li><input type='button' class='commentBtn' value='댓글'></li> <li><input type='button' class='modifyBtn' value='수정'></li>"  
                     + "<li><input type='button' class='deleteBtn' value='삭제'></li> </ul> <br> <br>"; */
                     
                  });
                  
               $(".commentList").html(str);   
            });
         }
        
        function toggleImg() {
            var tmp = document.getElementById("likeImg").src;
            var subString = "/resources/others/like2.png";

            if (tmp.indexOf(subString) !== -1) {
                document.getElementById("likeImg").src = "/resources/others/tmp.png";
            }

            else {
                document.getElementById("likeImg").src = "/resources/others/like2.png";
            }
        }
        
        
        function openPopup() {
            window.open("insertInfo.html", "배치정보입력",
                "width=410,height=400", "resizable=no");
        }
        
        function getUpdateForm(){
        	
        	var id = '${sessionScope.member.id}';
        	if(id == '${board.memberId}'){
        		var form_update = document.form_update;
            	form_update.actuib = "updateBoardView";
            	form_update.method = "get";
            	form_update.submit();
        	}else{
        		alert("게시물 수정 권한이 없습니다.");
        	}
        }
        
        function deleteBoard(){
        	var id = '${sessionScope.member.id}';
        	if(id == '${board.memberId}'){
        		if(confirm("정말 해당 게시물을 삭제하시겠습니까?")){
        			var form_update = document.form_update;
                	form_update.action = "deleteBoard";
                	form_update.method = "post";
                	form_update.submit();
        		}
        	}else{
        		alert("게시물 삭제 권한이 없습니다.");
        	}
        }
    </script>


<!----start-alert-scroller---->
<!-- start menu -->
<link href="/resources/css/megamenu.css" rel="stylesheet"
	type="text/css" media="all" />
<script type="text/javascript" src="/resources/js/megamenu.js"></script>
<script>$(document).ready(function () { $(".megamenu").megamenu(); });</script>
<script src="/resources/js/menu_jquery.js"></script>
<!-- //End menu -->
<!---slider---->
<link rel="stylesheet" href="/resources/css/slippry.css">
<script src="/resources/js/jquery-ui.js" type="text/javascript"></script>
<script src="/resources/js/scripts-f0e4e0c2.js" type="text/javascript"></script>
<script>
        jQuery('#jquery-demo').slippry({
            // general elements & wrapper
            slippryWrapper: '<div class="sy-box jquery-demo" />', // wrapper to wrap everything, including pager
            // options
            adaptiveHeight: false, // height of the sliders adapts to current slide
            useCSS: false, // true, false -> fallback to js if no browser support
            autoHover: false,
            transition: 'fade'
        });
    </script>
<!---move-top-top---->
<script type="text/javascript" src="/resources/js/move-top.js"></script>
<script type="text/javascript" src="/resources/js/easing.js"></script>
<script type="text/javascript">
        jQuery(document).ready(function ($) {
            $(".scroll").click(function (event) {
                event.preventDefault();
                $('html,body').animate({ scrollTop: $(this.hash).offset().top }, 1200);
            });
        });
    </script>
<!---//move-top-top---->
</head>


<body>
	<!---start-wrap---->
	<!---start-header---->
	<!-- <div class="header">
        <div class="top-header">
            <div class="wrap">
                <div class="top-header-left">
                    <ul>
                        -cart-tonggle-script--
                        <script type="text/javascript">
                            $(function () {
                                var $cart = $('#cart');
                                $('#clickme').click(function (e) {
                                    e.stopPropagation();
                                    if ($cart.is(":hidden")) {
                                        $cart.slideDown("slow");
                                    } else {
                                        $cart.slideUp("slow");
                                    }
                                });
                                $(document.body).click(function () {
                                    if ($cart.not(":hidden")) {
                                        $cart.slideUp("slow");
                                    }
                                });
                            });
                        </script>
                        -//cart-tonggle-script--
                        <li><a class="cart" href="#"><span id="clickme"> </span></a></li>
                        -start-cart-bag--
                        <div id="cart">Your Cart is Empty <span>(0)</span></div>
                        -start-cart-bag--
                        <li><a class="info" href="#"><span> </span></a></li>
                    </ul>
                </div>
                <div class="top-header-center">
                    <div class="top-header-center-alert-left">
                        <h3>RGB : Room Guide Book</h3>
                    </div>
                    <div class="top-header-center-alert-right">
                        <div class="vticker">
                            <ul>
                                <li>Welcome to RGB: Room Guide Book<label>-TEST</label></li>
                            </ul>
                        </div>
                    </div>
                    <div class="clear"> </div>
                </div>
                <div class="top-header-right">
                    <ul>
                        <li><a href="login.html">Login</a><span> </span></li>
                        <li><a href="register.html">Join</a></li>
                    </ul>
                </div>
                <div class="clear"> </div>
            </div>
        </div>

        --start-mid-head--
        <div class="mid-header">
            <div class="wrap">
                <div class="mid-grid-left">
                    <form>
                        <input type="text" placeholder="What Are You Looking for?" />
                    </form>
                </div>
                <div class="mid-grid-right">
                    <a class="logo" href="index.html"><span> </span></a>
                </div>
                <div class="clear"> </div>
            </div>
        </div>
        --//End-mid-head--

        --start-bottom-header--
        <div class="header-bottom">
            <div class="wrap">
                start header menu
                <ul class="megamenu skyblue">
                    <li class="grid"><a class="color2" href="#">STORE</a>
                        <div class="megapanel">
                            <div class="row">
                                <div class="col1">
                                    <div class="h_nav">
                                        <h4>거실가구</h4>
                                        <ul>
                                            <li><a href="products.html">소파</a></li>
                                            <li><a href="products.html">거실수납장/TV장</a></li>
                                            <br>
                                        </ul>
                                    </div>
                                    <div class="h_nav">
                                        <h4 class="top">학생/서재가구</h4>
                                        <ul>
                                            <li><a href="products.html">책상</a></li>
                                            <li><a href="products.html">책장</a></li>
                                            <br>
                                        </ul>
                                    </div>
                                </div>

                                <div class="col1">
                                    <div class="h_nav">
                                        <h4>침실가구</h4>
                                        <ul>
                                            <li><a href="products.html">침대</a></li>
                                            <li><a href="products.html">화장대</a></li>
                                            <li><a href="products.html">거울</a></li>
                                        </ul>
                                    </div>
                                    <div class="h_nav">
                                        <h4 class="top">수납가구</h4>
                                        <ul>
                                            <li><a href="products.html">수납장</a></li>
                                            <br> <br>
                                        </ul>
                                    </div>
                                </div>

                                <div class="col1">
                                    <div class="h_nav">
                                        <h4>드레스룸</h4>
                                        <ul>
                                            <li><a href="products.html">옷장</a></li>
                                            <li><a href="products.html">행거</a></li>
                                            <br>
                                        </ul>
                                    </div>
                                    <div class="h_nav">
                                        <h4 class="top">테이블</h4>
                                        <ul>
                                            <li><a href="products.html">좌식테이블</a></li>
                                            <br>
                                            <br>
                                        </ul>
                                    </div>
                                </div>
                                <div class="col1">
                                    <div class="h_nav">
                                        <h4>주방가구</h4>
                                        <ul>
                                            <li><a href="products.html">식탁</a></li>
                                            <li><a href="products.html">주방수납</a></li>
                                            <br>
                                        </ul>
                                    </div>
                                    <div class="h_nav">
                                        <h4 class="top">의자</h4>
                                        <ul>
                                            <li><a href="products.html">일반의자</a></li>
                                            <li><a href="products.html">좌식의자</a></li>
                                            <li><a href="products.html">스툴</a></li>
                                        </ul>
                                    </div>
                                </div>


                            </div>
                        </div>
                    </li>
                    <li class="active grid"><a class="color4" href="#">COMMUNITY</a></li>

                    <li><a class="color8" href="#">OTHER</a>
                        <div class="megapanel">
                            <div class="row">
                                <div class="col1">
                                    <div class="h_nav">
                                        <h4>회원관리</h4>
                                        <ul>
                                            <li><a href="#">회원정보 조회</a></li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </li>
                </ul>

            </div>
        </div>
    </div> -->
	<!----//End-bottom-header---->
	<!---//End-header---->

	<!--- start-content---->
	<div class="content details-page">
		<!---start-product-details--->
		<div class="product-details">
			<div class="wrap">

				<!----details-product-slider--->
				<!-- Include the Etalage files -->
				<link rel="stylesheet" href="/resources/css/etalage.css">
				<script src="/resources/js/jquery.etalage.min.js"></script>
				<!-- Include the Etalage files -->
				<script>
                    jQuery(document).ready(function ($) {

                        $('#etalage').etalage({
                            thumb_image_width: 300,
                            thumb_image_height: 400,
                            source_image_width: 900,
                            source_image_height: 1000,
                            show_hint: true,
                            click_callback: function (image_anchor, instance_id) {
                                alert('Callback example:\nYou clicked on an image with the anchor: "' + image_anchor + '"\n(in Etalage instance: "' + instance_id + '")');
                            }
                        });
                        // This is for the dropdown list example:
                        $('.dropdownlist').change(function () {
                            etalage_show($(this).find('option:selected').attr('class'));
                        });

                    });
                </script>



				<!----//details-product-slider--->
				<div class="details-left">
					<form name="form_update" action="/updateBoardView" method="get">
						<div class="details-left-content">
							<input type="hidden" name="boardId" value="${board.boardId}">
							<%-- <input type="hidden" name="title" value="${board.title}">
							<input type="hidden" name="memberId" value="${board.memberId}">
							<input type="hidden" name="content" value="${board.content}"> --%>

							<h1>${board.title}</h1>

							<!--- main_title-->
							<ul>
								<li class="boardInfo"><span>${board.memberId}</span> <!--- userId-->
									<span id="date">${board.date}</span> <!--- date--></li>
							</ul>
							<ul>
								<li class="likeInfo"><span><button type="button"
											id="likeBtn">
											
											<c:set var="isLike" value="${like.boardId}"></c:set>
											<c:choose>
												<c:when test="${isLike == 0}">
												<img id="likeImg" src="/resources/others/tmp.png" alt="">
												</c:when>
												<c:otherwise>
												<img id="likeImg" src="/resources/others/like2.png" alt="">
												</c:otherwise>
											</c:choose>
											
										</button></span> <Span id="likeIt">${board.likeCnt}</Span></li>
							</ul>


							<!--- 좋아요 버튼   -->

							<div class="image">
								<img src="${image.path}">
							</div>
							<!--- src="${image.path}" -->
							<p class="board-detail-info">
								<!--- <p>${board.content}</p> -->
								<!-- 안녕하세요? : ) 독립한 지 이제 막 5개월 된 자취 새내기입니다.
                            어렸을 때부터 독립해서 나만의 공간을 꾸미고 사는 게 제 버킷리스트 중 하나였어요.
                            부모님과 함께 살면서 항상 자취하는 게 꿈이라며 노래를 불렀고 "꿈이라는데 한번 나가서 살아봐라~"
                            하시는 부모님 말씀에 후다닥 자취를 시작하게 되었는데요! 전체적으로 따듯한 느낌으로 꾸며봤어요!
                            저녁에는 이렇게 스탠드랑 간접조명만 켜고 있는데 낮하고는 또 다른 분위기를 느낄 수 있어요 : ) -->
								${board.content}

							</p>
						</div>


						<div class="details-left-info">
							<div class="BtnGroup">
								<!--- 게시물작성자일때만 보이고 아닐땐, display:none-->

								<span><Button id="deletePost" type="button"
										onclick="deleteBoard()">게시물 삭제</Button>
									<Button id="modifyPost" type="button" onclick="getUpdateForm()">게시물
										수정</Button></span>
							</div>


							<div class="details-right-head">
								<div class="insertComment">
									<ul>
										<li><input id="commentContent" type="text"> <input
											type="button" class="insertBtn" value="등록"
											id="registerComment"></li>
										<input type="hidden" id="boardId">
									</ul>
								</div>

								<div class="commentList">
									<!-- <ul id="firstComment">
									<li> <div style="display: inline-block;"> USERNAME</div>
									&nbsp;
									<div style="display: inline-block;">댓글1</div> - float:right해놔서 제일 앞에 버튼이 가장 오른쪽에
										배치됨
										<Button id="delete">삭제</Button>&nbsp;
										<Button id="modify">수정</Button>&nbsp;
										<Button id="reply">댓글</Button>
								</ul>

								<ul id="secondComment">
									- 대댓글 id 지정해주고, userName 앞에 ↳ &nbsp; 추가
									<li>↳ &nbsp;USERNAME&nbsp; &nbsp; 대댓글1
										<Button id="delete">삭제</Button>&nbsp;
										<Button id="modify">수정</Button>&nbsp;
										<Button id="reply">댓글</Button>
									</li>
								</ul>

								<ul id="insertSecondComment">
									<li>↳ &nbsp; <input id="sComment" type="text">
										<Button id="registerScommentBtn">댓글</Button>&nbsp;
										<Button id="cancel">취소</Button></li>
									<input type="hidden" id="boardId">
								</ul> -->
								</div>

								<div class="pagination">
									<!--- 댓글 개수따라서 page 개수만큼 a태그-->
									<a href="#">&laquo;</a> <a href="#">1</a> <a href="#">2</a> <a
										href="#">3</a> <a href="#">&raquo;</a>
								</div>
							</div>
						</div>
					</form>
				</div>

				<div class="clear"></div>
			</div>

		</div>
	</div>
	<!---- start-bottom-grids---->
	<div class="bottom-grids">

		<div class="bottom-bottom-grids"></div>
	</div>
	<!---- //End-bottom-grids---->
	<!--- //End-content---->
	<!---start-footer---->
	<div class="footer">
		<div class="wrap">
			<div class="footer-left">
				<ul>
					<li><a href="#">RoomGuideBook</a> <span> </span></li>
				</ul>
			</div>

			<div class="clear"></div>
		</div>
	</div>
	<!---//End-footer---->
	<!---//End-wrap---->
</body>

</html>