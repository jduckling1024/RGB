<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<form action="/updateMember" method="post">
        <label for="" >아이디 <input type="text" name="id" id="" value = "${member.id}"></label>
        <label for="" >비밀번호 <input type="password" name="password" id="" value = "${member.password}"></label>
        <label for="" >이름 <input type="text" name="name" id="" value = "${member.name}"></label>
        <label for="" >전화번호 <input type="text" name="phoneNum" id="" value = "${member.phoneNum}"></label>
        <label for="" >주소 <input type="text" name="address" id="" value = "${member.address}"></label>
        <label for="" >이메일 <input type="text" name="email" id="" value = "${member.email}"></label>
        <input type="submit" value="회원정보 수정" >
    </form>
</body>
</html>