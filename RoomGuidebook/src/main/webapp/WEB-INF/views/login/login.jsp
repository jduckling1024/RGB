<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>

<link rel="stylesheet" href="/resources/css/login.css">
<script>
	var result = '${result}';

	if(result == "fail"){
		alert("아이디 및 비밀번호가 일치하지 않습니다.");
	}
</script>
</head>
<body>
	<!--     <form action = "/loginPost" method="post">
           <label>아이디 : <input type="text" name = "id"></label> 
           <label>비밀번호 : <input type="text" name = "password"></label> 
           <input type = "submit" value = "확인">
           <p>result</p>
    </form> -->
	<div class="wrap">
		<div class="top">
			<div class="header">
				<p class="Title">
					<strong>RGB : Room Guide Book</strong>
				</p>
			</div>
		</div>

		<div class="middle"></div>

		<div class="inner_login">
			<div class="login_form">
				<form action="/loginPost" method="post" id="authForm">
					<input type="hidden" name="redirectUrl">
					<fieldset>
						<legend class="screen_out">로그인 정보 입력폼</legend>
						<div class="box_login">
							<div class="inp_text">
								<label for="loginId" class="screen_out">아이디</label> <input
									type="text" id="loginId" name="id" placeholder="ID">
							</div>
							<div class="inp_text">
								<label for="loginPw" class="screen_out">비밀번호</label> <input
									type="password" id="loginPw" name="password"
									placeholder="Password">
							</div>
						</div>

						<button type="submit" class="btn_login">로그인</button>
						<div class="login_append">
							<div class="inp_chk">
								<!-- 체크시 checked 추가 -->
								<input type="checkbox" id="keepLogin" class="inp_radio"
									name="keepLogin"> <label for="keepLogin" class="lab_g">
							</div>
							<span class="img_top ico_check"></span> <span class="txt_lab">로그인
								상태 유지</span> </label>
					</fieldset>
				</form>
			</div>
		</div>

		<br>

		<div class="bottom"></div>
	</div>
</body>

</html>