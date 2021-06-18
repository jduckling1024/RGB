<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<title>RoomGuideBook_JOIN</title>
<link href="/resources/css/style.css" rel='stylesheet' type='text/css' />
<link href="/resources/css/member.css" rel='stylesheet' type='text/css' />
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

	var result = '${result}';

	if (result == "wrong") {
		alert("비밀번호가 잘못되었습니다.");
	}

	function updateMember() {
		var pw = document.getElementById("password").value;
		if (pw == "") {
			alert("비밀번호를 입력해주세요.");
		} else {
			var memberForm = document.memberForm;
			memberForm.action = "updateMemberView";
			memberForm.method = "post";
			memberForm.submit();
		}
	}

	function deleteMember() {
		var pw = document.getElementById("password").value;

		if (pw == "") {
			alert("비밀번호를 입력해주세요.");
		} else {
			if (confirm("정말로 탈퇴하시겠습니까?")) {
				var memberForm = document.memberForm;
				memberForm.action = "deleteMember";
				memberForm.method = "post";
				memberForm.submit();
			}
		}
	}
</script>
<!---//move-top-top---->
</head>


<body>

	<!--- start-content---->
	<div class="login-main">
		<div class="wrap">
			<h1>
				회원정보 조회 <span><Button id="updateMember" type="button"
						onclick="updateMember();">회원정보 수정</Button>
					<Button id="deleteMember" type="button" onclick="deleteMember();">회원탈퇴</Button></span>
			</h1>

			<div class="memberInfo-grids">
				<form name="memberForm">
					<div class="memberInfo-top-grid">
						<h3>PERSONAL INFORMATION</h3>
						<div>
							<span>ID</span>
							<p id="userId" name="id">${member.id}</p>
						</div>

						<div>
							<span>PASSWORD</span>
							<p id="userPw" name="password">
								<input id="password" type="password" name="password">
							</p>
						</div>

						<div>
							<span>NAME</span>
							<p id="userName" name="name">${member.name}</p>
						</div>

						<div>
							<span>PHONE NUMBER</span>
							<p id="userPhoneNum" name="phoneNum">${member.phoneNum}</p>
						</div>

						<div>
							<span>ADDRESS</span>
							<p id="userAddress" name="address">${member.address}</p>
						</div>

						<div>
							<span>E-MAIL</span>
							<p id="userAddress" name="eamil">${member.email}</p>
						</div>

						<input type="hidden" name="id" value="${member.id}"> <input
							type="hidden" name="name" value="${member.name}"> <input
							type="hidden" name="phoneNum" value="${member.phoneNum}">
						<input type="hidden" name="address" value="${member.address}">
						<input type="hidden" name="email" value="${member.email}">

						<div class="clear"></div>
					</div>


					<div class="clear"></div>

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