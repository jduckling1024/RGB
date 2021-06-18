<%@page import="dto.BoardDTO"%>
<%@page import="dto.ProductDTO"%>
<%@page import="dto.ImageDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="header.jsp"%>

<!--
Author: W3layouts
Author URL: http://w3layouts.com
License: Creative Commons Attribution 3.0 Unported
License URL: http://creativecommons.org/licenses/by/3.0/
-->
<!DOCTYPE HTML>
<html>
<head>
<script type="text/javascript">
         var result = '${result}';
      
         if (result == "loginSucceeded") {
            alert('${sessionScope.member.name}' + "님, 환영합니다.");
         } else if (result == "logout") {
            alert("로그아웃이 정상적으로 처리되었습니다.");
         } else if (result == "registerMemberSucceeded") {
            alert("회원가입이 완료되었습니다.");
         } else if (result == "registerMemberFailed") {
            alert("회원가입 중 알 수 없는 오류가 발생했습니다.");
         } else if (result == "needLogin") {
            if (confirm("로그인이 필요한 작업입니다. 로그인 페이지로 이동하시겠습니까?")) {
               window.location.href = "/login";
            }
         } else if (result == "updateMemberSucceeded") {
            alert("회원정보 수정이 완료되었습니다.");
         } else if (result == "deleteMemberSucceed") {
            alert("회원 탈퇴가 완료되었습니다. 그동안 RGB를 이용해주셔서 감사합니다.")
         } else if(result == "orderSucceed"){
            if(confirm("상품 구입이 완료되었습니다. 구입 내역 페이지로 이동하시겠습니까?")){
               window.location.href = "/getListForMember";
            }
         }
      </script>
      
<title>RGB: Room Guide Book</title>
<link href="/resources/css/main.css" rel='stylesheet' type='text/css' />
<meta name="viewport" content="width=device-width, initial-scale=1">
<script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>
<!----webfonts---->
<link
   href='http://fonts.googleapis.com/css?family=Open+Sans:400,300,600,700,800'
   rel='stylesheet' type='text/css'>
<!----//webfonts---->
<!----start-alert-scroller---->
<script src="/resources/js/jquery.min.js"></script>
<script type="text/javascript" src="/resources/js/jquery.easy-ticker.js"></script>
<script type="text/javascript">
      $(document).ready(function(){
         $('#demo').hide();
         $('.vticker').easyTicker();
      });
      </script>
<!----start-alert-scroller---->
<!-- start menu -->
<link href="/resources/css/megamenu.css" rel="stylesheet"
   type="text/css" media="all" />
<script type="text/javascript" src="/resources/js/megamenu.js"></script>
<script>$(document).ready(function(){$(".megamenu").megamenu();});</script>
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
<!----start-pricerage-seletion---->
<script type="text/javascript" src="/resources/js/jquery-ui.min.js"></script>
<link rel="stylesheet" type="text/css"
   href="/resources/css/jquery-ui.css">
<script type='text/javascript'>//<![CDATA[ 
         $(window).load(function(){
          $( "#slider-range" ).slider({
                     range: true,
                     min: 0,
                     max: 500,
                     values: [ 100, 400 ],
                     slide: function( event, ui ) {  $( "#amount" ).val( "$" + ui.values[ 0 ] + " - $" + ui.values[ 1 ] );
                     }
          });
         $( "#amount" ).val( "$" + $( "#slider-range" ).slider( "values", 0 ) + " - $" + $( "#slider-range" ).slider( "values", 1 ) );
         
         });//]]>  
      </script>
<!----//End-pricerage-seletion---->
<!---move-top-top---->
<script type="text/javascript" src="/resources/js/move-top.js"></script>
<script type="text/javascript" src="/resources/js/easing.js"></script>
<script type="text/javascript">
         jQuery(document).ready(function($) {
            $(".scroll").click(function(event){      
               event.preventDefault();
               $('html,body').animate({scrollTop:$(this.hash).offset().top},1200);
            });
         });
      </script>
<!---//move-top-top---->
</head>

