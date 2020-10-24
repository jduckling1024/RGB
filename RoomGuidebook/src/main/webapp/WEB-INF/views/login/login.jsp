<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
    <form action = "/loginPost" method="post">
           <label>아이디 : <input type="text" name = "id"></label> 
           <label>비밀번호 : <input type="text" name = "password"></label> 
           <input type = "submit" value = "확인">
           
           <p>result</p>
    </form>
    
    
</body>

</html>