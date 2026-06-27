<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>관리자 메인 페이지</title>
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
        background: #444;
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
        background: #BFBFBF;
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

    /* 본문 영역 */
    .main-content {
        background: #ffffff;
        min-height: calc(100vh - 150px);
        padding: 30px;
    }

    /* 관리자 페이지 전용 스타일 */
    .admin-container {
        max-width: 1200px;
        margin: 0 auto;
        padding: 0 24px;
    }

    .admin-header {
        text-align: center;
        margin-bottom: 40px;
        padding: 40px 0;
    }

    .admin-header h1 {
        color: #444;
        font-size: 36px;
        font-weight: 700;
        margin-bottom: 20px;
        letter-spacing: 1px;
    }

    .admin-header p {
        color: #666;
        font-size: 18px;
        font-weight: 500;
    }

    /* 사이드바 스타일 */
    .sidebar {
        background: #fff;
        padding: 32px;
        border-radius: 16px;
        box-shadow: 0 6px 20px rgba(0, 0, 0, 0.08);
        margin-bottom: 40px;
        border: 2px solid #e0e0e0;
    }

    .sidebar h3 {
        color: #333;
        font-size: 20px;
        font-weight: 600;
        margin-bottom: 20px;
        display: flex;
        align-items: center;
        gap: 10px;
    }

    .board-list {
        list-style: none;
        padding: 0;
        margin: 0;
    }

    .board-list li {
        margin-bottom: 12px;
        padding: 12px 16px;
        background: #f8f9fa;
        border-radius: 8px;
        transition: all 0.3s ease;
        border-left: 4px solid #444;
    }

    .board-list li:hover {
        background: #e9ecef;
        transform: translateX(5px);
    }

    .board-list a {
        text-decoration: none;
        color: #333;
        font-weight: 500;
        font-size: 16px;
        display: block;
    }

    .board-list a:hover {
        color: #ff6b6b;
    }

    .create-board-btn {
        display: inline-block;
        background: #444;
        color: #fff;
        padding: 15px 30px;
        border-radius: 25px;
        text-decoration: none;
        font-weight: 600;
        font-size: 16px;
        transition: all 0.3s ease;
        box-shadow: 0 4px 12px rgba(68, 68, 68, 0.3);
        margin-bottom: 30px;
    }

    .create-board-btn:hover {
        background: #666;
        transform: translateY(-2px);
        box-shadow: 0 6px 16px rgba(68, 68, 68, 0.4);
    }

    .board-count {
        color: #666;
        font-size: 16px;
        font-weight: 500;
        margin-bottom: 20px;
        padding: 10px 15px;
        background: #f0f0f0;
        border-radius: 20px;
        display: inline-block;
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
              <a href="/logout">로그아웃</a>
            </c:when>
          </c:choose>
        </c:when>
      </c:choose>
    </div>
  </div>

  <!-- 두 번째 줄: 관리자 메뉴 -->
  <div class="header-line2">
   <div class="nav-links">
        <a href="/admin/stock/form">📈 주식 등록 · 목록</a>
        <a href="/admin/newsAdmin">📰 뉴스 등록</a>
        <a href="/admin/company/form">🏢 기업 등록</a>
        <a href="/admin/communityAdmin?empNum=${sessionScope.authInfo.userNum}">💬 토론장 관리</a>
        <a href="/admin/inquiry/list">❓ 문의 답변</a>
   </div>

    <div class="search-box">
      <form action="/search" method="get" style="display:flex;">
        <input type="text" name="query" style="padding: 10px 18px; font-size: 14px; border: none; width: 280px; outline: none; border-radius: 25px 0 0 25px;" />
        <button type="submit" style="background-color: #444; border: none; color: white; padding: 0 18px; font-size: 18px; cursor: pointer; border-radius: 0 25px 25px 0;">🔍</button>
      </form>
    </div>
  </div>
</div>

<!-- 본문 영역 -->
<div class="main-content">
  <div class="admin-container">
    <!-- 관리자 헤더 -->
    <div class="admin-header">
      <h1>🔧 게시판 생성</h1>
      <p>새로운 게시판을 생성하고, 관리하세요.</p>
    </div>

    <!-- 게시판 생성 버튼 -->
    <a href="/admin/boardWrite?empNum=${sessionScope.authInfo.userNum}" class="create-board-btn">
      ➕ 게시판 생성
    </a>

    <!-- 게시판 목록 -->
    <div class="sidebar">
      <h3>📂 내가 만든 게시판</h3>
      <div class="board-count">게시판 개수: ${fn:length(boardList)}</div>
      <ul class="board-list">
        <c:forEach var="board" items="${boardList}">
          <li>
            <a href="/community/list?boardNum=${board.boardNum}&boardTitle=${board.boardTitle}">
            ${board.boardTitle}
             </a>
          </li>
        </c:forEach>
      </ul>
    </div>
  </div>
</div>

<!-- 오버레이 -->
<div id="overlay" class="overlay" onclick="closeMyPage()"></div>

<!-- 오른쪽 슬라이딩 패널 -->
<div id="myPagePanel" class="slide-panel">
    <div class="slide-panel-content">
        <span class="close-btn" onclick="closeMyPage()">×</span>
        <h2>👤 관리자 정보</h2>
        <ul>
            <li><a href="/admin/profile">관리자 프로필</a></li>
            <li><a href="/admin/settings">시스템 설정</a></li>
            <li><a href="/admin/logs">접속 로그</a></li>
            <li><a href="/admin/backup">데이터 백업</a></li>
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