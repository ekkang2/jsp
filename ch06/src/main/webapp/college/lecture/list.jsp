<%@page import="college.LectureVO"%>
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

	List<LectureVO> lectures = new ArrayList<>();

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
		ResultSet rs = stmt.executeQuery("select * from lecture");
		
		// 5단계 - 결과처리
		while(rs.next()){
			LectureVO vo = new LectureVO();
			vo.setLecNo(rs.getInt(1));
			vo.setLecName(rs.getString(2));
			vo.setLecCredit(rs.getInt(3));
			vo.setLecTime(rs.getInt(4));
			vo.setLecClass(rs.getString(5));
			
			lectures.add(vo);
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
	<h3>강좌목록</h3>
	
	<a href="/ch06/2.DBCPTest.jsp">처음으로</a>
	<a href="/ch06/college/lecture/register.jsp">등록</a>
	
	<table border="1">
		<tr>
			<th>강좌번호</th>
			<th>강좌명</th>
			<th>취득학점</th>
			<th>강의시간</th>
			<th>강의실</th>
			<th>관리</th>
		</tr>
		
		<% for(LectureVO vo : lectures){ %>
		<tr>
			<td><%= vo.getLecNo() %></td>
			<td><%= vo.getLecName() %></td>
			<td><%= vo.getLecCredit() %></td>
			<td><%= vo.getLecTime() %></td>
			<td><%= vo.getLecClass() %></td>
			<td>
				<a href="#">수정</a>
				<a href="#">삭제</a>
			</td>
		</tr>
		<% } %>
	</table>
	
	
</body>
</html>