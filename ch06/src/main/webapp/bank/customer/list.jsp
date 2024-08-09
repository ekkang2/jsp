<%@page import="bank.CustomerVO"%>
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

	List<CustomerVO> customers = new ArrayList<>();

	try {
		// 1단계 - JNDI 서비스 객체 생성
		Context initCtx = new InitialContext();
		Context ctx = (Context) initCtx.lookup("java:comp/env"); // JNDI 기본 환경 이름
		
		// 2단계 - 커넥션 풀에서 커넥션 객체 가져오기
		DataSource ds = (DataSource) ctx.lookup("jdbc/bank");
		Connection conn = ds.getConnection();
		
		// 3단계 - SQL실행 객체 생성
		Statement stmt = conn.createStatement();
		
		// 4단계 - SQL실행
		ResultSet rs = stmt.executeQuery("select * from bank_customer");
		
		// 5단계 - 결과처리
		while(rs.next()){
			CustomerVO vo = new CustomerVO();
			vo.setC_no(rs.getString(1));
			vo.setC_name(rs.getString(2));
			vo.setC_dist(rs.getInt(3));
			vo.setC_phone(rs.getString(4));
			vo.setC_addr(rs.getString(5));
			
			customers.add(vo);
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
	<title>customer::list</title>
</head>
<body>
	<h3>고객목록</h3>
	
	<a href="/ch06/2.DBCPTest.jsp">처음으로</a>
	<a href="/ch06/bank/customer/register.jsp">등록</a>
	
	<table border="1">
		<tr>
			<th>고객번호</th>
			<th>고객명</th>
			<th>고객구분</th>
			<th>전화번호</th>
			<th>주소</th>
			<th>관리</th>
		</tr>
		
		<% for(CustomerVO vo : customers){ %>
		<tr>
			<td><%= vo.getC_no() %></td>
			<td><%= vo.getC_name() %></td>
			<td><%= vo.getC_dist() %></td>
			<td><%= vo.getC_phone() %></td>
			<td><%= vo.getC_addr() %></td>
			<td>
				<a href="#">수정</a>
				<a href="#">삭제</a>
			</td>
		</tr>
		<% } %>
	</table>
	
	
</body>
</html>