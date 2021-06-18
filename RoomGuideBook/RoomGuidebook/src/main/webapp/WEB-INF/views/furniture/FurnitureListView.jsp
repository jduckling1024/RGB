<%@page import="java.text.DecimalFormat"%>
<%@page import="dto.LikeDTO"%>
<%@page import="dto.BoardDTO"%>
<%@page import="dto.ImageDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="org.springframework.web.context.request.SessionScope"%>
<%@ page session="true"%>
<%@ page import="dto.ProductDTO"%>
<%@ page import="java.util.*"%>
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
<title>RoomGuideBook_USER_PRODUCTLIST</title>
<link href="/resources/css/furnitureStyle.css" rel='stylesheet' type='text/css' />
<link href="/resources/css/furnitures.css" rel='stylesheet'
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
<script>
        function submitBrand() {
            var brand = document.forms['brandForm'];
            var brandForm = document.brandForm;
            brand.product.value = "brand_" + brand.product.value;
            brandForm.action = "search?product";
            brandForm.method = "get";
            brandForm.submit();
        }
    
        function submitPrice() {
            var price = document.forms['priceInfoForm'];
            alert(price.min.value);
            alert(price.max.value);
            var range = document.forms['priceForm'];
            var target = document.priceForm;
            range.minToMax.value = "price_" + price.min.value + "~"
                    + price.max.value;
            target.action = "search?product";
            target.method = "get";
            target.submit();
        }
        
        
    </script>
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
                    <form action="/search">
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
	<div class="content product-box-main">
		<div class="wrap">
			<div class="content-left">
				<div class="content-left-top-brands">
					<h3>CATEGORIES</h3>

					<div class="wrapper">
						<ui class="mainMenu">
						<li class="item" id="id1"><a href="#id1" class="btn"><i></i>거실가구</a>
							<div class="subMenu">
								<a href="/search?product=category_소파">소파</a> <a
									href="/search?product=category_거실수납장TV장">거실수납장/TV장</a>
							</div></li>
						<li class="item" id="id2"><a href="#id2" class="btn"><i></i>침실가구</a>
							<div class="subMenu">
								<a href="/search?product=category_침대">침대</a> <a
									href="/search?product=category_화장대">화장대</a> <a
									href="/search?product=category_거울">거울</a>
							</div></li>
						<li class="item" id="id3"><a href="#id3" class="btn"><i></i>드레스룸</a>
							<div class="subMenu">
								<a href="/search?product=category_옷장">옷장</a> <a
									href="/search?product=category_행거">행거</a>
							</div></li>
						<li class="item" id="id4"><a href="#id4" class="btn"><i></i>주방가구</a>
							<div class="subMenu">
								<a href="/search?product=category_식탁">식탁</a> <a
									href="/search?product=category_주방수납">주방수납</a>
							</div></li>
						<li class="item" id="id5"><a href="#id5" class="btn"><i></i>학생/서재가구</a>
							<div class="subMenu">
								<a href="/search?product=category_책상">책상</a> <a
									href="/search?product=category_책장">책장</a>
							</div></li>
						<li class="item" id="id6"><a href="#id6" class="btn"><i></i>수납가구</a>
							<div class="subMenu">
								<a href="/search?product=category_수납장">수납장</a>
							</div></li>
						<li class="item" id="id7"><a href="#id7" class="btn"><i></i>테이블</a>
							<div class="subMenu">
								<a href="/search?product=category_좌식테이블">좌식테이블</a>
							</div></li>
						<li class="item" id="id8"><a href="#id8" class="btn"><i></i>의자</a>
							<div class="subMenu">
								<a href="/search?product=category_일반의자">일반의자</a> <a
									href="/search?product=category_좌식의자">좌식의자</a> <a
									href="/search?product=category_스툴">스툴</a>
							</div></li>
						</ui>
					</div>
				</div>
			</div>
			<div class="content-right product-box">
				<div class="product-box-head">
					<div class="product-box-head-left">
						<h3>
							Products <span>(${proLen})</span>
						</h3>
					</div>
					<div class="product-box-head-right">
						<ul>
							<li><span>Sort ::</span><a href="#"> </a></li>
							<li><label> </label> <a href="/search?product=sort_new">
									NEW</a></li>
							<li><label> </label> <a href="/search?product=sort_popular">
									POPULAR</a></li>
							<li><label> </label> <a
								href="/search?product=sort_highPrice"> HIGH PRICE</a></li>
							<li><label> </label> <a href="/search?product=sort_lowPrice">
									LOW PRICE</a></li>
						</ul>
					</div>
					<div class="clear"></div>
				</div>

				<div class="product-filter">
					<table>
						<tr style="border: 1px solid #EEE; padding:9% 0">
							<td style="border: 1px solid #EEE; padding: 2% 0"><h3>BRAND</h3></td>
							<td class="category" style="border: 1px solid #EEE">
								<ul>
									<li><a href="/search?product=brand_이케아" name="product"
										value="brand_이케아">이케아 </a>
									<li><a href="/search?product=brand_한샘" name="product"
										value="brand_한샘">한샘 </a>
									<li><a href="/search?product=brand_마켓비" name="product"
										value="brand_마켓비">마켓비</a>
									<li><strong><p>직접입력</p></strong></li>
									<form name="brandForm">
										<li><input type="text" name="product">
										<li><input class="okButton" type="submit"
											onclick="submitBrand(this);" value="확인"></li>
									</form>
								</ul>
							</td>
						</tr>
						<tr style="padding:5% 0">
							<td style="border: 1px solid #EEE; padding: 2% 0"><h3>PRICE</h3></td>
							<td class="category" style="border: 1px solid #EEE">
								<ul>
									<li><a href="/search?product=price_0~50000">5만원 이하 </a></li>
									<li><a href="/search?product=price_50000~100000">5만원 ~
											10만원 </a></li>
									<li><a href="/search?product=price_100000~150000">10만원
											~ 15만원</a></li>
									<li><strong><p>직접입력</p></strong> <!-- <form name="priceInfoForm" style="display: inline-block"> -->
									<li><input type="text" name="min"></li>
									<li><p>~</p></li>
									<li><input type="text" name="max"></li>
									<li><input class="okButton" type="button"
										onclick="submitPrice()" value="확인"></li>
									<!-- </form> -->
									<form name="priceForm">
										<input type="hidden" name="minToMax">
									</form>
								</ul>
							</td>
						</tr>
						<tr style="padding:7% 0">
							<td style="border: 1px solid #EEE; padding: 2% 0"><h3>COLOR</h3></td>
							<td class="category" style="border: 1px solid #EEE">
								<ul>
									<li><a href="/search?product=color_red" title="빨간색"
										class="red">red</a>
									<li><a href="/search?product=color_orange" title="주황색"
										class="orange">orange</a>
									<li><a href="/search?product=color_yellow" title="노란색"
										class="yellow">yellow</a>
									<li><a href="/search?product=color_yellowGreen"
										title="연두색" class="yellow-green">yellow-green</a>
									<li><a href="/search?product=color_green" title="초록색"
										class="green">green</a>
									<li><a href="/search?product=color_skyBlue" title="하늘색"
										class="sky-blue">sky-blue</a>
									<li><a href="/search?product=color_navy" title="남색"
										class="navy">navy</a>
									<li><a href="/search?product=color_white" title="흰색"
										class="white">white</a>
									<li><a href="/search?product=color_gray" title="회색"
										class="gray">gray</a>
									<li><a href="/search?product=color_black" title="검은색"
										class="black">black</a></li>
								</ul>
							</td>
						</tr>
					</table>
				</div>

				<div class="product-grids">
					<!--- start-rate---->
					<!-- <script src="resources/js/jstarbox.js"></script>
                    <link rel="stylesheet" href="/resources/css/jstarbox.css" type="text/css" media="screen"
                        charset="utf-8" />
                    <script type="text/javascript">
                        jQuery(function () {
                            jQuery('.starbox').each(function () {
                                var starbox = jQuery(this);
                                starbox.starbox({
                                    average: starbox.attr('data-start-value'),
                                    changeable: starbox.hasClass('unchangeable') ? false : starbox.hasClass('clickonce') ? 'once' : true,
                                    ghosting: starbox.hasClass('ghosting'),
                                    autoUpdateAverage: starbox.hasClass('autoupdate'),
                                    buttons: starbox.hasClass('smooth') ? false : starbox.attr('data-button-count') || 5,
                                    stars: starbox.attr('data-star-count') || 5
                                }).bind('starbox-value-changed', function (event, value) {
                                    if (starbox.hasClass('random')) {
                                        var val = Math.random();
                                        starbox.next().text(' ' + val);
                                        return val;
                                    }
                                })
                            });
                        });
                    </script> -->
					<!---//End-rate---->
					<br>
					<br>
					<div class="pList">
						<%
                            ArrayList<Object[]> list = (ArrayList<Object[]>) request.getAttribute("list");
        
                            DecimalFormat formatter = new DecimalFormat("#,###");
                            
                        for (int i = 0; i < list.size(); i++) {
                            pageContext.setAttribute("product", (ProductDTO) list.get(i)[0]);
                            pageContext.setAttribute("image", (ImageDTO) list.get(i)[1]);
                            
                            
                          	int price = ((ProductDTO)list.get(i)[0]).getPrice();
                          	pageContext.setAttribute("price", formatter.format(price));
                        %>




						<div class="product-grid fade"
							onclick="location.href='details.html';">
							<div class="product-pic">
								<!--- image --->
								<a href="/getFurniture?id=${product.id}"> <img
									src="${image.path}" title="product-name" /></a>
								<p>
									<!--- info --->
									<span>${product.brand}</span> <a href="#">${product.name}</a>
							</div>
							<div class="product-info">
								<div class="product-info-price">
									<!--- price --->
									<a href="details.html">${price} KRW</a>
								</div>
								<div class="clear"></div>
							</div>
						</div>

						<%
                            }
                        %>

					</div>
					</br>
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