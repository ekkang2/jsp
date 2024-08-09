<%@page import="college.StudentVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%

	List<StudentVO> students = new ArrayList<>();

	try {
		// 1단계 - JNDI 서비스 객체 생성
		Context initCtx = new InitialContext();
		Context ctx = (Context) initCtx.lookup("java:comp/env"); // JNDI 기본 환경 이름
		
		// 2단계 - 커넥션 풀에서 커넥션 객체 가져오기
		DataSource ds = (DataSource) ctx.lookup("jdbc/college");
		Connection conn = ds.getConnection();
		
		// 3단계 - SQL실행 객체 생성
		Statement stmt = conn.createStatement();
		
		// 4단계 - SQL실행
		ResultSet rs = stmt.executeQuery("select * from student");
		
		// 5단계 - 결과처리
		while(rs.next()){
			StudentVO vo = new StudentVO();
			vo.setStdNo(rs.getString(1));
			vo.setStdName(rs.getString(2));
			vo.setStdHp(rs.getString(3));
			vo.setStdYear(rs.getInt(4));
			vo.setStdAddress(rs.getString(5));
			
			students.add(vo);
		}
		
		// 6단계 - 커넥션 반납
		rs.close();
		stmt.close();
		conn.close();
		
	}catch(Exception e){
		e.printStackTrace();
	}

%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>student::list</title>
</head>
<body>
	<h3>학생목록</h3>
	
	<a href="/ch06/2.DBCPTest.jsp">처음으로</a>
	<a href="/ch06/college/student/register.jsp">등록</a>
	
	<table border="1">
		<tr>
			<th>학생번호</th>
			<th>학생이름</th>
			<th>휴대폰</th>
			<th>학년</th>
			<th>주소</th>
			<th>관리</th>
		</tr>
		
		<% for(StudentVO vo : students){ %>
		<tr>
			<td><%= vo.getStdNo() %></td>
			<td><%= vo.getStdName() %></td>
			<td><%= vo.getStdHp() %></td>
			<td><%= vo.getStdYear() %></td>
			<td><%= vo.getStdAddress() %></td>
			<td>
				<a href="#">수정</a>
				<a href="#">삭제</a>
			</td>
		</tr>
		<% } %>
	</table>
	
	
</body>
</html>