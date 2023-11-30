<%@page import="ch13.BoardDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   request.setCharacterEncoding("utf-8");
   int num = Integer.parseInt(request.getParameter("num"));
   String passwd = request.getParameter("passwd");
   
   BoardDBBean dbPro = BoardDBBean.getInstance();
   int deleteCount = dbPro.deleteArticle(num, passwd);
   if(deleteCount == 1){
%>
   <meta http-equiv="Refresh" content="0;url=list.jsp">
<%      
   }
   else{
%>
   <script>
      alert("비밀번호가 맞지 않습니다!")
      history.go(-1);
   </script>
<%      
   }
%>