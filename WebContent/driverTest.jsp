<%@ page language="java" contentType="text/html; charset=EUC-KR"

    pageEncoding="EUC-KR"%>

<%@ page import = "java.sql.*" %>
<h1>JDBC 드라이버 테스트</h1>
<% 

	Connection conn = null;
	try{
		//String jdbcUrl = "jdbc:mysql://pieroot.xyz:3306/starbucks?allowPublicKeyRetrieval=true&useSSL=true&verifyServerCertificate=false";
		String jdbcUrl = "jdbc:mysql://localhost:3306/basicjsp";
		String dbId = "jspid";
		String dbPass="jsppass";
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(jdbcUrl,dbId,dbPass);
		out.print("제대로 연결되었습니다");
	}catch(Exception e){
			out.print("에러"+e.getMessage());
	}

%>