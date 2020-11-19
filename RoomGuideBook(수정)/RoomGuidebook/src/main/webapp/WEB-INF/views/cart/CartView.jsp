<%@page import="java.text.DecimalFormat"%>
<%@page import="org.springframework.web.context.request.SessionScope"%>
<%@page import="dto.CartDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="dto.ProductDTO"%>
<%@ page import="dto.ImageDTO"%>
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
    <title>장바구니</title>
    <link href="/resources/css/style.css" rel='stylesheet' type='text/css' />
    <link href="/resources/css/cart.css" rel='stylesheet' type='text/css' />
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script
        type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>
    </script>
    <!--webfonts---->
    <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,300,600,700,800' rel='stylesheet' type='text/css'>
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
    <link href="/resources/css/megamenu.css" rel="stylesheet" type="text/css" media="all" />
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
    <script type="text/javascript">
        var result = '${deleteCartResult}';
    
        if (result == "success") {
            alert("장바구니 내역 삭제를 완료하였습니다.");
        } else if (result == "fail") {
            alert("알 수 없는 오류로 인해 장바구니 삭제 처리를 실패했습니다.");
        }
    
        function deleteCartList() {
    
            var list = document.getElementsByName("checked");
            var cnt = 0;
            for (var i = 0; i < list.length; i++) {
                if (list[i].checked) {
                    cnt++;
                }
            }
    
            if (cnt == 0) {
                alert("선택한 상품이 없습니다.");
            } else {
                if (confirm("정말로 삭제하시겠습니까?")) {
                    var cartForm = document.cartForm;
                    cartForm.action = "deleteCart";
                    cartForm.method = "post";
                    cartForm.submit();
                }
            }
        }
        
        function buy(){
            if(confirm("구매 창으로 이동하시겠습니까?")){
                var cartForm = document.cartForm;
                cartForm.action = "getOrderView";
                cartForm.method = "post";
                cartForm.submit(); 
                <%-- <%
                pageContext.forward("/getListForMember");
                %> --%>
            }
        } 
    </script>
</head>
<body>
    <!--- start-content---->
    <div class="content product-box-main">
        <div class="wrap">
            <div class="container">
                <form name="cartForm">
                    <div class="leftSection">
                        <div class="mainTitle">
                            <p class="main_title"><strong>주문내역</strong> <button type = "button" class = "deleteBtn" onclick="deleteCartList();">삭제</button></p>
                    
                    <br>
                        </div>
                        <br>
                        <div class="cartList">
                            <%
							ArrayList<Object[]> cartList = (ArrayList<Object[]>) request.getAttribute("cartList");
							DecimalFormat formatter = new DecimalFormat("#,###");
							
							
                          	
							
						for (int i = 0; i < cartList.size(); i++) {
							
							CartDTO cart = (CartDTO) cartList.get(i)[0];
							ProductDTO product = (ProductDTO) cartList.get(i)[1];
							ImageDTO image = (ImageDTO) cartList.get(i)[2];
							
							int price = product.getPrice();
		                    pageContext.setAttribute("price", formatter.format(price));

							pageContext.setAttribute("cart", cart);
							pageContext.setAttribute("product", product);
							pageContext.setAttribute("image", image);
						%>
                            <div class="each">
                                <img src="${image.path}"
                                    alt="" class="productImage" width="150px" height="150px">
                                <div class="infoSection">
                                    <ul>
                                        <!--- &nbsp; 공백 간격맞추느라 넣어둔거-->
                                        <li class="list">
                                            <p class="listHead">상품명&nbsp;&nbsp;&nbsp;<span>${product.name}</span></p>
                                        </li>
                                        <li class="list">
                                            <p class="listHead">
                                                개수&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span>${cart.count}</span></p>
                                        </li>
                                        <li class="list">
                                            <p class="listHead">
                                                가격&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span>${price} KRW</span></p>
                                        </li>
                                    </ul>
                                    <label class="ccontainer">
                                        <input type="checkbox" name = "checked" value = "${product.id}">
                                        <span class="checkForDelete"></span>
                                    </label>
                                </div>
                            </div>
                            <%} %>
                        </div>
                    </div>
                    <div class="rightSection">
                        <div class="priceInfo">
                        
                        <% int productSum = (Integer)request.getAttribute("productSum");
                        int delevaryFee = (Integer)request.getAttribute("delevaryFee");
                        int priceSum = (Integer)request.getAttribute("priceSum");
                        
                        pageContext.setAttribute("productSum", formatter.format(productSum));
                        pageContext.setAttribute("delevaryFee", formatter.format(delevaryFee));
                        pageContext.setAttribute("priceSum", formatter.format(priceSum));
                        %>
                        <table class="priceInfoTable">
                                <tr>
                                    <th>총 상품금액</th>
                                    <td>${productSum} KRW</td>
                                </tr>
                                <tr>
                                    <th>총 배송비</th>
                                    <td>${delevaryFee} KRW</td>
                                </tr>
                                <tr>
                                    <th>결제금액</th>
                                    <td>${priceSum} KRW</td>
                                </tr>
                            </table>
                                <input type="hidden" name="productSum" value="${productSum}">
                                <input type="hidden" name="delevaryFee" value="${delevaryFee}">
                                <input type="hidden" name="priceSum" value="${priceSum}"> 
                            <button type="button" class="btn_purchase" onclick="buy();">구매하기</button>
                        </div>
                    </div>
                <input type="hidden" name="productId" value="-1">
            </form>
            </div>
            <div class="clear"> </div>
        </div>
    </div>
    <!---- start-bottom-grids---->
    <div class="bottom-grids">

        <div class="bottom-bottom-grids">

        </div>
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

            <div class="clear"> </div>
        </div>
    </div>
    <!---//End-footer---->
    <!---//End-wrap---->
</body>

</html>