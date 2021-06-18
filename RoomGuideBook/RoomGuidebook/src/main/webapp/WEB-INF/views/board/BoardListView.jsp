
<%-- <%@page import="dto.BoardDTO"%>
<%@page import="dto.LikeDTO"%>
<%@page import="dto.ImageDTO"%>
<%@page import="dto.ProductDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.util.*"%>
<%@include file="../main/header.jsp"%>
<!DOCTYPE html>
<html>
<head게시판</title>

<link rel="stylesheet" href="//resources/css/boardList.css">

<script>

ra.addFlashAttribute("boardRegisterResult", "succeeded");
   var result = '${boardRegisterResult}';
   
   if(result == "succeed"){
      alert("게시물 등록이 완료되었습니다.");
   }else if(result = "fail"){
      alert("게시물 등록 중 오류가 발생했습니다.");
   }
</script>
</head>
<body>

      <c:forEach var="list" items="${boardList}">
      <a href = "/getBoard?no=${list.boardId}"><c:out value="${list.boardId} ${list.memberId} ${list.title}"/></a>
   </c:forEach>

   <div class="wrap">
      <div class="top">
      </div>


      <div class="middle"></div>
      <div class="container">
      <button onclick="location.href='http://localhost:8080/registerBoardView';">등록</button> <!-- 위치 조정(밑이든 위든)이랑 css 적용 필요할 것 같습니다 -->
         <Table>
            <tr>
               <td class="category">
                  <ul>
                     <li><input type="text">
                     <li><input type="button" class="searchBtn" value="검색">
                     <li>
                        <form class="box">
                           <select>
                              <option>최신순</option>
                              <option>좋아요많은순</option>
                              <option>B</option>
                              <option>C</option>
                           </select>
                        </form>
                     </li>

                  </ul>
               </td>
            </tr>
         </table>

         <br>
         <div class="board">
            <%
               ArrayList<Object[]> list = (ArrayList<Object[]>) request.getAttribute("boardList");

            for (int i = 0; i < list.size(); i++) {
               pageContext.setAttribute("board", (BoardDTO) list.get(i)[0]);
               pageContext.setAttribute("image", (ImageDTO) list.get(i)[1]);
               pageContext.setAttribute("like", (LikeDTO) list.get(i)[2]);
            %>
            <div class="boardThumb">
               <a href="/getBoard?no=${board.boardId}"><ul>
                     <li class="userID">${board.memberId}</li>
                     <li class="date">${board.date}</li>
                     <li><img class="image" src="${image.path}"></li>
                     <li class="likeIt">Like it: ${board.likeCnt}</li>
                  </ul> </a>
            </div>
            <%
               }
            %>
         </div>
      </div>
      <br>
      <div class="page">
         <%
            int nowPage = (Integer) request.getAttribute("nowPage"); // 현재 페이지 번호
         int boardCnt = (Integer) request.getAttribute("boardCnt"); // 게시물 개수
         int lastId = (Integer) request.getAttribute("lastId"); // 마지막 게시물 번호
         int pages = (lastId - 1) / boardCnt;

         if (pages > 3) {
            pages = 3;
         }
         %>

         <%
            if (nowPage > 1) {
         %>
         <a href="/getBoardList?page=${nowPage-1}">&#60</a>
         <%
            }
         %>

         <%
            for (int i = nowPage; i < nowPage + boardCnt; i++) {
            pageContext.setAttribute("p", i);
            if (lastId >= 1) {
         %>
         <a href="/getBoardList?page=${p}">${p}</a>

         <%
            lastId = lastId - boardCnt;
         } else {
         break;
         }

         }
         %>

         <%
            if (pages > 0) {
         %>
         <a href="/getBoardList?page=${nowPage+1}">&#62</a>
         <%
            }
         %>
      </div>
   </div>

   <br>

   <div class="bottom"></div>
</body>
</html> --%>


<!--
Author: W3layouts
Author URL: http://w3layouts.com
License: Creative Commons Attribution 3.0 Unported
License URL: http://creativecommons.org/licenses/by/3.0/
-->

<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>

<!DOCTYPE HTML>
<%@page import="dto.LikeDTO"%>
<%@page import="dto.ImageDTO"%>
<%@page import="dto.BoardDTO"%>
<%@page import="java.util.ArrayList"%>
<%@include file="../main/header.jsp"%>
<html>

<head>
<title>RoomGuideBook_USER_PRODUCTLIST</title>
<link href="/resources/css/style.css" rel='stylesheet' type='text/css' />
<link href="/resources/css/boardList.css" rel='stylesheet'
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
   var boardDeleteResult = '${boardDeleteResult}';
   var boardRegisterResult = '${boardRegisterResult}';

   if (boardRegisterResult == "succeed") {
      alert("게시물 등록이 완료되었습니다.");
   } else if (boardRegisterResult == "fail") {
      alert("게시물 등록 중 오류가 발생했습니다.");
   }

   if (boardDeleteResult == "succeed") {
      alert("게시물 삭제가 완료되었습니다.");
   } else if (boardDeleteResult == "fail") {
      alert("게시물 삭제 중 오류가 발생했습니다.");
   }

   $(document).ready(function() {
      $('#demo').hide();
      $('.vticker').easyTicker();
   });
   
   function getRegisterFormView(){
      window.location.href = "/registerBoardView";
   }
