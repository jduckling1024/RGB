 
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="org.springframework.web.context.request.SessionScope"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%> 
<%@ page session="true"%>
<%@ page import="dto.ProductDTO"%>
<%@ page import="java.util.*"%>

<!--
Author: W3layouts
Author URL: http://w3layouts.com
License: Creative Commons Attribution 3.0 Unported
License URL: http://creativecommons.org/licenses/by/3.0/
-->
<!DOCTYPE HTML>
<html>
   <head>
      <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
      <title>RGB</title>
      <link href="/resources/css/arrangeStyle.css" rel='stylesheet' type='text/css' />
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>
      </script>
      <!----webfonts---->
      <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,300,600,700,800' rel='stylesheet' type='text/css'>
      <!----//webfonts---->
      <script src="/resources/js/jquery.min.js"></script>
      <!----start-alert-scroller---->
      <script type="text/javascript" src="/resources/js/jquery.easy-ticker.js"></script>
      <script type="text/javascript">
      $(document).ready(function(){
         $('#demo').hide();
         $('.vticker').easyTicker();
      });
      </script>   
      <!----start-alert-scroller---->
      <!-- start menu -->
      <link href="/resources/css/megamenu.css" rel="stylesheet" type="text/css" media="all" />
      <script type="text/javascript" src="/resources/js/megamenu.js"></script>
      <script>$(document).ready(function(){$(".megamenu").megamenu();});</script>
      <script src="/resources/js/menu_jquery.js"></script>
      <!-- //End menu -->
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
      <!-- Owl Carousel Assets -->
      <link href="/resources/css/owl.carousel.css" rel="stylesheet">
       <!--<script src="js/jquery-1.9.1.min.js"></script> 
           Owl Carousel Assets -->
          <!-- Prettify -->
          <script src="/resources/js/owl.carousel.js"></script>
              <script>
          $(document).ready(function() {
      
            $("#owl-demo").owlCarousel({
              items : 3,
              lazyLoad : true,
              autoPlay : true,
              navigation : true,
             navigationText : ["",""],
             rewindNav : false,
             scrollPerPage : false,
             pagination : false,
             paginationNumbers: false,
            });
      
          });
          </script>
         <!-- //Owl Carousel Assets -->
   </head>
   <body>
      <!---start-wrap---->
         <!---start-header---->
   <div class="header">
      <div class="top-header">
         <div class="wrap">
            <div class="top-header-left">
               <ul>
                  <!---cart-tonggle-script---->
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
                  <!---//cart-tonggle-script---->
                  <li><a class="cart" href="#"><span id="clickme"> </span></a></li>
                  <!---start-cart-bag---->
                  <div id="cart">
                     Your Cart is Empty <span>(0)</span>
                  </div>
                  <!---start-cart-bag---->
                  <li><a class="info" href="#"><span> </span></a></li>
               </ul>
            </div>
            <div class="top-header-center">
               <div class="top-header-center-alert-left">
                  <h3></h3>
               </div>
               <div class="top-header-center-alert-right">
                  <div class="vticker">
                     <ul>
                        <li>Welcome to RGB: Room Guide Book<label></label></li>
                     </ul>
                  </div>
               </div>
               <div class="clear"></div>
            </div>
            <div class="top-header-right">
               <ul>
                  <c:choose>
                     <c:when test="${not empty session}">
                        <li><a href="/register">Welcome to RGB,
                              ${sessionScope.member.name}</a><span> </span></li>
                        <li><a href="/logout">Logout</a></li>

                     </c:when>
                     <c:otherwise>
                        <li><a href="/login">Login</a><span> </span></li>
                        <li><a href="/registerMember">Join</a></li>
                     </c:otherwise>
                  </c:choose>
               </ul>
            </div>
            <div class="clear"></div>
         </div>
      </div>

      <!----start-mid-head---->
      <div class="mid-header">
         <div class="wrap">
            <div class="mid-grid-left">
               <form action="/search" method="get">
                  <input type="text" name="product"
                     placeholder="What Are You Looking for?" />
               </form>
            </div>
            <div class="mid-grid-right">
               <a class="logo" href="index.html"><span> </span></a>
            </div>
            <div class="clear"></div>
         </div>
      </div>
      <!----//End-mid-head---->

      <!----start-bottom-header---->
      <div class="header-bottom">
         <div class="wrap">
            <!-- start header menu -->
            <ul class="megamenu skyblue">
               <li class="grid"><a class="color2" href="/getFurnitureList">STORE</a>
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
                                 <br>
                                 <br>
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
                  </div></li>
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
                  </div></li>
            </ul>

         </div>
      </div>
   </div>
      <!--- start-content---->
      <div class="content details-page">
         <!---start-product-details--->
         <div class="product-details">
            <div class="wrap">
               <ul class="product-head">
                  <li><a href="#">${productInfo.name}</a> <span>::</span></li> <!-- product name -->
                  <li class="active-page"><a href="#">배치하기</a></li>
                  <div class="clear"> </div>
               </ul>
            <!----details-product-slider--->
            <!-- Include the Etalage files -->
               <link rel="stylesheet" href="/resources/css/etalage.css">
               <script src="/resources/js/jquery.etalage.min.js"></script>
            <!-- Include the Etalage files -->
            <script>
                  jQuery(document).ready(function($){
         
                     $('#etalage').etalage({
                        thumb_image_width: 300,
                        thumb_image_height: 400,
                        source_image_width: 900,
                        source_image_height: 1000,
                        show_hint: true,
                        click_callback: function(image_anchor, instance_id){
                           alert('Callback example:\nYou clicked on an image with the anchor: "'+image_anchor+'"\n(in Etalage instance: "'+instance_id+'")');
                        }
                     });
                     // This is for the dropdown list example:
                     $('.dropdownlist').change(function(){
                        etalage_show( $(this).find('option:selected').attr('class') );
                     });

               });
            </script>
            <!----//details-product-slider--->
            <div class="details-left-container">
               <div class="details-left">   
                  <div id="mydiv"></div>
                  <img class="room" src="<spring:url value='/room_image/${filename}'/>" alt="">
                   <form name = "posform" id = "posform" method="post">
                  <input type="hidden" id="x" name="x">
                  <input type="hidden" id="y" name="y">
                  <input type="hidden" name="rFilepath" value="${filepath}">
                  <input type="hidden" id = "fFilepath" name="fFilepath" >
                  <input type="hidden" id="rWidth" name="rWidth">
                  <input type="hidden" id="rHeight" name="rHeight">
                  <input type="hidden" id="fWidth" name="fWidth">
                  <input type="hidden" id="fHeight" name="fHeight">
                  </form>
                  <div class="clear"> </div>
               </div>
            </div>
            <div class="details-right">
            
            <% pageContext.setAttribute("product", (ProductDTO)request.getAttribute("productInfo"));
            %>
            
               <div><span>방 정보: ${widthSize} × ${heightSize}</span><a href="/getFurniture?id=${product.id}">돌아가기</a></div>
                    <div class="arrangeImage" style="overflow:auto">
                        <c:forEach var="list" items="${imageList}">
                     		<img class="image" src="${list.path}">
                 		 </c:forEach>
                   </div>
            </div>
            <div class="clear"> </div>
         </div>
         <div class="wrap">
            <div class="remove">
               <a href="javascript:void(0)" id="remove_btn">배치된 가구 삭제하기</a>
            </div>
         </div>
         <!----product-rewies---->
         <div class="product-reviwes">
            <div class="wrap">
            <!--vertical Tabs-script-->
            <!---responsive-tabs---->
               <script src="js/easyResponsiveTabs.js" type="text/javascript"></script>
               <script type="text/javascript">
                  $(document).ready(function () {
                      $('#horizontalTab').easyResponsiveTabs({
                           type: 'default', //Types: default, vertical, accordion           
                           width: 'auto', //auto or any width like 600px
                           fit: true,   // 100% fit in a container
                           closed: 'accordion', // Start closed if in accordion view
                           activate: function(event) { // Callback function if tab is switched
                           var $tab = $(this);
                           var $info = $('#tabInfo');
                           var $name = $('span', $info);
                              $name.text($tab.text());
                              $info.show();
                           }
                        });
                                       
                      $('#verticalTab').easyResponsiveTabs({
                           type: 'vertical',
                           width: 'auto',
                           fit: true
                         });
                   });
               </script>
            <!---//responsive-tabs---->
            <!--//vertical Tabs-script-->
            <!--vertical Tabs-->
             <div class="clear"> </div>
      <!--- //End-content---->
      <!---start-footer---->
      <!---//End-footer---->
      <!---//End-wrap---->

        <script type="text/javascript">
        

      let fFilepath = '';
      
      let pos = $(".room").position()
      let my = pos.top*0.66// 모바일상 좌표
      let mx = pos.left*0.66
      
      let y = pos.top
      let x = pos.left

      const rw = $(".room").width();
      const rh = $(".room").height();
      const nw = document.getElementsByClassName("room")[0].naturalWidth;
      const nh = document.getElementsByClassName("room")[0].naturalHeight;
           
        function getIndex(src) {
           var arrangeImages = $('.image');
           for(var i = 0; i < arrangeImages.length; i++) {
             if (arrangeImages.eq(i).attr("src") === src) {
               return i;
             }
           }
         }
        
      <% 
         ArrayList<Integer[]> pSize = (ArrayList<Integer[]>)request.getAttribute("pSize");
         
         pageContext.setAttribute("sizeLen", pSize.size());
         %>
         const sizeArray = new Array(${sizeLen});
         var j = 0;
         <%
         for(int i = 0;i < pSize.size(); i++){
            %>
            sizeArray[j] = new Array(2);
            
            sizeArray[j][0] = <%= pSize.get(i)[0] %>
            sizeArray[j][1] = <%= pSize.get(i)[1] %>
            j++;
            <%
         }
      %>
      
       document.getElementById('remove_btn').onclick = function(){
         var mImg = document.getElementById('mydivheader');
         document.getElementById('mydiv').removeChild(mImg);
      };

        // 드래그 함수 
       //Make the DIV element draggagle:
                 
                $(".image").bind("mousedown touchstart", function(e){
                      
                  var img = document.createElement('img'); // 이미지 객체 생성
                  
                  fFilepath = img.src = $(event.target).attr("src");
                  $("#fFilepath").attr("value", fFilepath);
                  
                  img.style.cursor = 'pointer';
                  img.style.position = 'absolute';   
                  
                  var index = getIndex(fFilepath);
                  
                  var w = sizeArray[index][0] * rw/nw; //603;
                  var h = sizeArray[index][1] * rh/nh; //162;
                  var mw = w*0.6;
                  var mh = h*0.6;
                     
                  if(e.type == "touchstart"){
                     e.preventDefault();
                     var changedTouches = e.originalEvent.changedTouches;
                        var touch = changedTouches[0];
                        
                        if(document.getElementById("mobileImg") == null){
                           $("<img>").attr({
                              id: "mobileImg",
                              src: fFilepath
                           }).css({
                              position: "absolute",
                               left: mx+rw/2-mw/2+'px',
                               top: my+rh/2-mh/2+'px',
                               width: mw+'px',
                               height: mh+'px'
                           }).appendTo(document.body);
                        }
                  }
                  else if(e.type == "mousedown"){
                     img.style.width = w+'px'; // 배치할 이미지크기 여기서 지정
                          img.style.height = h+'px';
                     img.id = "mydivheader";
                          if($('#mydiv').children().size() == 0){
                             document.getElementById('mydiv').appendChild(img);
                          }
                       $('#mydiv').css("top", y+rh/2-h/2);
                       $('#mydiv').css("left", x+rw/2-w/2);
                  }
                  
            });
                    
                dragElement(document.getElementById("mydiv"));
        
                var pos1 = 0, pos2 = 0, pos3 = 0, pos4 = 0;

               function dragElement(elmnt) {

               if (document.getElementById(elmnt.id + "header")) {
                  /* if present, the header is where you move the DIV from:*/
                  document.getElementById(elmnt.id + "header").onmousedown = dragMouseDown;
               } else {
                  /* otherwise, move the DIV from anywhere inside the DIV:*/
                  elmnt.onmousedown = dragMouseDown;
               }

               function dragMouseDown(e) {
                  e = e || window.event;
                  e.preventDefault();
                  // get the mouse cursor position at startup:
                  pos3 = e.clientX;
                  pos4 = e.clientY;
                  document.onmouseup = closeDragElement;
                  // call a function whenever the cursor moves:
                  document.onmousemove = elementDrag;
               }

               function elementDrag(e) {

                  pos = $(".room").position()
                  y = pos.top
                  x = pos.left

                  e = e || window.event;
                  e.preventDefault();
                  // calculate the new cursor position:
                  pos1 = pos3 - e.clientX;
                  pos2 = pos4 - e.clientY;
                  pos3 = e.clientX;
                  pos4 = e.clientY;
                  // set the element's new position:
                  elmnt.style.top = (elmnt.offsetTop - pos2) + "px";
                  elmnt.style.left = (elmnt.offsetLeft - pos1) + "px";

                  const productWidth = parseInt($("#mydivheader").css("width"));
                  const productHeight = parseInt($("#mydivheader").css("height"));

                  console.log("기준 offset: ("+ productWidth /2+", "+productHeight/2+")");

                  let productLeft = elmnt.offsetLeft - pos1;
                  let productTop = elmnt.offsetTop - pos2;
                  
                  $("#x").attr("value", parseInt(productLeft - x + productWidth/2));
                  $("#y").attr("value", parseInt(productTop - y + productHeight/2));
                  
                  if(productLeft <= x){ 
                     elmnt.style.left = x + "px";
                  }
                  else if(productLeft + productWidth >= x + rw){ 
                     elmnt.style.left = (x + rw - productWidth) + "px";
                  }

                  if(productTop <= y){
                     elmnt.style.top = y + "px";
                  }
                  else if(productTop + productHeight >= y + rh){ 
                     elmnt.style.top = (y + rh - productHeight) + "px";
                  }
               }

               function closeDragElement() {
                  /* stop moving when mouse button is released:*/
                  document.onmouseup = null;
                  document.onmousemove = null;
                  
                  checkValid();
               }
            }
               
               
                // start 모바일 드래그 코드
                
                // 삭제 버튼
            document.getElementById('remove_btn').onmousedown = function(){
               $("#mobileImg").remove();
            }
                
                // touchmove events occur when you drag your finger
              $(".room").on("touchmove", function(e) {
                  e.preventDefault();
                  
                  var changedTouches = e.originalEvent.changedTouches;
                  
                      var touch = changedTouches[0];
                      $("#mobileImg").css({
                          left: touch.pageX,
                          top: touch.pageY
                      });
                      
                      
              });
              
              // touchend events occur when you lift your finger
              $(".room").on("touchend", function(e) {
                  e.preventDefault();
                  
                  var changedTouches = e.originalEvent.changedTouches;
                  var touch = changedTouches[0];
                  
                  pos = $(".room").position()
                  y = pos.top
                  x = pos.left
                  
                  const productWidth = parseInt($("#mobileImg").css("width"));
                  const productHeight = parseInt($("#mobileImg").css("height"));

                  let productLeft = touch.pageX;
               let productTop = touch.pageY;
               var mImg =  document.getElementById("mobileImg");
               
               if(productLeft <= mx){  
                  mImg.style.left = mx + "px";
               }
               else if(productLeft + productWidth >= mx + rw){ 
                  mImg.style.left = (mx + rw - productWidth) + "px";
               }

               if(productTop <= my){
                  mImg.style.top = my + "px";
               }
               else if(productTop + productHeight >= my + rh){  
                  mImg.style.top = (my + rh - productHeight) + "px";
               }
               $("#x").attr("value", parseInt(productLeft - mx + productWidth/2));
               $("#y").attr("value", parseInt(productTop- my + productHeight/2));
                  checkValid();
              });
              
              // touchcancel events occur when you switch to a different program
              // or do something to interrupt the stream of touch events
              $(".room").on("touchcancel", function(e) {
                  e.preventDefault();
                  
                  var changedTouches = e.originalEvent.changedTouches;
                  $("#mobileImg").remove();
              });
                
                //  end 모바일 드래그 코드
                
                // 사용자가 방 이미지를 업로드하면 폴더에 저장해두고
               // 새로 부를 때 jsp에 경로를 전송해서 새로고침하는 효과
               <% 
                     int size = (Integer)request.getAttribute("size");
                     String detectedObject = (String)request.getAttribute("objects"); // 쿠키에 값이 없다면, attr를 통해 받음
               %>
               
               const size = <%= size %>
               const objects = new Array(size)
               <% int i = 0; %>

               <% StringTokenizer st = new StringTokenizer(detectedObject, "#");
                  while(st.hasMoreTokens()){
                     String x = st.nextToken();
                     String y = st.nextToken();
                     String w = st.nextToken();
                     String h = st.nextToken(); %>
                     objects[<%= i %>] = new Array(4)
                     objects[<%= i %>][0] = <%= x %>
                     objects[<%= i %>][1] = <%= y %>
                     objects[<%= i %>][2] = <%= w %>
                     objects[<%= i %>][3] = <%= h %>
                     <% i++; %>
                  <%}%>
                  
               
                    let result = true
                    
                    const checkValid = function () {
         
                        let ax = $("#x").val()
                        let ay = $("#y").val()
                        
                        i = 0
                        
                        console.log('실제: '+nw);
                        console.log('변형된: '+rw);
                        

                        console.log("ax: "+ax+" ay: "+ay)
                        
                        for(i=0; i < size; i++){
                           let x = parseInt(objects[i][0] * rw / nw);
                           let y = parseInt(objects[i][1] * rh / nh);
                           let w = parseInt(objects[i][2] * rw / nw);
                           let h = parseInt(objects[i][3] * rh / nh);
                            
                            console.log("x: "+x+" y: "+y+" w"+w+" h"+h)
                            
                            if((x <= ax && x+w >= ax)&&(y <= ay && y+h >= ay)){
                                result = false
                                break
                            }
                        }
                        
                        const form = document.posform
                        
                        if(!result){
                            let act = confirm('현재 위치에 물체가 있습니다. 그래도 놓으시겠습니까?')
                            result = true;
                            if(!act){
                                document.location.reload(true);
                                return;
                            }
                        }
                        
                        transferColor();
                        //return true;
                        // tfColor 컨트롤러 호출
                    };
                    
                    const transferColor = function(){
                       
                        $("#rWidth").attr("value", rw);
                        $("#rHeight").attr("value", rh);
                        
                        if(document.getElementById("mydivheader") != null){
                           $("#fWidth").attr("value", 
                                   $("#mydivheader").width());
                           $("#fHeight").attr("value", 
                                   $("#mydivheader").height());
                        }
                        else{
                            $("#fWidth").attr("value", 
                                     $("#mobileImg").width());
                             $("#fHeight").attr("value", 
                                     $("#mobileImg").height());
                        }
                        
                        
                        $.ajax({
                                type: 'post',
                                url: '/transferColor',
                                data: $("#posform").serialize(),
                                error : function(){
                                    alert('실패!');
                                },
                                complete: function(){
                                    arrangeImage();
                                }
                            })
                            
                    };
                    
                    function arrangeImage(){
                        let temp = fFilepath.split('\\');
                        const resultName = temp[temp.length-1];
                        if(document.getElementById("mydivheader") != null){
                           $("#mydivheader").attr("src", "/resources/image_result/"+resultName + '?' + new Date().getTime());
                        }
                        else{
                           $("#mobileImg").attr("src", "/resources/image_result/"+resultName + '?' + new Date().getTime());
                        }
                    };
         </script>
   </body>
</html>