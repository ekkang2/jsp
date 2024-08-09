<%@page import="theater.MoviesVO"%>
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

	List<MoviesVO> movies = new ArrayList<>();

	try {
		// 1단계 - JNDI 서비스 객체 생성
		Context initCtx = new InitialContext();
		Context ctx = (Context) initCtx.lookup("java:comp/env"); // JNDI 기본 환경 이름
		
		// 2단계 - 커넥션 풀에서 커넥션 객체 가져오기
		DataSource ds = (DataSource) ctx.lookup("jdbc/theater");
		Connection conn = ds.getConnection();
		
		// 3단계 - SQL실행 객체 생성
		Statement stmt = conn.createStatement();
		
		// 4단계 - SQL실행
		ResultSet rs = stmt.executeQuery("select * from movies");
		
		// 5단계 - 결과처리
		while(rs.next()){
			MoviesVO vo = new MoviesVO();
			vo.setMovie_id(rs.getInt(1));
			vo.setTitle(rs.getString(2));
			vo.setGenre(rs.getString(3));
			vo.setRelease_date(rs.getString(4));
			movies.add(vo);
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
	<title>movies::list</title>
</head>
<body>
	<h3>제품목록</h3>
	
	<a href="/ch06/2.DBCPTest.jsp">처음으로</a>
	<a href="/ch06/theater/movies/register.jsp">등록</a>
	
	<table border="1">
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>장르</th>
			<th>개봉일</th>
			<th>관리</th>
		</tr>
		
		<% for(MoviesVO vo : movies){ %>
		<tr>
			<td><%= vo.getMovie_id() %></td>
			<td><%= vo.getTitle() %></td>
			<td><%= vo.getGenre() %></td>
			<td><%= vo.getRelease_date() %></td>
			<td>
				<a href="#">수정</a>
				<a href="#">삭제</a>
			</td>
		</tr>
		<% } %>
	</table>
	
	
</body>
</html>