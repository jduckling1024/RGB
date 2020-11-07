<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form id = 'form1' action="/uploadImage" method="post" enctype="multipart/form-data"
	 accept-charset="UTF-8">
		<input type='file' name='file' multiple="multiple">
		<input type='submit'>
	</form>
</body>
</html>