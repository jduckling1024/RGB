<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">

<title>Insert title here</title>
<link rel = "stylesheet" href="/resources/css/memberRegister.css">
</head>
<body>
    <div class = "wrap">
        <div class = "top">
            <div class = "header">
                <p class = "Title"><strong>RGB : Room Guide Book</p></strong>
            </div>
        </div>


        <div class = "middle"> </div>
       
        <div class="inner_join">
            <div class="join_form">

                <form action="/registerMember" method="post" id="authForm">
                    <input type="hidden" name="redirectUrl">
                    <fieldset>
                    <legend class="screen_out">회원가입 정보 입력폼</legend>
                    <div class="box_join">
                        <div class="inp_text">
                        <label for="joinId" class="screen_out">아이디</label>
                        <input type="text" id="joinId" name="id" placeholder="ID" >
                        </div>
                        <div class="inp_text">
                        <label for="joinPw" class="screen_out">비밀번호</label>
                        <input type="password" id="joinPw" name="password" placeholder="Password" >
                        </div>
                        <div class="inp_text">
                        <label for="joinName" class="screen_out">이름</label>
                        <input type="text" id="joinName" name="name" placeholder="Name" >
                        </div>
                        <div class="inp_text">
                        <label for="joinPhoneNum" class="screen_out">전화번호</label>
                        <input type="text" id="joinPhoneNum" name="phoneNum" placeholder="Phone Number" >
                        </div>
                        <div class="inp_text">
                        <label for="joinAddress" class="screen_out">주소</label>
                        <input type="text" id="joinAddress" name="address" placeholder="Address" >
                        </div>
                        <div class="inp_text">
                        <label for="joinEmail" class="screen_out">이메일</label>
                        <input type="text" id="joinEmail" name="email" placeholder="E-Mail" >
                        </div>
                    </div>

                    <button type="submit" class="btn_join">회원가입</button>
                 
                    </fieldset>
                </form>
                
            </div>
        </div>

        <br>

        <div class="bottom">
         
        </div>

    </div>
</body>
</html>