<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>redirect1</title>
</head>
<body>
	<h3>redirect1 페이지</h3>
	<%
		// 해당 주소로 다시 요청 명령
		response.sendRedirect("../1.request.jsp");
	%>
	
</body>
</html>