<jsp:useBean id="user" class="user.User" scope="page"/>
<jsp:setProperty name="user" property="userName" />
<%@ page import = "user.UserDAO"  %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="color.jspf" %>  
<html>
<head>
<title>게시판</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script type = "text/javascript">
   function deleteSave(){
      if(document.writeform.passwd.value == ""){
         alert("비밀번호를 입력하세요.");
         document.writeform.passwd.focus();
         return false;
      }
      return true;
   }
</script>
</head>
<body>
<br>
<form name = "writeform" action="deletePro.jsp" onsubmit="return deleteSave()"> 
 <table>
  <tr height="30">
     <td align=center>
       <b>비밀번호를 입력해 주세요.</b></td>
  </tr>
  <tr height="30">
     <td align=center bgcolor=<%=value_c %>>비밀번호 :   
       <input type="password" name="passwd" size="8" maxlength="12">
      <input type="hidden" name="num" value="<%= request.getParameter("num")%>"></td>
 </tr>
 <tr height="30">
    <td align=center>
      <input id="Allbutton" style="cursor:pointer" type="submit" value="글삭제" >
      <input id="Allbutton" style="cursor:pointer" type="button" value="글목록" onclick="document.location.href='list.jsp'">     
   </td>
 </tr>  
</table> 
</form>
</body>
</html>