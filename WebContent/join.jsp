<jsp:useBean id="user" class="user.User" scope="page"/>
<jsp:setProperty name="user" property="userName" />
<%@ page import = "user.UserDAO"  %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>스타벅스 코리아</title>
    <link rel="shortcut icon" href="images/favicon.ico" type="image/x-icon">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="css/grid.css">
    <link rel="stylesheet" href="css/style.css">
    <script type="text/javascript" src="js/join.js"></script>
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
              <p>
                <strong>스타벅스커피 코리아 회원이 아니세요?</strong>
                스타벅스커피 코리아 회원만의 특별한 혜택을 누릴 수 있습니다.
              </p>
              <%
				// 로그인 하지 않았을 때 보여지는 화면
				if(userID == null){
			  %>
              <div class="btn-group">
                <button onclick="location.href='login.jsp'">로그인</button>
                <button onclick="location.href='join.jsp'">회원가입</button>
              </div>
              <%
				// 로그인이 되어 있는 상태에서 보여주는 화면
				}else{
			  %>
			  <div class="btn-group">
			  	
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
    <!-- header end -->

    <!-- main section -->
	<!-- 로그인 양식 -->
  <section class="join-section">
    <div class="container">		<!-- 하나의 영역 생성 -->
      <div class="join-container-width">	<!-- 영역 크기 -->
        <div class="join-jumbotron">
          <form method="post" name="frm1" onsubmit="return EPcheck()" action="joinAction.jsp" >
            <h3 class="joinmainfont" style="font-size:30px;">회원가입</h3><br>
            <div class="join-form-group">
              <input type="text" class="join-form-control" placeholder="아이디" name="userID" maxlength="20">
            </div>
            <div class="join-form-group">
              <input type="password" class="join-form-control" id="userPassword" placeholder="비밀번호" name="userPassword" maxlength="20">
            </div>
            <div class="join-form-group">
              <input type="password" class="join-form-control" id="userPasswordcheck" placeholder="비밀번호" maxlength="20">
              <input class="join-check-btn" type="button"  onclick="pwdcheck()" value="비밀번호확인">
            </div>
            <div class="join-form-group" style="text-align: center;">
              <div class="btn-group" data-toggle="buttons">
                <label class="btn btn-primary active gender-radio">
                  <input class="gender-radio" type="radio" name="userGender" autocomplete="off" value="남자" checked><span>남자</span>
                </label>
                <label class="btn btn-primary active gender-radio">
                  <input  type="radio" name="userGender" autocomplete="off" value="여자"><span>여자</span>
                </label>
              </div>
            </div>
            <div class="join-form-group">
              <div class="room">
                <a class="form-name">이름</a><a class="form-name green-name">(필수)</a><br>
              </div>
              <input type="text" class="join-form-control" placeholder="" name="userName" maxlength="20">
            </div>
            <div class="join-form-group">
              <div class="room">
                <a class="form-name">전화번호</a><a class="form-name green-name">(필수)</a><br>
              </div>
              <input type="text" class="join-form-control" placeholder="-포함하여 작성해주세요." name="userPhone" maxlength="20">
            </div>
            <div class="join-form-group">
              <div class="room">
                <a class="form-name">이메일</a><a class="form-name green-name">(필수)</a><br>
              </div>
              <input type="email" class="join-form-control" placeholder="" name="userEmail" maxlength="20">
            </div>
            <div class="join-form-group">
              <input type="submit" class="btn btn-primary join-submit-btn" value="회원가입">
            </div>
            <h3 style="text-decoration:none; text-align: center;"> <br>회원가입을 하시면 <br>많은 혜택이 있습니다.</h3>
          </form>
        </div>
      </div>	
    </div>
  </section>
	
	<!-- 부트스트랩 참조 영역 -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
	<script type="text/javascript">
    function pwdcheck() {
      theForm=document.frm1;
      if(theForm.userPassword.value==""||theForm.userPasswordcheck.value==""){
        alert("비밀번호가 입력되지 않았습니다.");
      }else{
        var p1 = document.getElementById('userPassword').value;
        var p2 = document.getElementById('userPasswordcheck').value;
        if( p1 != p2 ) {
          alert("비밀번호가 일치 하지 않습니다");
          return false;
        } else{
          alert("비밀번호가 일치합니다");
          return true;
        }
      }
    } 
   	
  	</script>
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
</html>
    