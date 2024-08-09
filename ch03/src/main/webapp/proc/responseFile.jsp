<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>responserFile</title>
	<%--
		날짜 : 2024/08/06
		이름 : 강은경
		내용 : response 내장객체 실습하기
 	--%>
</head>
<body>
	<h3>파일 다운로드</h3>
	<%
		response.setHeader("Content-Type", "application/octet-stream");
	%>
</body>
</html>