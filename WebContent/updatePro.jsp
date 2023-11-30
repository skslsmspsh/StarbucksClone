<%@page import="ch13.BoardDBBean"%>
<%@page import="ch13.BoardDataBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
%>

<jsp:useBean id="article" class="ch13.BoardDataBean">
	<jsp:setProperty name="article" property="*" />
</jsp:useBean>

<%
	BoardDBBean dbPro = BoardDBBean.getInstance();
	int check = dbPro.updateArticle(article);
	if(check == 1){
%>
	<meta http-equiv="Refresh" content="0;url=list.jsp">
<%
	}else{
%>
	<script type="text/javascript">
		alert("비밀번호가 맞지 않습니다.");
		history.go(-1);
	</script>
<%
		
	}
%>