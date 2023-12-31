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
    <section>
      <!-- 신제품광고 -->
      <article class="main-ad">
        <div class="row">
          <div class="emblem">
            <img src="images/emblem.png" alt="show your flavor">
            <a href="#">자세히보기</a>
          </div>
          <div class="flavor">
            <img src="images/bev1_cup.png" alt="슈크림딸기프라푸치노 이미지" class="flavor1-img">
            <img src="images/bev1_txt.png" alt="슈크림딸기프라푸치노" class="flavor1-text">
          </div>
        </div>
      </article>

      <!-- 제품소개 -->
      <article class="product">
        <!-- 제품정보 -->
        <div class="product-info">
          <div class="row">
            <div class="col-xs-12 col-sm-6">
              <div class="img-box">
                <img src="images/fav_prod_txt01.png" alt="pick your favorite">
                <img src="images/fav_prod_txt02.png" alt="다양한 메뉴를 스타벅스에서 즐겨보세요.">
              </div>
              <a href="#">자세히보기</a>
            </div>
            <div class="col-xs-12 col-sm-6">
              <img src="images/fav_prod_img.png" alt="제품이미지">
            </div>
          </div>
        </div>

        <!-- 제품이미지 -->
        <div class="product-gallery">
          <h2>새로나온 제품</h2>
          <!-- ul>li[class="col-xs-6 col-sm-3"]*4>div[class=wrap]>
          img[src=images/coffee$.jpg]+(a[href=#]>dl>dt+dd) -->
          <ul class="row">
            <li class="col-xs-6 col-sm-3">
              <div class="wrap">
                <img src="images/coffee1.jpg" alt="나이트로 콜드 브루">
                <a href="#">
                  <dl>
                    <dt>나이트로 콜드 브루</dt>
                    <dd>Nitro Cold Brew</dd>
                  </dl>
                  <i class="fa"></i>
                  <span class="skip">자세히보기</span>
                </a>
              </div>
            </li>
            <li class="col-xs-6 col-sm-3">
              <div class="wrap">
                <img src="images/coffee2.jpg" alt="바닐라 크림 콜드 브루">
                <a href="#">
                  <dl>
                    <dt>바닐라 크림 콜드 브루</dt>
                    <dd>Vanilla Cream Cold Brew</dd>
                  </dl>
                  <i class="fa"></i>
                  <span class="skip">자세히보기</span>
                </a>
              </div>
            </li>
            <li class="col-xs-6 col-sm-3">
              <div class="wrap">
                <img src="images/coffee3.jpg" alt="콜드 브루">
                <a href="#">
                  <dl>
                    <dt>콜드 브루</dt>
                    <dd>Cold Brew</dd>
                  </dl>
                  <i class="fa"></i>
                  <span class="skip">자세히보기</span>
                </a>
              </div>
            </li>
            <li class="col-xs-6 col-sm-3">
              <div class="wrap">
                <img src="images/coffee4.jpg" alt="콜드 브루 라떼">
                <a href="#">
                  <dl>
                    <dt>콜드 브루 라떼</dt>
                    <dd>Cold Brew Latte</dd>
                  </dl>
                  <i class="fa"></i>
                  <span class="skip">자세히보기</span>
                </a>
              </div>
            </li>
          </ul>
        </div>
      </article>

      <!-- 리저브 커피  -->
      <article class="reserve">
        <h2>스타벅스 리저브<sup>TM</sup></h2>
        <div class="reserve-info">
          <!-- ul>li[class="col-xs-6 col-sm-3"]*4>div[class=wrap]>img[src=images/icon_reserve_info$.png]+p -->
          <ul class="row">
            <li class="col-xs-6 col-sm-3">
              <div class="wrap">
                <img src="images/icon_reserve_info1.png" alt="">
                <p>clover</p>
              </div>
            </li>
            <li class="col-xs-6 col-sm-3">
              <div class="wrap">
                <img src="images/icon_reserve_info2.png" alt="">
                <p>black eagle</p>
              </div>
            </li>
            <li class="col-xs-6 col-sm-3">
              <div class="wrap">
                <img src="images/icon_reserve_info3.png" alt="">
                <p>siphon</p>
              </div>
            </li>
            <li class="col-xs-6 col-sm-3">
              <div class="wrap">
                <img src="images/icon_reserve_info4.png" alt="">
                <p>poc</p>
              </div>
            </li>
          </ul>
        </div>
        <!-- 리저브 매장 -->
        <div class="reserve-store">
          <div class="rotate">
            <img src="images/reserve_medal01.png" alt="reserve logo" class="front">
            <div class="back">
              <img src="images/reserve_medal02.png" alt="스타벅스 리저브 매장, 스타벅스 리저브TM커피 및 관련제품을 판매하는 매장을 확인하려면 매장보기를 눌러주세요.">
              <a href="#">매장보기</a>
            </div>
          </div>
        </div>
      </article>
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
