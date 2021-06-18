<%@page import="dto.ImageDTO"%>
<%@page import="dto.PaymentDTO"%>
<%@page import="dto.OrderDTO"%>
<%@page import="dto.ProductDTO"%>
<%@page import="java.util.ArrayList"%>
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
<title>RoomGuideBook_ORDERLIST</title>
<link href="/resources/css/style.css" rel='stylesheet' type='text/css' />
<link href="/resources/css/memberOrder.css" rel='stylesheet'
	type='text/css' />
<meta name="viewport" content="width=device-width, initial-scale=1">
<script type="application/x-javascript">
	 addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } 
</script>
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
	$(document).ready(function() {
		$('#demo').hide();
		$('.vticker').easyTicker();
	});
</script>
<!----start-alert-scroller---->
<!-- start menu -->
<link href="/resources/css/megamenu.css" rel="stylesheet"
	type="text/css" media="all" />
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
	
	
	var result = "${result}";
	
	if(result == "success"){
		alert("주문 취소 신청을 완료하였습니다.");
	}else if(result == "failed"){
		alert("동일한 주문 일자에 대한 주문을 모두 선택해주십시오.");
	}
	
	 function cancel(){
     	var list = document.getElementsByName("checked");
         var cnt = 0;
         for (var i = 0; i < list.length; i++) {
             if (list[i].checked) {
                 cnt++;
             }
         }
         
         if(cnt == 0){
         	alert("선택된 상품이 없습니다.");
         }else{
         	if(confirm("동일한 일자에 구매하신 상품 취소를 신청합니다. 계속 진행하시겠습니까?")){
         		var orderList = document.orderList;
         		orderList.action = "cancelOrder";
         		orderList.method = "post";
         		orderList.submit();
         	}
         }
     	
     }
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
	<div class="content product-box-main">
		<form name="orderList">
			<div class="wrap2">
				<h1>주문배송내역 조회</h1>

				<%
					ArrayList<Object[]> list = (ArrayList<Object[]>) request.getAttribute("list");
				Object[] progressNum = (Object[]) list.get(list.size() - 1);
				pageContext.setAttribute("waiting", progressNum[0]);
				pageContext.setAttribute("finished", progressNum[1]);
				pageContext.setAttribute("preparing", progressNum[2]);
				pageContext.setAttribute("delevery", progressNum[3]);
				pageContext.setAttribute("received", progressNum[4]);
				System.out.println(progressNum[1]);
				%>

				<div class="order-list container">
					<div class="order-list__menu">
						<a class="order-list__menu__list">
							<div class="order-list__menu__list__wrap">
								<div class="order-list__menu__list__title">입금대기</div>
								<%
									if (progressNum[0] == null) {
								%>
								<div class="order-list__menu__list__value">0</div>
								<%
									} else {
								%>
								<div class="order-list__menu__list__value">${waiting}</div>
								<%
									}
								%>

							</div>
						</a><a class="order-list__menu__list">
							<div class="order-list__menu__list__wrap">
								<div class="order-list__menu__list__title">결제완료</div>
								<%
									if (progressNum[1] == null) {
								%>
								<div class="order-list__menu__list__value">0</div>
								<%
									} else {
								%>
								<div class="order-list__menu__list__value">${finished}</div>
								<%
									}
								%>

							</div>
						</a><a class="order-list__menu__list">
							<div class="order-list__menu__list__wrap">
								<div class="order-list__menu__list__title">배송준비</div>
								<%
									if (progressNum[2] == null) {
								%>
								<div class="order-list__menu__list__value">0</div>
								<%
									} else {
								%>
								<div class="order-list__menu__list__value">${preparing}</div>
								<%
									}
								%>

							</div>
						</a><a class="order-list__menu__list">
							<div class="order-list__menu__list__wrap">
								<div class="order-list__menu__list__title">배송중</div>
								<%
									if (progressNum[3] == null) {
								%>
								<div class="order-list__menu__list__value">0</div>
								<%
									} else {
								%>
								<div class="order-list__menu__list__value">${delevary}</div>
								<%
									}
								%>

							</div>
						</a><a class="order-list__menu__list">
							<div class="order-list__menu__list__wrap">
								<div class="order-list__menu__list__title">배송완료</div>
								<%
									if (progressNum[4] == null) {
								%>
								<div class="order-list__menu__list__value">0</div>
								<%
									} else {
								%>
								<div class="order-list__menu__list__value">${received}</div>
								<%
									}
								%>

							</div>
						</a><a class="order-list__menu__list">
							<div class="order-list__menu__list__wrap">
								<div class="order-list__menu__list__title">구매확정</div>
								<div class="order-list__menu__list__value">0</div>
							</div>
						</a>
					</div>
					<div>

						<div class="order-list__content">



							<%
								for (int i = 0; i < list.size() - 1; i++) {
								pageContext.setAttribute("productDTO", (ProductDTO) list.get(i)[0]);
								pageContext.setAttribute("orderDTO", (OrderDTO) list.get(i)[1]);
								pageContext.setAttribute("paymentDTO", (PaymentDTO) list.get(i)[2]);
								pageContext.setAttribute("imageDTO", (ImageDTO) list.get(i)[3]);
							%>
							<div class="order-list__item">
								<div class="order-list__item__title">
									<input type="checkbox" name="checked"
										value="${orderDTO.purchaseDate}">
									<div class="order-list__item__title__order">${productDTO.id}
										| ${orderDTO.purchaseDate}</div>
								</div>
								<div class="order-list__item__production">
									<div class="order-list__item__production__wrap">
										<div class="order-list__item__production__item">
											<div class="order-list__item__production__item__wrap">
												<img class="order-list__item__production__item__img"
													src="${imageDTO.path}">
												<div class="order-list__item__production__item__info">
													<div
														class="order-list__item__production__item__info__wrap1">
														<a class="order-list__item__production__item__info__brand">${productDTO.brand}</a><a
															class="order-list__item__production__item__info__name">${productDTO.name}</a>
													</div>
													<div class="order-list__item__production__item__info__wrap">
														<div
															class="order-list__item__production__item__info__option">${productDTO.color}</div>
														<div
															class="order-list__item__production__item__info__price">${paymentDTO.amountSum}
															| ${ordertDTO.amount}</div>
														<div
															class="order-list__item__production__item__info__status">${paymentDTO.progress}</div>
													</div>
												</div>
											</div>

										</div>

									</div>

								</div>
							</div>

							<%
								}
							%>

						</div>
						<button type="button" onclick="cancel()">주문 취소</button>
					</div>
				</div>
		</form>

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


