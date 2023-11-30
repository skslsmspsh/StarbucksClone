<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@page import ="ch13.*" %> 
 <%
 	request.setCharacterEncoding("utf-8");
 %>
 <jsp:useBean id="article" class="ch13.BoardDataBean" >
 	<jsp:setProperty name="article" property="*" />
 </jsp:useBean>
 <%
 	article.setReg_date(new Timestamp(System.currentTimeMillis()));
 	article.setIp(request.getRemoteAddr());
 	
 	//BoardDBBean dbBean = new BoardDBBean(); 이미 bean.java에서 생성했기때문에 또 생성하면 중복되어 에러 바로 아랫줄처럼 작성해줘야함
 	BoardDBBean dbBean = BoardDBBean.getInstance();
 	dbBean.insertArticle(article);
 	
 	response.sendRedirect("list.jsp");
 %>
 