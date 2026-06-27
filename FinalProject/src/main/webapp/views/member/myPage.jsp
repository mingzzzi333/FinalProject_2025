<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>👤 내 정보</title>
  <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@500;700&display=swap" rel="stylesheet">
  <style>
    @import url('https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600&display=swap');

    body {
        font-family: 'Montserrat', sans-serif;
        background-color: #f9fafb;
        margin: 0; padding: 0;
        color: #333;
        line-height: 1.6;
    }
    
    .header-line1 {
        background: #FF6B6B;
        color: #fff;
        padding: 20px 24px;
        display: flex;
        justify-content: center;
        align-items: center;
        position: relative;
        font-weight: 700;
        font-size: 28px;
        letter-spacing: 1.2px;
    }
    
    .header-line1 a {
        color: #fff;
        text-decoration: none;
    }
    
    .header-line1 .auth-links {
        position: absolute;
        right: 24px;
        top: 50%;
        transform: translateY(-50%);
        font-weight: 500;
        font-size: 14px;
    }
    
    .header-line1 .auth-links a {
        color: #fff;
        margin-left: 16px;
        text-decoration: none;
        transition: color 0.3s;
    }
    
    .header-line1 .auth-links a:hover {
        color: #ffc3c3;
        text-decoration: underline;
    }

    .header-line2 {
        background: #ffe5e5;
        padding: 12px 50px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        font-weight: 600;
        font-size: 15px;
        color: #555;
    }
    
    .nav-links a {
        margin-right: 20px;
        color: #555;
        text-decoration: none;
        transition: color 0.3s;
    }
    
    .nav-links a:last-child {
        margin-right: 0;
    }
    
    .nav-links a:hover {
        color: #ff6b6b;
        text-decoration: underline;
    }

    .search-box form {
        display: flex;
        border-radius: 25px;
        overflow: hidden;
        box-shadow: 0 2px 8px rgb(0 0 0 / 0.1);
        background: #fff;
    }
    
    .search-box input[type="text"] {
        padding: 10px 18px;
        font-size: 14px;
        border: none;
        width: 280px;
        outline: none;
    }
    
    .search-box button {
        background-color: #ff6b6b;
        border: none;
        color: white;
        padding: 0 18px;
        font-size: 18px;
        cursor: pointer;
        transition: background-color 0.3s;
    }
    
    .search-box button:hover {
        background-color: #e85757;
    }

    /* 본문 영역 */
    .main-content {
        background: #ffffff;
        min-height: calc(100vh - 150px);
        padding: 30px;
    }

    /* 내 정보 페이지 전용 스타일 */
    .container {
        max-width: 600px;
        margin: auto;
        background: #fff;
        padding: 40px;
        border-radius: 12px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
    }

    h1 {
        text-align: center;
        margin-bottom: 30px;
        color: #FF6B6B;
        font-size: 24px;
        font-weight: 600;
    }

    .info-row {
        margin: 20px 0;
        font-size: 16px;
        padding: 15px;
        background: #fef9f9;
        border-radius: 8px;
        border-left: 4px solid #FF6B6B;
    }

    .info-row span {
        display: inline-block;
        width: 120px;
        font-weight: 600;
        color: #333;
    }

    .info-value {
        color: #555;
        font-weight: 400;
    }

    .profile-image {
        text-align: center;
        margin: 30px 0;
    }

    .profile-image img {
        width: 150px;
        height: 150px;
        border-radius: 50%;
        object-fit: cover;
        border: 4px solid #FF6B6B;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    }

    .edit-button-container {
        text-align: center;
        margin-top: 40px;
    }

    .edit-button {
        background-color: #FF6B6B;
        color: white;
        border: none;
        border-radius: 25px;
        padding: 12px 30px;
        font-size: 16px;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.3s ease;
        box-shadow: 0 4px 12px rgba(255, 107, 107, 0.3);
    }

    .edit-button:hover {
        background-color: #e85757;
        transform: translateY(-2px);
        box-shadow: 0 6px 16px rgba(255, 107, 107, 0.4);
    }

    /* 슬라이딩 패널 및 오버레이 */
    .overlay {
        display: none;
        position: fixed;
        top: 0; left: 0;
        width: 100%; height: 100%;
        background: rgba(0, 0, 0, 0.4);
        z-index: 998;
    }

    .slide-panel {
        width: 300px;
        height: 100%;
        background-color: #fff;
        position: fixed;
        top: 0;
        right: -300px;
        transition: right 0.3s ease-in-out;
        z-index: 999;
        box-shadow: -2px 0 10px rgba(0,0,0,0.3);
    }

    .slide-panel.open {
        right: 0;
    }

    .slide-panel-content {
        padding: 30px;
        position: relative;
        font-size: 16px;
    }

    .close-btn {
        position: absolute;
        top: 10px;
        right: 20px;
        font-size: 26px;
        cursor: pointer;
        color: #999;
    }

    .close-btn:hover {
        color: #333;
    }

    .slide-panel-content h2 {
        color: #FF6B6B;
        margin-bottom: 20px;
        font-size: 20px;
    }

    .slide-panel-content ul {
        list-style-type: none;
        padding: 0;
    }

    .slide-panel-content li {
        margin-bottom: 10px;
    }

    .slide-panel-content a {
        color: #333;
        text-decoration: none;
        padding: 8px 12px;
        display: block;
        border-radius: 5px;
        transition: background-color 0.2s;
    }

    .slide-panel-content a:hover {
        background-color: #FFDCDC;
        color: #FF6B6B;
    }
  </style>
</head>
<body>

<div class="header">
  <!-- 첫 번째 줄: 로고 가운데, 로그인/로그아웃 오른쪽 -->
  <div class="header-line1">
    <div class="logo">
      <a href="/home" style="color: inherit; text-decoration: none;">INVEST YATRA</a>
    </div>
    <div class="auth-links">
      <c:choose>
        <c:when test="${not empty sessionScope.authInfo}">
          <c:choose>
            <c:when test="${sessionScope.authInfo.grade == 'mem'}">
              <span>${sessionScope.authInfo.userId}님 (일반회원)</span>
              <a href="#" onclick="openMyPage()">내 정보</a>
              <a href="/logout">로그아웃</a>
            </c:when>
            <c:when test="${sessionScope.authInfo.grade == 'emp'}">
              <span>${sessionScope.authInfo.userId}님 (관리자)</span>
              <a href="/adminMain?empNum=${sessionScope.authInfo.userNum}">관리하기</a>
              <a href="#" onclick="openMyPage()">내 정보</a>
              <a href="/logout">로그아웃</a>
            </c:when>
          </c:choose>
        </c:when>
        <c:otherwise>
          <a href="/login">로그인</a>
          <a href="/member/memberWrite">회원가입</a>
        </c:otherwise>
      </c:choose>
    </div>
  </div>

  <!-- 두 번째 줄: 메뉴 + 검색창 -->
  <div class="header-line2">
   <div class="nav-links">
        <a href="/news">뉴스</a>
        <a href="/stock">인기주식</a>
        <a href="/communityMain">토론장</a>
   </div>

    <div class="search-box">
      <form action="/search" method="get" style="display:flex;">
        <input type="text" name="query" placeholder="검색어 입력" />
        <button type="submit">🔍</button>
      </form>
    </div>
  </div>
</div>

<!-- 본문 영역 -->
<div class="main-content">
    <div class="container">
        <h1>👤 내 정보</h1>

        <c:if test="${not empty memberInfo.memberImg}">
            <div class="profile-image">
                <img src="/upload/${memberInfo.memberImg}" alt="프로필 이미지" />
            </div>
        </c:if>

        <div class="info-row">
            <span>아이디:</span> 
            <span class="info-value">${memberInfo.memberId}</span>
        </div>
        <div class="info-row">
            <span>회원번호:</span> 
            <span class="info-value">${memberInfo.memberNum}</span>
        </div>
        <div class="info-row">
            <span>이름:</span> 
            <span class="info-value">${memberInfo.memberName}</span>
        </div>
        <div class="info-row">
            <span>성별:</span> 
            <span class="info-value">${memberInfo.memberGender}</span>
        </div>
        <div class="info-row">
            <span>이메일:</span> 
            <span class="info-value">${memberInfo.memberEmail}</span>
        </div>
        <div class="info-row">
            <span>전화번호:</span> 
            <span class="info-value">${memberInfo.memberPhone}</span>
        </div>
        <div class="info-row">
            <span>주소:</span> 
            <span class="info-value">${memberInfo.memberAddr} ${memberInfo.memberDetailAddr}</span>
        </div>
        <div class="info-row">
            <span>우편번호:</span> 
            <span class="info-value">${memberInfo.memberPost}</span>
        </div>
        <div class="info-row">
            <span>생년월일:</span> 
            <span class="info-value">${fn:substringBefore(memberInfo.memberBirth, ' ')}</span>
        </div>
        <div class="info-row">
            <span>등급:</span> 
            <span class="info-value">${sessionScope.authInfo.grade}</span>
        </div>

        <div class="edit-button-container">
            <form action="/member/memberEdit" method="get">
                <button type="submit" class="edit-button">수정하기</button>
            </form>
        </div>
    </div>
</div>

<!-- 오버레이 -->
<div id="overlay" class="overlay" onclick="closeMyPage()"></div>

<!-- 오른쪽 슬라이딩 패널 -->
<div id="myPagePanel" class="slide-panel">
    <div class="slide-panel-content">
        <span class="close-btn" onclick="closeMyPage()">×</span>
        <h2>👤 내 정보</h2>
        <ul>
            <li><a href="/member/myPage">회원정보</a></li>
            <li><a href="/member/myAsset">내 자산</a></li>
            <li><a href="/myStoke">보유종목</a></li>
            <li><a href="/wish">관심종목</a></li>
            <li><a href="/inquiry">문의하기</a></li>
        </ul>
    </div>
</div>

<script>
function openMyPage() {
    document.getElementById("myPagePanel").classList.add("open");
    document.getElementById("overlay").style.display = "block";
}

function closeMyPage() {
    document.getElementById("myPagePanel").classList.remove("open");
    document.getElementById("overlay").style.display = "none";
}
</script>

</body>
</html>