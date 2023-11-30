<jsp:useBean id="user" class="user.User" scope="page"/>
<jsp:setProperty name="user" property="userName" />
<%@ page import = "user.UserDAO"  %>
<%@page import="ch13.BoardDataBean"%>
<%@page import="java.util.List"%>
<%@page import="ch13.BoardDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ include file="color.jspf"%>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	BoardDBBean dbPro = BoardDBBean.getInstance();
	BoardDataBean article = dbPro.getArticle(num);
%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>스타벅스 코리아</title>
    <link rel="shortcut icon" href="images/favicon.ico" type="image/x-icon">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="css/board.css">
    <link rel="stylesheet" href="css/grid.css">
    <link rel="stylesheet" href="css/style.css">
    
  </head>
  <body>
  	<%
		// 메인 페이지로 이동했을 때 세션에 값이 담겨있는지 체크
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String)session.getAttribute("userID");
		}
		
		UserDAO userDAO = new UserDAO();
		String name = userDAO.welcome(userID);
	%>
    <header>
      <div class="title"><h1><a href="starbucksindex.jsp">STARBUCKS</a></h1></div>
      <!-- 모바일환경에서 보이는 토글메뉴버튼 -->
      <input type="checkbox" id="btn-menu">
      <label for="btn-menu" class="btn-menu">
      <span></span>
      <span></span>
      <span></span>
      </label>
      <!-- 검색/네비게이션메뉴 -->
      <nav>
        <form action="" class="search">
          <input type="text" name="" value="">
          <button type="submit">
            <span class="skip">검색</span>
          </button>
        </form>
        <ul class="gnb-nav">
          <li>
            <a href="#">COFFEE</a>
            <ul>
              <li><a href="#">커피</a></li>
              <li><a href="#">나와 어울리는 커피</a></li>
              <li><a href="#">스타벅스 리저브<sup>TM</sup></a></li>
            </ul>
          </li>
          <li><a href="#">MENU</a>
            <ul>
              <li><a href="#">음료</a></li>
              <li><a href="#">푸드</a></li>
              <li><a href="#">상품</a></li>
              <li><a href="#">카드</a></li>
            </ul>
          </li>
          <li><a href="#">Convenience</a>
            <ul>
              <li><a href="map.jsp">매장찾기</a></li>
              <li><a href="list.jsp">게시판</a></li>
              <li><a href="wallpaper.jsp">자료실</a></li>
            </ul>
          </li>
          <li><a href="#">RESPONSIBILITY</a>
            <ul>
              <li><a href="#">사회공헌 캠페인 소개</a></li>
              <li><a href="#">지역사회 참여활동</a></li>
            </ul>
          </li>
        </ul>
        <ul class="util-nav">
          <li><a href="admin/adminlogin.jsp">admin</a></li>
        </ul>
      </nav>

      <!-- 멤버쉽메뉴 -->
      <input type="checkbox" id="btn-member">
      <label for="btn-member" class="btn-member fa">
        <span class="skip">멤버십메뉴</span>
      </label>
      <div class="member-nav row">
        <div class="col-xs-12 col-sm-6">
          <div class="wrap row">
            <div class="col-xs-3 col-sm-3">
              <img src="images/login.png" alt="login아이콘">
            </div>
            <div class="col-xs-9 col-sm-9">
              
              <%
				// 로그인 하지 않았을 때 보여지는 화면
				if(userID == null){
			  %>
			  <p>
                <strong>스타벅스커피 코리아 회원이 아니세요?</strong>
                스타벅스커피 코리아 회원만의 특별한 혜택을 누릴 수 있습니다.
              </p>
              <div class="btn-group">
                <button onclick="location.href='login.jsp'">로그인</button>
                <button onclick="location.href='join.jsp'">회원가입</button>
              </div>
              <%
				// 로그인이 되어 있는 상태에서 보여주는 화면
				}else{
			  %>
			  <p>
                <strong>스타벅스커피 코리아만의 특별한 멤버십 혜택을 누려보세요.</strong>
                환영합니다. 고객님에게 최선을 다하는 스타벅스가 되겠습니다.
              </p>
			  <div class="btn-group">  	
				<a style="color:white"><%=name%>님 환영합니다.</a>&nbsp;&nbsp;
                <button onclick="location.href='logoutAction.jsp'">로그아웃</button>
              </div>
			  <%
				}
			  %>
            </div>
          </div>
        </div>
      </div>
    </header>
    <!-- //header end -->

    <!-- section -->
    <section id="boardSection">
	  <% 
			if(article != null){
				
		%>
		<form>
		<table>  
		  <tr height="30">
		    <td style="font-weight:bold;" id="contenttd" align="center" width="125" bgcolor="<%=value_c %>">글번호</td>
		    <td id="contenttd" align="center" width="125" align="center"><%=article.getNum() %></td>
		    <td style="font-weight:bold;" id="contenttd" align="center" width="125" bgcolor="<%=value_c %>">조회수</td>
		    <td id="contenttd" align="center" width="125" align="center"><%=article.getReadcount() %></td>
		  </tr>
		  <tr height="30">
		    <td style="font-weight:bold;" id="contenttd" align="center" width="125" bgcolor="<%=value_c %>">작성자</td>
		    <td id="contenttd" align="center" width="125" align="center"><%=article.getWriter() %></td>
		    <td style="font-weight:bold;" id="contenttd" align="center" width="125" bgcolor="<%=value_c %>">작성일</td>
		    <td id="contenttd" align="center" width="125" align="center"><%=article.getReg_date() %></td>
		  </tr>
		  <tr height="30">
		    <td style="font-weight:bold;" id="contenttd" align="center" width="125" bgcolor="<%=value_c %>">글제목</td>
		    <td id="contenttd" align="center" width="375" align="center" colspan="3"><%=article.getSubject() %></td>
		  </tr>
		  <tr height="600px">
		    <td style="font-weight:bold;" id="contenttd" align="center" width="125" bgcolor="<%=value_c %>">글내용</td>
		    <td id="contenttd" align="left" width="375" colspan="3"><%=article.getContent() %></td>
		  </tr>
		  <tr height="30">      
		    <td colspan="4" align="right" > 
			  <input id="Allbutton" style="cursor:pointer" type="button" value="글수정" onClick="document.location.href='updateForm.jsp?num=<%=article.getNum() %>'">
			  <input id="Allbutton" style="cursor:pointer" type="button" value="글삭제" onClick="document.location.href='deleteForm.jsp?num=<%=article.getNum() %>'" >
		      <input id="Allbutton" style="cursor:pointer" type="button" value="답글쓰기" onClick="document.location.href='writeForm.jsp?num=<%=article.getNum()%>&ref=<%=article.getRef()%>&re_step=<%=article.getRe_step()%>&re_level=<%=article.getRe_level()%>'">
		      <input id="Allbutton" style="cursor:pointer" type="button" value="글목록" onClick="document.location.href='list.jsp'">
		    </td>
		  </tr>
		</table>    
		</form>   
		<%
			}else{
				out.println("게시글이 없습니다.");
			}
		%>
    </section>
    <!-- //section end -->
		
    <!-- footer -->
    <footer>
      <!-- 배너 -->
      <div class="banner">
        <div class="wrap">
          <input type="checkbox" id="btn-banner">
          <label for="btn-banner" class="fa">
            <span class="skip">정지/재생</span>
          </label>
          <ul>
            <li><img src="images/banner1.jpg" alt="고용노동부-2016고용창출 100대 우수기업 4년 연속 표창"></li>
            <li><img src="images/banner2.jpg" alt="각배너의 내용작성"></li>
            <li><img src="images/banner3.jpg" alt="각배너의 내용작성"></li>
            <li><img src="images/banner4.jpg" alt="각배너의 내용작성"></li>
            <li><img src="images/banner5.jpg" alt="각배너의 내용작성"></li>
            <li><img src="images/banner6.jpg" alt="각배너의 내용작성"></li>
            <li><img src="images/banner1.jpg" alt="각배너의 내용작성"></li>
            <li><img src="images/banner2.jpg" alt="각배너의 내용작성"></li>
          </ul>
        </div>
      </div>

      <!-- 사이트 정보 -->
      <ul class="info">
        <li>사업자등록번호 201-81-21515</li>
        <li>(주)스타벅스커피 코리아 대표이사 이석구</li>
        <li>TEL : 02) 3015-1100 / FAX : 02) 3015-1106</li>
        <li>개인정보 책임자 : 강기원</li>
      </ul>
      <small>ⓒ 2015 Starbucks Coffee Company. All Rights Reserved.</small>
    </footer>
    <!-- //footer end-->
  </body>

  <script src="js/jquery.min.js"></script>
  <script src="js/jquery.flip.js"></script>
  <script>
    $('.rotate').flip({
      axis: 'y',
      reverse: true,
      trigger: 'manual'
    }).bind('mouseenter focusin',function(){
      $(this).flip(true);
    }).bind('mouseleave focusout', function () {
      $(this).flip(false);
    });
  </script>
</html>
