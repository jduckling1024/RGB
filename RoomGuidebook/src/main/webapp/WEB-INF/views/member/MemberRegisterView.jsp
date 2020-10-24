<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
    <form action="/registerMember" method="post">
        <label for="" >아이디 <input type="text" name="id" id=""></label>
        <label for="" >비밀번호 <input type="password" name="password" id=""></label>
        <label for="" >이름 <input type="text" name="name" id=""></label>
        <label for="" >전화번호 <input type="text" name="phoneNum" id=""></label>
        <label for="" >주소 <input type="text" name="address" id=""></label>
        <label for="" >이메일 <input type="text" name="email" id=""></label>
        <input type="submit" value="확인" >
    </form>
</body>
</html>