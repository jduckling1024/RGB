<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include file="../main/header.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<html>
<head>
<meta charset="UTF-8">
<title>회원 정보 수정</title>

<link rel="stylesheet" href="/resources/css/memberUpdate.css">

<script>
	function updateMemberInfo(){
		var pw = document.getElementById("userPw").value;
        var pwCheck = document.getElementById("checkPw").value;
        var name = document.getElementById("userName").value;
        var phoneNum = document.getElementById("userPhoneNum").value;
        var address = document.getElementById("userAddress").value;
        var email = document.getElementById("userEmail").value;
		
		if(pw === pwCheck){
        	if(name == ""){
    	        alert("이름을 입력해주세요.");
            }else if(pw == ""){
                alert("비밀번호를 입력해주세요.");
            }else if(phoneNum == ""){
                    alert("전화번호를 입력해주세요.");
            }else if(address == ""){
                    alert("주소를 입력해주세요.");
            }else if(email == ""){
                    alert("이메일을 입력해주세요.");
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
</head>
<body>
	<div class="wrap">
		<!--<div class="top">
            <div class="header">
                <p class="Title"><strong>RGB : Room Guide Book</p></strong>
                <div class="menu">
                    <ul>
                        <li class="menu1"><a href="">Store</a>
                        <li class="menu2"><a href="">Community</a>
                        <li class="menu3"><a href="">Login</a>
                        <li class="menu4"><a href="">Join</a></li>
                    </ul>
                </div>
            </div>
        </div> -->

		<div class="middle"></div>

		<div class="modifyMember">
			<div class="modify_form">

				<form name="updateInfoForm" id="authForm">
					<input type="hidden" name="redirectUrl">
					<fieldset>
						<legend class="screen_out">회원정보 수정 입력</legend>
						<div class="box_modify">
							<div class="inp_text">
								<label for="userId" class="screen_out">아이디</label> <input
									type="text" id="userId" name="id" value="${member.id}" readonly>
							</div>
							<div class="inp_text">
								<label for="userPw" class="screen_out">비밀번호</label> <input
									type="password" id="userPw" name="password">
							</div>
							<div class="inp_text">
								<label for="checkPw" class="screen_out">새 비밀번호 확인</label> <input
									type="password" id="checkPw">
							</div>
							<div class="inp_text">
								<label for="userName" class="screen_out">이름</label> <input
									type="text" id="userName" name="name" value="${member.name}">
							</div>
							<div class="inp_text">
								<label for="userPhoneNum" class="screen_out">전화번호</label> <input
									type="text" id="userPhoneNum" name="phoneNum"
									value="${member.phoneNum}">
							</div>
							<div class="inp_text">
								<label for="userAddress" class="screen_out">주소</label> <input
									type="text" id="userAddress" name="address"
									value="${member.address}">
							</div>
							<div class="inp_text">
								<label for="userEmail" class="screen_out">이메일</label> <input
									type="text" id="userEmail" name="email" value="${member.email}">
							</div>
						</div>

						<button type="button" class="btn_modify"
							onclick="updateMemberInfo();">회원정보 수정</button>
					</fieldset>
				</form>

			</div>
		</div>
		<div class="bottom">
			<br>
		</div>
	</div>
</body>
</html>