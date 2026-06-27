<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>메인 화면</title>
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

    /* 메인 페이지 전용 스타일 */
    .main-section {
        display: flex;
        gap: 20px;
        margin-bottom: 40px;
        padding: 0 24px;
    }

    .section-row {
        flex: 1;
        background: #fff;
        padding: 24px;
        border-radius: 12px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
    }

    .section-half {
        flex: 1;
        background: #fff;
        padding: 24px;
        border-radius: 12px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
    }

    h2 {
        color: #FF6B6B;
        margin-bottom: 20px;
        font-size: 20px;
        font-weight: 600;
    }

    .company-table {
        width: 100%;
        border-collapse: collapse;
        border-radius: 12px;
        overflow: hidden;
        box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        font-size: 14px;
        margin-top: 20px;
    }

    .company-table thead {
        background-color: #fff0f0;
    }

    .company-table th, .company-table td {
        padding: 13px 20px;
        text-align: left;
        border-bottom: 1px solid #ffe5e5;
        max-width: 300px;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
    }

    .company-table th {
        color: #333;
        font-weight: 600;
    }

    .company-table td {
        color: #555;
    }

    .company-table a.company-link {
        color: #FF6B6B;
        text-decoration: none;
        font-weight: bold;
    }

    .company-table a.company-link:hover {
        text-decoration: underline;
    }

    .company-table tr:hover {
        background-color: #fef9f9;
    }

    /* 뉴스 슬라이더 */
    .news-section {
        background: #fff;
        padding: 30px;
        border-radius: 12px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
        margin: 20px 24px;
    }

    .news-slider-container {
        display: flex;
        flex-direction: column;
        align-items: center;
        position: relative;
    }

    .news-slider-wrapper {
        display: flex;
        align-items: center;
        justify-content: center;
        width: 100%;
    }

    .news-slider {
        display: flex;
        overflow: hidden;
        scroll-behavior: smooth;
        width: 90%;
        padding: 10px 0;
        margin: 0 20px;
    }

    .news-item {
        flex: 0 0 auto;
        width: 200px;
        margin: 0 10px;
        cursor: pointer;
        text-align: center;
        border-radius: 10px;
        transition: transform 0.3s ease;
    }

    .news-item img {
        width: 100%;
        height: 140px;
        object-fit: cover;
        border-radius: 10px;
        transition: transform 0.3s ease;
    }

    .news-item img:hover {
        transform: scale(1.05);
    }

    .news-title {
        margin-top: 5px;
        font-size: 14px;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
        color: #333;
    }

    .arrow-button {
        width: 40px;
        height: 40px;
        margin-bottom: 30px;
        background-color: white;
        border: 2px solid #FF6B6B;
        color: #FF6B6B;
        border-radius: 50%;
        font-size: 20px;
        font-weight: bold;
        cursor: pointer;
        box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
        transition: all 0.3s ease;
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .arrow-button:hover {
        background-color: #FF6B6B;
        color: white;
    }

    .more-button {
        margin-top: 15px;
        background-color: #FF6B6B;
        color: white;
        border: none;
        border-radius: 20px;
        padding: 8px 20px;
        font-size: 14px;
        cursor: pointer;
        transition: background-color 0.3s ease;
        box-shadow: 0 2px 5px rgba(0,0,0,0.1);
    }

    .more-button:hover {
        background-color: #e85757;
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
  <div class="main-section">
    <!-- 왼쪽: 기업 리스트 -->
    <div class="section-row">
      <h2>📊 기업 리스트</h2>
      <table class="company-table" style="margin-bottom: 30px; width: 100%;">
        <thead>
          <tr>
            <th>No.</th>
            <th>기업명</th>
            <th>업종</th>
          </tr>
        </thead>
        <tbody>
          <c:choose>
            <c:when test="${not empty companyList}">
              <c:forEach var="company" items="${companyList}" varStatus="status">
                <c:if test="${status.index < 5}">
                  <tr>
                    <td>${status.index + 1}</td>
                    <td>
                      <a href="/company/${company.companyNum}" class="company-link">${company.companyName}</a>
                    </td>
                    <td>${company.companyType}</td>
                  </tr>
                </c:if>
              </c:forEach>
            </c:when>
            <c:otherwise>
              <tr>
                <td colspan="3" style="text-align: center;">📭 검색 결과가 없습니다</td>
              </tr>
            </c:otherwise>
          </c:choose>
        </tbody>
      </table>
    </div>

    <!-- 오른쪽: 인기커뮤니티 -->
    <div class="section-half">
      <h2>📊 인기커뮤니티</h2>
      <table class="company-table" style="margin-bottom: 30px; width: 100%;">
        <thead>
          <tr>
            <th>No.</th>
            <th>제목</th>
            <th>작성일자</th>
            <th>좋아요</th>
          </tr>
        </thead>
        <tbody>
          <c:choose>
            <c:when test="${not empty list}">
              <c:forEach var="item" items="${list}" varStatus="status">
                <c:if test="${status.index < 5}">
                  <tr>
                    <td>${status.index + 1}</td>
                    <td>
                      <a href="detail?commuNum=${item.commuNum}&boardNum=${boardNum}" class="company-link">
                        ${item.commuSubject}
                      </a>
                    </td>
                    <td>
                      <fmt:formatDate value="${item.commuRegist}" pattern="yyyy-MM-dd"/>
                    </td>
                    <td>${item.commuGood}</td>
                  </tr>
                </c:if>
              </c:forEach>
            </c:when>
            <c:otherwise>
              <tr>
                <td colspan="4" style="text-align: center;">📭 등록된 게시글이 없습니다</td>
              </tr>
            </c:otherwise>
          </c:choose>
        </tbody>
      </table>
    </div>
  </div>

  <!-- 뉴스 섹션 -->
  <div class="news-section">
    <h2>📰 뉴스 콘텐츠</h2>
    <div class="news-slider-container">
      <div class="news-slider-wrapper">
        <button id="prevBtn" class="arrow-button">&larr;</button>
        <div class="news-slider">
          <c:forEach var="news" items="${newsList}">
            <div class="news-item" onclick="window.open('${news.link}', '_blank')">
              <img src="${news.imageUrl}" alt="뉴스 이미지" />
              <p class="news-title" title="${news.title}">
                <c:choose>
                  <c:when test="${fn:length(news.title) > 15}">
                    ${fn:substring(news.title, 0, 15)}...
                  </c:when>
                  <c:otherwise>
                    ${news.title}
                  </c:otherwise>
                </c:choose>
              </p>
              <p style="font-size: 12px; color: #999; margin: 2px 0 0 0;">작성일: ${news.pubDate}</p>
            </div>
          </c:forEach>
        </div>
        <button id="nextBtn" class="arrow-button">&rarr;</button>
      </div>
      <button id="moreBtn" class="more-button">더보기</button>
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
            <li><a href="/wish/wishList">관심종목</a></li>
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

// 뉴스 슬라이더 스크립트
const slider = document.querySelector('.news-slider');
const prevBtn = document.getElementById('prevBtn');
const nextBtn = document.getElementById('nextBtn');

const scrollAmount = 190;

prevBtn.addEventListener('click', () => {
    slider.scrollBy({ left: -scrollAmount, behavior: 'smooth' });
});

nextBtn.addEventListener('click', () => {
    slider.scrollBy({ left: scrollAmount, behavior: 'smooth' });
});

// 뉴스 더보기 버튼
document.getElementById("moreBtn").addEventListener("click", function() {
    window.location.href = "/news/crawled";
});
</script>
</body>
</html>