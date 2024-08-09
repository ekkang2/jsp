<%@page import="shop.ProductVO"%>
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

	List<ProductVO> products = new ArrayList<>();

	try {
		// 1단계 - JNDI 서비스 객체 생성
		Context initCtx = new InitialContext();
		Context ctx = (Context) initCtx.lookup("java:comp/env"); // JNDI 기본 환경 이름
		
		// 2단계 - 커넥션 풀에서 커넥션 객체 가져오기
		DataSource ds = (DataSource) ctx.lookup("jdbc/shop");
		Connection conn = ds.getConnection();
		
		// 3단계 - SQL실행 객체 생성
		Statement stmt = conn.createStatement();
		
		// 4단계 - SQL실행
		ResultSet rs = stmt.executeQuery("select * from product");
		
		// 5단계 - 결과처리
		while(rs.next()){
			ProductVO vo = new ProductVO();
			vo.setProdNo(rs.getInt(1));
			vo.setProdName(rs.getString(2));
			vo.setStock(rs.getInt(3));
			vo.setPrice(rs.getInt(4));
			vo.setCompany(rs.getString(5));
			products.add(vo);
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
	<h3>제품목록</h3>
	
	<a href="/ch06/2.DBCPTest.jsp">처음으로</a>
	<a href="/ch06/shop/product/register.jsp">등록</a>
	
	<table border="1">
		<tr>
			<th>제품번호</th>
			<th>제품명</th>
			<th>재고량</th>
			<th>단가</th>
			<th>제조업체</th>
			<th>관리</th>
		</tr>
		
		<% for(ProductVO vo : products){ %>
		<tr>
			<td><%= vo.getProdNo() %></td>
			<td><%= vo.getProdName() %></td>
			<td><%= vo.getStock() %></td>
			<td><%= vo.getPrice() %></td>
			<td><%= vo.getCompany() %></td>
			<td>
				<a href="#">수정</a>
				<a href="#">삭제</a>
			</td>
		</tr>
		<% } %>
	</table>
	
	
</body>
</html>