</script>
<!----start-alert-scroller---->
<!-- start menu -->
<link href="/resources/css/megamenu.css" rel="stylesheet" type="text/css"
   media="all" />
<script type="text/javascript" src="/resources/js/megamenu.js"></script>
<script>
   $(document).ready(function() {
      $(".megamenu").megamenu();
   });
</script>
<script src="/resources/js/menu_jquery.js"></script>
<!-- //End menu -->
<!---slider---->
<link rel="stylesheet" href="/resources/css/slippry.css">
<script src="/resources/js/jquery-ui.js" type="text/javascript"></script>
<script src="/resources/js/scripts-f0e4e0c2.js" type="text/javascript"></script>
<script>
   jQuery('#jquery-demo').slippry({
      // general elements & wrapper
      slippryWrapper : '<div class="sy-box jquery-demo" />', // wrapper to wrap everything, including pager
      // options
      adaptiveHeight : false, // height of the sliders adapts to current slide
      useCSS : false, // true, false -> fallback to js if no browser support
      autoHover : false,
      transition : 'fade'
   });
</script>
<!---move-top-top---->
<script type="text/javascript" src="js/move-top.js"></script>
<script type="text/javascript" src="js/easing.js"></script>
<script type="text/javascript">
   jQuery(document).ready(function($) {
      $(".scroll").click(function(event) {
         event.preventDefault();
         $('html,body').animate({
            scrollTop : $(this.hash).offset().top
         }, 1200);
      });
   });
</script>
<!---//move-top-top---->
</head>


<body>
   <!--- start-content---->
   <div class="content product-box-main">
      <div class="wrap">

         <div class="content-right product-box">
            <div class="product-box-head">
               <div class="product-box-head-left">
                  <h3>
                     Post <span>(${boardCnt})</span>
                  </h3>
               </div>
               <div class="product-box-head-right">
                  <ul>
                     <li><span>Sort ::</span><a href="#"> </a></li>
                     <li><label> </label> <a href="#"> NEW</a></li>
                     <li><label> </label> <a href="#"> POPULAR</a></li>
                  </ul>
               </div>
               <div class="clear"></div>
            </div>

         
            <div class="Button">
               <button id="upload" onclick="getRegisterFormView();">등록</button>
            </div>

            <div class="product-grids">
               <!--- start-rate---->
               <script src="/resources/js/jstarbox.js"></script>
               <link rel="stylesheet" href="/resources/css/jstarbox.css"
                  type="text/css" media="screen" charset="utf-8" />
               <script type="text/javascript">
                  jQuery(function() {
                     jQuery('.starbox')
                           .each(
                                 function() {
                                    var starbox = jQuery(this);
                                    starbox
                                          .starbox(
                                                {
                                                   average : starbox
                                                         .attr('data-start-value'),
                                                   changeable : starbox
                                                         .hasClass('unchangeable') ? false
                                                         : starbox
                                                               .hasClass('clickonce') ? 'once'
                                                               : true,
                                                   ghosting : starbox
                                                         .hasClass('ghosting'),
                                                   autoUpdateAverage : starbox
                                                         .hasClass('autoupdate'),
                                                   buttons : starbox
                                                         .hasClass('smooth') ? false
                                                         : starbox
                                                               .attr('data-button-count') || 5,
                                                   stars : starbox
                                                         .attr('data-star-count') || 5
                                                })
                                          .bind(
                                                'starbox-value-changed',
                                                function(event,
                                                      value) {
                                                   if (starbox
                                                         .hasClass('random')) {
                                                      var val = Math
                                                            .random();
                                                      starbox
                                                            .next()
                                                            .text(
                                                                  ' '
                                                                        + val);
                                                      return val;
                                                   }
                                                })
                                 });
                  });
               </script>
               <!---//End-rate---->

               <%
                  ArrayList<Object[]> list = (ArrayList<Object[]>) request.getAttribute("boardList");

               for (int i = 0; i < list.size(); i++) {
                  pageContext.setAttribute("board", (BoardDTO) list.get(i)[0]);
                  pageContext.setAttribute("image", (ImageDTO) list.get(i)[1]);
                  pageContext.setAttribute("like", (LikeDTO) list.get(i)[2]);
               %>
               <div class="product-grid fade"
                  onclick="location.href='/getBoard?no=${board.boardId}';">
                  <div class="product-pic">
                     <!--- image --->
                     <a href="/getBoard?no=${board.boardId}"><img
                        src="${image.path}" title="product-name" /></a> <Br>
                     <p>
                        <!--- info --->
                        <span>${board.memberId}</span>
                        <!--- userID-->
                        <span id="date">${board.date}</span>
                        <!--- date-->
                        <a href="#">${board.title}</a>
                     </p>
                  </div>
                  <div class="board-info">
                     <div class="board-info-like">
                        <!--- likeIt --->
                        <ul>
                           <li id="likeIt"><h4>${board.likeCnt}</h4></li>
                           <li>
                              <button type="button" id="likeBtn">
                                 <img id="likeImg" src="/resources/others/tmp.png" alt="">
                              </button>
                           </li>

                        </ul>
                     </div>
                     <div class="clear"></div>
                  </div>

               </div>
               <%
                  }
               %>
               <div class="clear"></div>
            </div>
            <!----start-load-more-products---->
            <div class="loadmore-products">
               <a href="#">Loadmore</a>
            </div>
            <!----//End-load-more-products---->
         </div>
         <div class="clear"></div>
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