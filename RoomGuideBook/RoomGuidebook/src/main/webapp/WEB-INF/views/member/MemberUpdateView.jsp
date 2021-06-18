<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@include file="../main/header.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


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
    <link href="/resources/css/memberUpdate.css" rel='stylesheet' type='text/css' />
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script
        type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } 
        </script>
    <!----webfonts---->
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
    <script type="text/javascript" src="js/move-top.js"></script>
    <script type="text/javascript" src="js/easing.js"></script>
    <script type="text/javascript">
        jQuery(document).ready(function ($) {
            $(".scroll").click(function (event) {
                event.preventDefault();
                $('html,body').animate({ scrollTop: $(this.hash).offset().top }, 1200);
            });
        });
        
        function updateMemberInfo(){
          var pw = document.getElementById("userPw").value;
            var pwCheck = document.getElementById("checkPw").value;
            var name = document.getElementById("userName").value;
            var phoneNum = document.getElementById("userPhoneNum").value;
            var address = document.getElementById("userAddress").value;
            var email = document.getElementById("userEmail").value;
          
          if(pw === pwCheck){
             
             if(name == "" || name == "" || phoneNum == "" || address == "" || email == ""){
                alert("필수 항목이 누락되었습니다.");
             }else{
                if(confirm("회원정보를 수정하시겠습니까?")){
                      var updateInfoForm = document.updateInfoForm;
                        updateInfoForm.action = "updateMember";
                        updateInfoForm.method = "post";
                        updateInfoForm.submit();
                   }
             }
          }else{
             alert("비밀번호가 일치하지 않습니다.");
          }
       }
    </script>
    <!---//move-top-top---->
</head>


<body>

    <!---//End-header---->
    <!--- start-content---->
    <div class="login-main">
        <div class="wrap">
            <h1>회원정보 수정 <span><Button id="modifyBtn" onclick="updateMemberInfo()">수정</Button><Button id="cancelBtn">취소</Button></span></h1>
           
            <div class="memberInfo-grids">
                <form name = "updateInfoForm"> 
                        <div class="memberInfo-top-grid">
                                <h3>PERSONAL INFORMATION</h3>
                                <div> 
                                    <span>ID</span>
                                    <input id="userId" type="text" name = "id" value="${member.id}" placeholder="userID" readOnly> <!--- ID는 수정못하니까 placeholder에 ID값 넣어주고 readOnly--> 
                                </div>

                                <div>
                                    <span>PASSWORD</span>
                                    <input type="password" id="userPw" name = "password"> 
                                </div>

                                <div id="none">  <!--- 간격조정 -->
                                    <span>ID</span>
                                    <input type="text"> 
                                </div>

                                <div id="tmp">
                                    <span>PASSWORD CHECK</span>
                                    <input type="password" id="checkPw"> 
                                </div>


                                <div>
                                    <span>NAME</span>
                                    <input type="text" id="userName" name="name" value="${member.name}"> 
                                </div>

                                <div>
                                    <span>PHONE NUMBER</span>
                                    <input type="text" id="userPhoneNum" name="phoneNum" value="${member.phoneNum}"> 
                                </div>
                            
                                <div>
                                    <span>ADDRESS</span>
                                    <input type="text" id="userAddress" name="address" value="${member.address}"> 
                                </div>

                                <div>
                                    <span>E-MAIL</span>
                                    <input type="text" id="userEmail" name="email" value="${member.email}">  
                                </div>
                                <div class="clear"> </div>
                        </div>
                       
                       
                        <div class="clear"> </div>
                      
                </form>
            </div>
        </div>
        <div class="clear"> </div>
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