<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true"%>
<%@include file="../main/header.jsp"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보 조회</title>
    <link rel="stylesheet" href="/resources/css/member.css">
    
    <script>
    	var result = '${result}';
    	
    	if(result == "wrong"){
    		alert("비밀번호가 잘못되었습니다.");
    	}
    
    	function updateMember(){
    		var pw = document.getElementById("userPw").value;
    		if(pw == ""){
    			alert("비밀번호를 입력해주세요.");
    		}else{
    			var memberForm = document.memberForm;
    			memberForm.action = "updateMemberView";
    			memberForm.method = "post";
    			memberForm.submit();
    		}
    	}
    	
    	function deleteMember(){
    		var pw = document.getElementById("userPw").value;
    		
    		if(pw == ""){
    			alert("비밀번호를 입력해주세요.");
    		}else{
    			if(confirm("정말로 탈퇴하시겠습니까?")){
        			var memberForm = document.memberForm;
        			memberForm.action = "deleteMember";
        			memberForm.method = "post";
        			memberForm.submit();
        		}
    		}
    	}
    </script>
</head>
<body>
    <div class="wrap">
        <!-- <div class="top">
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

        <div class="middle"> </div>

        <div class="modifyMember">
            <div class="modify_form">

                <form name="memberForm" id="authForm">
                    <input type="hidden" name="redirectUrl">
                    <fieldset>
                        <legend class="screen_out">회원정보 수정 입력</legend>
                        <div class="box_modify">
                            <div class="inp_text">
                                <label for="userId" class="screen_out">아이디</label>
                                <p id="userId" name="id">ID : ${member.id}</p>
                                <input type="hidden" name="id" value="${member.id}">
                            </div>
                            <div class="inp_text">
                                <label for="userPw" class="screen_out">비밀번호</label>
                                <input type="password" id="userPw" name="password" placeholder="Password">
                            </div>
                            <div class="inp_text">
                                <label for="userName" class="screen_out">이름</label>
                                <p id="userName" name="name">Name : ${member.name}</p>
                                <input type="hidden" name="name" value="${member.name}">
                            </div>
                            <div class="inp_text">
                                <label for="userPhoneNum" class="screen_out">전화번호</label>
                                <p id="userPnum" name="phoneNum">PhoneNumber : ${member.phoneNum}</p>
                                <input type="hidden" name="phoneNum" value="${member.phoneNum}">
                            </div>
                            <div class="inp_text">
                                <label for="userAddress" class="screen_out">주소</label>
                                <p id="userAddress" name="address">Address : ${member.address}</p>
                                <input type="hidden" name="address" value="${member.address}">
                            </div>
                            <div class="inp_text">
                                <label for="userEmail" class="screen_out">이메일</label>
                                <p id="userEmail" name="email">E-Mail : ${member.email}</p>
                                <input type="hidden" name="email" value="${member.email}">
                            </div>
                        </div>


                        <div class="buttonGroup">
                            <ul>
                                <li><button type="submit" class="btn_modify" onclick="updateMember();">회원정보 수정</button></li>
                                <li><button type="button" class="btn_delete" onclick="deleteMember();">회원탈퇴</button></li>
                            </ul>
                        </div>

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