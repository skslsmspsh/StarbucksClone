<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "ch13.*" %>

<%
   request.setCharacterEncoding("utf-8");
   BoardDBBean dbBean = BoardDBBean.getInstance();   
   
   String writer = "Smith";
   String subject = "Hello World";
   String passwd = "1234";
   int ref = 0;
   int re_step = 1;
   int re_level = 1;
   String content = "Web Programming!";
   
   for(int i=1;i<10;i++){
   BoardDataBean article = new BoardDataBean();
   article.setWriter(writer + i);
   article.setSubject(subject + i);
   article.setPasswd(passwd);
   article.setRef(ref);
   article.setRe_step(re_step);
   article.setRe_level(re_level);
   article.setContent(content + i);
   article.setReg_date(new Timestamp(System.currentTimeMillis()));
   article.setIp(request.getRemoteAddr()); //ip얻어오기
   dbBean.insertArticle(article);
   }
   
   //BoardDBBean dbBean = new BoardDBBean();
   response.sendRedirect("list.jsp");
%>