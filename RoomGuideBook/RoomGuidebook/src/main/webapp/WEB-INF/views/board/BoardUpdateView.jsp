<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<title>RoomGuideBook_JOIN</title>
<link href="/resources/css/style.css" rel='stylesheet' type='text/css' />
<link href="/resources/css/boardUpdate.css" rel='stylesheet'
	type='text/css' />
<meta name="viewport" content="width=device-width, initial-scale=1">
<script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>
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
        });
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
<script type="text/javascript" src="js/move-top.js"></script>
<script type="text/javascript" src="js/easing.js"></script>
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
	<div class="login-main">
		<div class="wrap">
			<Br>

			<div class="boardInfo-grids">

				<form action="/updateBoard" method="post" enctype="multipart/form-data">
					<div class="board">
						<div class="imageSection">
							<div class="upload-btn-wrapper">
								<button class="btn">UPLOAD A FILE</button>
								<input type="file" name="myfile" accept="image/*"
									onchange="setThumbnail1(event);" />


								<div id="image_container1">
									<img id="img" src="${image.path}" onclick="removeFunction()" />
								</div>

								<script>
                                function setThumbnail1(event) {
                                	document.querySelector("div#image_container1").removeChild(img);
                                	
                                    for (var image of event.target.files) {
                                        var reader = new FileReader();
                                        reader.onload = function (event) {
                                            var img = document.createElement("img");
                                            img.onclick = function () { document.getElementById('image_container1').removeChild(this) }; // 이미지를 다시 한번 더 클릭하면 삭제
                                            img.setAttribute("src", event.target.result);
                                            img.style.margin = "3% 10% 3% 10%";
                                            img.style.padding="3%";
                                            img.style.border = "solid 2.3px #E45D5D";
                                            img.style.width='80%';
                                            document.querySelector("div#image_container1").appendChild(img);
                                        };
                                        console.log(image);
                                        reader.readAsDataURL(image);
                                    }
                                }


                                function removeFunction(){
                                    document.getElementById('image_container1').removeChild(document.getElementById("img"));
                                }

                            </script>

							</div>
						</div>
						<div class="contentSection">
							<input type="text" id="title" name="title" value="${board.title}"
								placeholder="# 제목">
							<textarea cols="45" rows="13" id="content" name="content" placeholder="내용"> ${board.content} </textarea>


							<h1>
								<Span>
									<button type="submit" id="addBtn">UPLOAD</button>
								</Span>
							</h1>
							<input type="hidden" name="boardId" value="${board.boardId}">
							<%-- <input type="hidden" name="content" value="${board.content}"> --%>
						</div>

					</div>
				</form>

			</div>
		</div>
		<div class="clear"></div>
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