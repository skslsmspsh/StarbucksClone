<%@ page language="java" contentType="text/html; charset=EUC-KR"

    pageEncoding="EUC-KR"%>

<%@ page import = "java.sql.*" %>
<h1>JDBC ����̹� �׽�Ʈ</h1>
<% 

	Connection conn = null;
	try{
		//String jdbcUrl = "jdbc:mysql://pieroot.xyz:3306/starbucks?allowPublicKeyRetrieval=true&useSSL=true&verifyServerCertificate=false";
		String jdbcUrl = "jdbc:mysql://localhost:3306/basicjsp";
		String dbId = "jspid";
		String dbPass="jsppass";
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(jdbcUrl,dbId,dbPass);
		out.print("����� ����Ǿ����ϴ�");
	}catch(Exception e){
			out.print("����"+e.getMessage());
	}

%>