<body>
   <!---start-wrap---->
   <!----start-image-slider---->
   <div class="wrap">
      <p class="main_title" style="margin: 5% 0">
         <strong>NEW 가구</strong>
      </p>
   </div>
   <div class="img-slider">
      <div class="wrap">

         <ul id="jquery-demo">

            <% 
         ArrayList<ImageDTO> productImageList = (ArrayList<ImageDTO>)request.getAttribute("productImageList");
         ArrayList<ProductDTO> productList = (ArrayList<ProductDTO>)request.getAttribute("productList");
         
         for(int i = 0; i < productImageList.size(); i++){
            pageContext.setAttribute("image", productImageList.get(i));
            pageContext.setAttribute("product", productList.get(i));
         %>
         
            <li><a href="/getFurniture?id=${product.id}"> 
            <img src="${image.path}" alt="" />
            </a>
               <div class="slider-detils">
                  <h3>
                     <label>${product.name}</label>
                  </h3>
                  <span>${product.brand}</span> 
                  <a class="slide-btn" href="/getFurniture?id=${product.id}"> Shop Now</a>
               </div>
               </li>

            <%}
         %> <!--
           <li>
             <a href="#slide1">
               <img src="images/slide-1.jpg" alt="" />
             </a>
             <div class="slider-detils">
                <h3>MENS FOOT BALL <label>BOOTS</label></h3>
                <span>Stay true to your team all day, every day, game day.</span>
                <a class="slide-btn" href="details.html"> Shop Now</a>
             </div>
           </li>
           <li>
             <a href="#slide2">
               <img src="images/slide-4.jpg"  alt="" />
             </a>
              <div class="slider-detils">
                <h3>MENS FOOT BALL <label>BOOTS</label></h3>
                <span>Stay true to your team all day, every day, game day.</span>
                <a class="slide-btn" href="details.html"> Shop Now</a>
             </div>
           </li>
           <li>
             <a href="#slide3">
               <img src="images/slide-1.jpg" alt="" />
             </a>
              <div class="slider-detils">
                <h3>MENS FOOT BALL <label>BOOTS</label></h3>
                <span>Stay true to your team all day, every day, game day.</span>
                <a class="slide-btn" href="details.html"> Shop Now</a>
             </div>
           </li>-->
         </ul>
      </div>
   </div>
   <div class="clear"></div>
   <!----//End-image-slider---->
   <!----start-price-rage--->
   <div class="wrap">
      <div class="main_title">
         <p>
            <strong>오늘의 게시물</strong>
         </p>
      </div>
   </div>
   <!----//End-price-rage--->
   <!--- start-content---->
   <div class="content">
      <div class="wrap" style="width: 90%">
         <div class="content-right">
            <div class="product-grids">
               <!---caption-script---->
               <!---//caption-script---->
               <!-- 게시물 정보1 시작-->
               
               <% 
         ArrayList<ImageDTO> boardImageList = (ArrayList<ImageDTO>)request.getAttribute("boardImageList");
         ArrayList<BoardDTO> boardList = (ArrayList<BoardDTO>)request.getAttribute("boardList");
         
         for(int i = 0; i < boardImageList.size(); i++){
            pageContext.setAttribute("boardImage", boardImageList.get(i));
            pageContext.setAttribute("board", boardList.get(i));
            %>
            
            <div class="product-grid fade" onclick = "location.href='getBoard?no=${board.boardId}'">
                     <div class="product-grid-head">
                        <ul class="grid-social">
                           <li><a class="facebook" href="#"><span> </span></a></li>
                           <li><a class="twitter" href="#"><span> </span></a></li>
                           <li><a class="googlep" href="#"><span> </span></a></li>
                           <div class="clear"></div>
                        </ul>
                        <div class="block">
                           <div class="starbox small ghosting"></div>
                           <span> </span>
                        </div>
                     </div>
                     <div class="product-pic">
                        <a href="#"><img src="${boardImage.path}" title="product-name" /></a>
                        <p>
                           <a href="#"> ${board.title}</a> <span>♥ ${board.likeCnt}</span>
                        </p>
                     </div>
                     <div class="product-info">
                        <div class="product-info-cust">
                           <!-- <a href="details.html">Details</a>  -->
                        </div>
                        <div class="product-info-price">
                           <a></a>
                        </div>
                        <div class="clear"></div>
                     </div>
                     <div class="more-product-info">
                        <span> </span>
                     </div> 
                  </div>
                  
            <%}%>
                  

               

               <!-- 상품 정보1 끝-->
               <!--   <div onclick="location.href='details.html';"  class="product-grid fade">
                     <div class="product-grid-head">
                        <ul class="grid-social">
                           <li><a class="facebook" href="#"><span> </span></a></li>
                           <li><a class="twitter" href="#"><span> </span></a></li>
                           <li><a class="googlep" href="#"><span> </span></a></li>
                           <div class="clear"> </div>
                        </ul>
                        <div class="block">
                           <div class="starbox small ghosting"> </div> <span> </span>
                        </div>
                     </div>
                     <div class="product-pic">
                        <a href="#"><img src="images/product1.jpg" title="product-name" /></a>
                        <p>
                        <a href="#"><small>Nike</small> HYPERVENOM <small>Phantom</small> FG</a>
                        <span>Men's Firm-Ground Football Boot</span>
                        </p>
                     </div>
                     <div class="product-info">
                        <div class="product-info-cust">
                           // <a href="details.html">Details</a> 
                        </div>
                        <div class="product-info-price">
                           <a href="details.html">&#163; 375</a>
                        </div>
                        <div class="clear"> </div>
                     </div>
                     <div class="more-product-info">
                        <span> </span>
                     </div>
                  </div>
                  <div onclick="location.href='details.html';"  class="product-grid fade last-grid">
                     <div class="product-grid-head">
                        <ul class="grid-social">
                           <li><a class="facebook" href="#"><span> </span></a></li>
                           <li><a class="twitter" href="#"><span> </span></a></li>
                           <li><a class="googlep" href="#"><span> </span></a></li>
                           <div class="clear"> </div>
                        </ul>
                        <div class="block">
                           <div class="starbox small ghosting"> </div> <span> </span>
                        </div>
                     </div>
                     <div class="product-pic">
                        <a href="#"><img src="images/product3.jpg" title="product-name" /></a>
                        <p>
                        <a href="#"><small>Nike</small> HYPERVENOM <small>Phantom</small> FG</a>
                        <span>Men's Firm-Ground Football Boot</span>
                        </p>
                     </div>
                     <div class="product-info">
                        <div class="product-info-cust">
                           // <a href="details.html">Details</a> 
                        </div>
                        <div class="product-info-price">
                           <a href="details.html">&#163; 350</a>
                        </div>
                        <div class="clear"> </div>
                     </div>
                     <div class="more-product-info">
                        <span> </span>
                     </div>
                  </div>
                  <div onclick="location.href='details.html';"  class="product-grid fade">
                     <div class="product-grid-head">
                        <ul class="grid-social">
                           <li><a class="facebook" href="#"><span> </span></a></li>
                           <li><a class="twitter" href="#"><span> </span></a></li>
                           <li><a class="googlep" href="#"><span> </span></a></li>
                           <div class="clear"> </div>
                        </ul>
                        <div class="block">
                           <div class="starbox small ghosting"> </div> <span> </span>
                        </div>
                     </div>
                     <div class="product-pic">
                        <a href="#"><img src="images/product4.jpg" title="product-name" /></a>
                        <p>
                        <a href="#"><small>Nike</small> HYPERVENOM <small>Phantom</small> FG</a>
                        <span>Men's Firm-Ground Football Boot</span>
                        </p>
                     </div>
                     <div class="product-info">
                        <div class="product-info-cust">
                        // <a href="details.html">Details</a> 
                        </div>
                        <div class="product-info-price">
                           <a href="details.html">&#163; 370</a>
                        </div>
                        <div class="clear"> </div>
                     </div>
                     <div class="more-product-info">
                        <span> </span>
                     </div>
                  </div>
                  <div onclick="location.href='details.html';"  class="product-grid fade">
                     <div class="product-grid-head">
                        <ul class="grid-social">
                           <li><a class="facebook" href="#"><span> </span></a></li>
                           <li><a class="twitter" href="#"><span> </span></a></li>
                           <li><a class="googlep" href="#"><span> </span></a></li>
                           <div class="clear"> </div>
                        </ul>
                        <div class="block">
                           <div class="starbox small ghosting"> </div> <span></span>
                        </div>
                     </div>
                     <div class="product-pic">
                        <a href="#"><img src="images/product5.jpg" title="product-name" /></a>
                        <p>
                        <a href="#"><small>Nike</small> HYPERVENOM <small>Phantom</small> FG</a>
                        <span>Men's Firm-Ground Football Boot</span>
                        </p>
                     </div>
                     <div class="product-info">
                        <div class="product-info-cust">
                           // <a href="details.html">Details</a>
                        </div>
                        <div class="product-info-price">
                           <a href="details.html">&#163; 355</a>
                        </div>
                        <div class="clear"> </div>
                     </div>
                     <div class="more-product-info">
                        <span> </span>
                     </div>
                  </div>
                  <div onclick="location.href='details.html';"  class="product-grid fade last-grid">
                     <div class="product-grid-head">
                        <ul class="grid-social">
                           <li><a class="facebook" href="#"><span> </span></a></li>
                           <li><a class="twitter" href="#"><span> </span></a></li>
                           <li><a class="googlep" href="#"><span> </span></a></li>
                           <div class="clear"> </div>
                        </ul>
                        <div class="block">
                           <div class="starbox small ghosting"> </div> <span></span>
                        </div>
                     </div>
                     <div class="product-pic">
                        <a href="#"><img src="images/product6.jpg" title="product-name" /></a>
                        <p>
                        <a href="#"><small>Nike</small> HYPERVENOM <small>Phantom</small> FG</a>
                        <span>Men's Firm-Ground Football Boot</span>
                        </p>
                     </div>
                     <div class="product-info">
                        <div class="product-info-cust">
                        // <a href="details.html">Details</a>
                        </div>
                        <div class="product-info-price">
                           <a href="details.html">&#163; 390</a>
                        </div>
                        <div class="clear"> </div>
                     </div>
                     <div class="more-product-info">
                        <span> </span>
                     </div>
                  </div> -->
               <div class="clear"></div>
            </div>
         </div>
         <div class="clear"></div>
      </div>
   </div>
   <!--- //End-content---->
   <!---start-footer--
       <div class="footer">
         <div class="wrap">
            <div class="footer-left">
               <ul>
                  <li><a href="#">RoomGuideBook</a> <span> </span></li>
               </ul>
            </div>
          
            <div class="clear"> </div>
         </div>
      </div> 
      <!---//End-footer---->
   <!---//End-wrap---->
</body>
</html>
