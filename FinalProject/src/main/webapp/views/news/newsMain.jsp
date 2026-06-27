<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>뉴스</title>
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

    /* 뉴스 페이지 전용 스타일 */
    .news-container {
        max-width: 1200px;
        margin: 0 auto;
        padding: 20px;
    }

    .news-header {
        background: #fff;
        padding: 30px;
        border-radius: 12px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
        margin-bottom: 20px;
        text-align: center;
    }

    .news-header h1 {
        color: #FF6B6B;
        margin: 0 0 15px 0;
        font-size: 32px;
        font-weight: 600;
    }

    .page-info {
        font-size: 16px;
        color: #666;
        font-weight: 500;
    }

    .news-list {
        background: #fff;
        padding: 20px;
        border-radius: 12px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
    }

    .news-item {
        display: flex;
        gap: 15px;
        align-items: center;
        border: 1px solid #ffe5e5;
        border-radius: 12px;
        padding: 15px;
        margin-bottom: 15px;
        background-color: #fef9f9;
        cursor: pointer;
        transition: all 0.3s ease;
    }

    .news-item:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(255, 107, 107, 0.15);
        border-color: #FF6B6B;
    }

    .news-index {
        width: 40px;
        height: 40px;
        display: flex;
        align-items: center;
        justify-content: center;
        background: linear-gradient(135deg, #FF6B6B, #ff8a8a);
        color: white;
        font-weight: bold;
        font-size: 14px;
        border-radius: 50%;
        flex-shrink: 0;
    }

    .news-image {
        width: 120px;
        height: 80px;
        object-fit: cover;
        border-radius: 8px;
        flex-shrink: 0;
        border: 2px solid #ffe5e5;
    }

    .news-content {
        flex: 1;
        display: flex;
        flex-direction: column;
        gap: 8px;
    }

    .news-title {
        font-size: 16px;
        font-weight: 600;
        margin: 0;
        color: #333;
        line-height: 1.4;
    }

    .news-date {
        font-size: 13px;
        color: #999;
        font-weight: 500;
    }

    /* 페이지네이션 스타일 */
    .pagination {
        display: flex;
        justify-content: center;
        align-items: center;
        margin-top: 40px;
        gap: 8px;
        flex-wrap: wrap;
    }

    .page-link {
        padding: 10px 16px;
        border-radius: 8px;
        background-color: #fff;
        color: #FF6B6B;
        text-decoration: none;
        font-size: 14px;
        font-weight: 600;
        border: 2px solid #ffe5e5;
        transition: all 0.3s ease;
        min-width: 40px;
        text-align: center;
    }

    .page-link:hover {
        background-color: #FF6B6B;
        color: white;
        border-color: #FF6B6B;
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(255, 107, 107, 0.3);
    }

    .page-link.active {
        background-color: #FF6B6B !important;
        color: white !important;
        border-color: #FF6B6B !important;
        box-shadow: 0 4px 12px rgba(255, 107, 107, 0.3);
    }

    .no-news {
        text-align: center;
        padding: 60px;
        color: #999;
        font-size: 18px;
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

    @media (max-width: 768px) {
        .news-item {
            flex-direction: column;
            text-align: center;
        }
        
        .news-image {
            width: 100%;
            max-width: 200px;
            height: 120px;
        }
        
        .news-container {
            padding: 10px;
        }
        
        .pagination {
            gap: 4px;
        }
        
        .page-link {
            padding: 8px 12px;
            font-size: 12px;
        }
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
  <div class="news-container">
    <div class="news-header">
      <h1>📰 경제 뉴스</h1>
      <div class="page-info">
        현재 페이지: <strong>${currentPage}</strong> / 전체 페이지: <strong>${totalPages}</strong>
      </div>
    </div>

    <div class="news-list">
      <c:choose>
        <c:when test="${not empty newsList}">
          <c:forEach var="news" items="${newsList}" varStatus="status">
            <div class="news-item" onclick="window.open('${news.link}', '_blank')">
              <div class="news-index">
                ${ (currentPage - 1) * pageSize + status.index + 1 }
              </div>
              <img class="news-image" src="${news.imageUrl}" alt="뉴스 이미지" />
              <div class="news-content">
                <h3 class="news-title" title="${news.title}">
                  <c:choose>
                    <c:when test="${fn:length(news.title) > 50}">
                      ${fn:substring(news.title, 0, 50)}...
                    </c:when>
                    <c:otherwise>
                      ${news.title}
                    </c:otherwise>
                  </c:choose>
                </h3>
                <div class="news-date">📅 ${news.pubDate}</div>
              </div>
            </div>
          </c:forEach>
        </c:when>
        <c:otherwise>
          <div class="no-news">
            📭 뉴스 데이터를 불러올 수 없습니다.
          </div>
        </c:otherwise>
      </c:choose>
    </div>

    <!-- 페이지 네비게이션 바 -->
    <div class="pagination">
      <c:if test="${currentPage > 1}">
        <a href="/news/crawled?page=${currentPage - 1}" class="page-link">◀ 이전</a>
      </c:if>

      <c:forEach begin="1" end="${totalPages}" var="i">
        <a href="/news/crawled?page=${i}" 
           class="page-link ${i == currentPage ? 'active' : ''}">
           ${i}
        </a>
      </c:forEach>

      <c:if test="${currentPage < totalPages}">
        <a href="/news/crawled?page=${currentPage + 1}" class="page-link">다음 ▶</a>
      </c:if>
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