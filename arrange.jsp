<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="org.springframework.web.context.request.SessionScope"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true"%>
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
			<!---start-header---->
			<div class="header">
				<div class="top-header">
					<div class="wrap">
						<div class="top-header-left">
							<ul>
								<!---cart-tonggle-script---->
								<script type="text/javascript">
									$(function(){
									    var $cart = $('#cart');
									        $('#clickme').click(function(e) {
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
								<div id="cart">Your Cart is Empty <span>(0)</span></div>
								<!---start-cart-bag---->
								<li><a class="info" href="#"><span> </span></a></li>
							</ul>
						</div>
						<div class="top-header-center">
							<div class="top-header-center-alert-left">
								<h3>RGB</h3>
							</div>
							<div class="top-header-center-alert-right">
								<div class="vticker">
								  <ul>
									  <li><label>Welcome to RGB: Room Guide Book</label></li>
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
				<!----start-mid-head---->
				<div class="mid-header">
					<div class="wrap">
						<div class="mid-grid-left">
							<form>
								<input type="text" placeholder="What Are You Looking for?" />
							</form>
                        </div>
                        <a class="logo" href="index2.html">
                            <img src="/resources/others/logo.PNG" width="10%"></a>
                    
						<div class="mid-grid-right">
							</div>
						<div class="clear"> </div>
					</div>
				</div>
				<!----start-bottom-header---->
							<div class="header-bottom">
								<div class="wrap">
								<!-- start header menu -->
										<ul class="megamenu skyblue">
											<li class="grid"><a class="color2" href="#">STORE</a>
												</li>
											  <li class="active grid"><a class="color4" href="#">COMMUNITY</a>
												</li>				
												<li><a class="color5" href="#">#</a>
												</li>
										</ul>
								</div>
							</div>
							</div>
							<!----//End-bottom-header---->
			<!---//End-header---->
		<!--- start-content---->
		<div class="content details-page">
			<!---start-product-details--->
			<div class="product-details">
				<div class="wrap">
					<ul class="product-head">
						<li><a href="#">2인용 리클라이너 소파</a> <span>::</span></li> <!-- product name -->
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
				<div class="details-left">	
					<div id="mydiv"></div>
				<% String filepath = (String)request.getAttribute("filepath");  %>
                 <img class="room" src="<%= filepath %>" alt="">
                 
                <form name = "posform" id = "posform" method="post">
				<input type="hidden" id="x" name="x">
				<input type="hidden" id="y" name="y">
				<input type="hidden" name="rFilepath" value="<%= filepath %>">
				<input type="hidden" id = "fFilepath" name="fFilepath" >
                   	</form>
					<div class="clear"> </div>
				</div>
				<div class="details-right">
					<div><span>방 정보: 15 × 20</span><a href="#">돌아가기</a></div>
                    <div class="arrangeImage" style="overflow:auto">
                        <img class="image" src="/resources/image_arrange_ap/fabricsopaFront.png" onclick="make()">
                        <img class="image" src="/resources/image_arrange_ap/fabricsopaFSide.png" onclick="make()">
                        <img class="image" src="/resources/image_arrange_ap/fabricsopaHide.png" onclick="make()">
                        <img class="image" src="/resources/image_arrange_ap/fabricsopaHSide.png" onclick="make()">
                   </div>
				</div>
				<div class="clear"> </div>
			</div>
			<!----product-rewies---->
			<div class="product-reviwes">
				<div class="wrap">
				<!--vertical Tabs-script-->
				<!---responsive-tabs---->
					<script src="/resources/js/easyResponsiveTabs.js" type="text/javascript"></script>
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
        
        // 드래그 함수
				let fFilepath = '';
				
				const pos = $(".room").position()
                const y = pos.top
				const x = pos.left

				$('#mydiv').css("top", y);
				$('#mydiv').css("left", x+24);

				console.log(y)
				console.log($('#mydiv').css("top"));

                function make() {
                    console.log('선택됨!')
                    var img = document.createElement('img'); // 이미지 객체 생성
        
                    fFilepath = img.src = $(event.target).attr("src");
                    $("#fFilepath").attr("value", fFilepath);
					
					
					
                    img.id = "mydivheader";
                    img.style.cursor = 'pointer'; // 커서 지정
                    img.style.position = 'absolute';    // absolute해야지 이미지위에 이미지 올라간다고했음!
					img.style.width = '300px'; // 배치할 이미지크기 여기서 지정
                    img.style.height = '150px';
                    document.getElementById('mydiv').appendChild(img); // 드래그할이미지동적생성

                }
        
                //Make the DIV element draggagle:
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
        
                        const proWidth = parseInt($("#mydivheader").css("width"));
                        const proHeight = parseInt($("#mydivheader").css("height"));
        
                        console.log("기준 offset: ("+proWidth/2+", "+proHeight/2+")");
                        console.log('x: '+ parseInt(elmnt.offsetLeft - pos1 - x + proWidth/2));
                        console.log('y: '+parseInt(elmnt.offsetTop - pos2 - y + proHeight/2)) ;
                        
                        $("#x").attr("value", parseInt(elmnt.offsetLeft - pos1 - x + proWidth/2));
                        $("#y").attr("value", parseInt(elmnt.offsetTop - pos2 - y + proHeight/2));
                        
                    }
        
                    function closeDragElement() {
                        /* stop moving when mouse button is released:*/
                        document.onmouseup = null;
                        document.onmousemove = null;
                        
                        checkValid();
                    }
				}
                
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
         
                        alert('검사 …')
                        let ax = $("#x").val()
                        let ay = $("#y").val()
                        console.log('checkValid'+size)
                        i = 0
                        
                        for(i=0; i < size; i++){
                            let x = objects[i][0]
                            let y = objects[i][1]
                            let w = objects[i][2]
                            let h = objects[i][3]
                            
                            console.log("x: "+x+" y: "+y+" w"+w+" h"+h)
                            console.log("ax: "+ax+" ay: "+ay)
                            
                            if(x<= ax && ax<=x+w && y<=ay && ay <= y+h){
                                result = false
                                break
                            }
                        }
                        
                        const form = document.posform
                        
                        if(!result){
                            let act = confirm('현재 위치에 물체가 있습니다. 그래도 놓으시겠습니까?')
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
                         alert('컬러 매칭 진행 중..');
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
                        const resultPath = temp[temp.length-1];
                        $("#mydivheader").attr("src", "\\resources\\image_result\\"+resultPath + '?' + new Date().getTime());
                        console.log($("#mydivheader").attr("src"));
                    };
			</script>
	</body>
</html>

