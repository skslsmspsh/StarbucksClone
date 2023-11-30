<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	String userID = request.getParameter("userID");
	String userPassword = request.getParameter("userPassword");
	Connection conn = null;
	PreparedStatement pstmt = null;
try {
	String jdbcUrl = "jdbc:mysql://pieroot.xyz:3306/starbucks?allowPublicKeyRetrieval=true";
	String dbId = "sonson";
	String dpPass = "qweqwe";
	Class.forName("com.mysql.cj.jdbc.Driver");
	conn = DriverManager.getConnection(jdbcUrl, dbId, dpPass);
	String sql = "delete from user where userID=? and userPassword=?";
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, userID);
	pstmt.setString(2, userPassword);
	pstmt.executeUpdate();
	response.sendRedirect("adminmember.jsp");
} catch (Exception e) {
	System.out.println("Exception : " + e.getMessage());
} finally {
	if (pstmt != null) {
		try {
	pstmt.close();
		} catch (Exception e) {
	System.out.println("Exception[PreparedStatement] : " + e.getMessage());
		}
	}
	if (conn != null) {
		try {
	conn.close();
		} catch (Exception e) {
	System.out.println("Exception[conn] : " + e.getMessage());
		}
	}
}
%>