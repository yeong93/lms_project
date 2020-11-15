<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>학습자료관리</title>
</head>
<body>
<!-- File upload 를 위해서는 enctype을 multipart/form-data 로 설정해야한다. -->
<form action="upload.jsp" method="post" enctype="multipart/form-data">
    <p>이름 : <input type="text" name="my_name"></p>
    <p>파일 : <input type="file" name="my_file"></p>
    <p><input type="submit" value="Upload"></p>
</form>
</body>
</html>