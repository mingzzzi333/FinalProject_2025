<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>문의 상세 - 관리자</title>
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

    /* 문의 상세 페이지 전용 스타일 */
    .inquiry-container {
        max-width: 800px;
        margin: 0 auto;
        padding: 0 24px;
    }

    .inquiry-header {
        text-align: center;
        margin-bottom: 40px;
        padding: 40px 0;
    }

    .inquiry-header h1 {
        color: #444;
        font-size: 32px;
        font-weight: 700;
        margin-bottom: 15px;
        letter-spacing: 0.5px;
    }

    .inquiry-card {
        background: #fff;
        padding: 40px;
        border-radius: 16px;
        box-shadow: 0 6px 20px rgba(0, 0, 0, 0.08);
        margin-bottom: 30px;
        border: 1px solid #e5e7eb;
    }

    .inquiry-info {
        display: grid;
        grid-template-columns: 120px 1fr;
        gap: 20px;
        margin-bottom: 30px;
    }

    .inquiry-info .label {
        font-weight: 600;
        color: #444;
        font-size: 16px;
        padding: 12px 0;
    }

    .inquiry-info .value {
        padding: 12px;
        background: #f8f9fa;
        border-radius: 8px;
        font-size: 15px;
        color: #333;
        min-height: 20px;
    }

    .inquiry-content {
        grid-column: 1 / -1;
        margin-top: 20px;
    }

    .inquiry-content .label {
        margin-bottom: 12px;
    }

    .inquiry-content .value {
        padding: 20px;
        background: #f8f9fa;
        border-radius: 12px;
        line-height: 1.8;
        font-size: 15px;
        min-height: 120px;
        white-space: pre-wrap;
    }

    .answer-section {
        background: #fff;
        padding: 40px;
        border-radius: 16px;
        box-shadow: 0 6px 20px rgba(0, 0, 0, 0.08);
        border: 1px solid #e5e7eb;
    }

    .answer-section h3 {
        color: #444;
        font-size: 20px;
        font-weight: 600;
        margin-bottom: 20px;
        display: flex;
        align-items: center;
        gap: 8px;
    }

    .answer-form textarea {
        width: 100%;
        min-height: 150px;
        padding: 20px;
        border: 2px solid #e5e7eb;
        border-radius: 12px;
        font-family: 'Montserrat', sans-serif;
        font-size: 15px;
        line-height: 1.6;
        resize: vertical;
        transition: border-color 0.3s ease;
        box-sizing: border-box;
    }

    .answer-form textarea:focus {
        outline: none;
        border-color: #444;
        box-shadow: 0 0 0 3px rgba(68, 68, 68, 0.1);
    }

    .answer-form button {
        background: #444;
        color: #fff;
        padding: 15px 30px;
        border: none;
        border-radius: 25px;
        font-weight: 600;
        font-size: 15px;
        cursor: pointer;
        transition: all 0.3s ease;
        margin-top: 20px;
        box-shadow: 0 4px 12px rgba(68, 68, 68, 0.2);
    }

    .answer-form button:hover {
        background: #333;
        transform: translateY(-2px);
        box-shadow: 0 6px 16px rgba(68, 68, 68, 0.3);
    }

    .existing-answer {
        background: #f0f9ff;
        border: 2px solid #0ea5e9;
        border-radius: 12px;
        padding: 25px;
        font-size: 15px;
        line-height: 1.8;
        color: #0c4a6e;
        white-space: pre-wrap;
    }

    .back-button {
        display: inline-block;
        background: #6b7280;
        color: #fff;
        padding: 12px 24px;
        border-radius: 25px;
        text-decoration: none;
        font-weight: 600;
        font-size: 14px;
        transition: all 0.3s ease;
        margin-bottom: 30px;
        box-shadow: 0 4px 12px rgba(107, 114, 128, 0.2);
    }

    .back-button:hover {
        background: #4b5563;
        transform: translateY(-2px);
        box-shadow: 0 6px 16px rgba(107, 114, 128, 0.3);
        text-decoration: none;
        color: #fff;
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
        <c:otherwise>
          <a href="/login">로그인</a>
          <a href="/member/memberWrite">회원가입</a>
        </c:otherwise>
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
  <div class="inquiry-container">
    <!-- 문의 상세 헤더 -->
    <div class="inquiry-header">
      <h1>❓ 문의 상세</h1>
    </div>

    <!-- 뒤로 가기 버튼 -->
    <a href="/admin/inquiry/list" class="back-button">← 목록으로 돌아가기</a>

    <!-- 문의 정보 카드 -->
    <div class="inquiry-card">
      <div class="inquiry-info">
        <div class="label">문의자</div>
        <div class="value">${inquiry.memberId}</div>
        
        <div class="label">제목</div>
        <div class="value">${inquiry.inquiryTitle}</div>
        
        <div class="inquiry-content">
          <div class="label">문의 내용</div>
          <div class="value">${inquiry.inquiryContent}</div>
        </div>
      </div>
    </div>

    <!-- 답변 섹션 -->
    <div class="answer-section">
      <c:choose>
        <c:when test="${empty inquiry.answerContent}">
          <h3>✏️ 답변 작성</h3>
          <form action="/admin/inquiry/answer" method="post" class="answer-form">
            <input type="hidden" name="inquiryNum" value="${inquiry.inquiryNum}" />
            <textarea name="answerContent" placeholder="문의에 대한 답변을 작성해주세요..." required></textarea>
            <button type="submit">답변 등록</button>
          </form>
        </c:when>
        <c:otherwise>
          <h3>✅ 등록된 답변</h3>
          <div class="existing-answer">${inquiry.answerContent}</div>
        </c:otherwise>
      </c:choose>
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