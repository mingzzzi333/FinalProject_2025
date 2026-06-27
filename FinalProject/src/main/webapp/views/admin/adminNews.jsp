<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>관리자 뉴스 관리 페이지</title>
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

    /* 뉴스 관리 전용 스타일 */
    .news-header {
        text-align: center;
        margin-bottom: 30px;
    }

    .news-header h1 {
        color: #444;
        font-size: 28px;
        font-weight: 700;
        margin-bottom: 10px;
    }

    .page-info {
        margin-bottom: 15px;
        font-weight: bold;
        font-size: 16px;
        color: #555;
        text-align: center;
        background: #f8f9fa;
        padding: 15px;
        border-radius: 8px;
    }

    /* 뉴스 아이템 스타일 */
    .news-container {
        display: flex;
        flex-direction: column;
        gap: 20px;
        margin-bottom: 30px;
    }

    .news-item {
        display: flex;
        align-items: flex-start;
        gap: 20px;
        padding: 20px;
        background: #fff;
        border-radius: 12px;
        box-shadow: 0 6px 20px rgba(0, 0, 0, 0.08);
        transition: all 0.3s ease;
        cursor: pointer;
        border: 2px solid transparent;
    }

    .news-item:hover {
        transform: translateY(-4px);
        box-shadow: 0 12px 28px rgba(0, 0, 0, 0.12);
        border-color: #444;
    }

    .news-index {
        background: #444;
        color: #fff;
        width: 40px;
        height: 40px;
        display: flex;
        align-items: center;
        justify-content: center;
        border-radius: 50%;
        font-weight: 700;
        font-size: 14px;
        flex-shrink: 0;
    }

    .news-image {
        width: 120px;
        height: 80px;
        object-fit: cover;
        border-radius: 8px;
        flex-shrink: 0;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
    }

    .news-content {
        flex: 1;
        min-height: 80px;
        display: flex;
        flex-direction: column;
        justify-content: space-between;
    }

    .news-title {
        font-size: 18px;
        font-weight: 600;
        color: #333;
        margin: 0 0 10px 0;
        line-height: 1.4;
    }

    /* 페이지네이션 스타일 */
    .pagination {
        display: flex;
        justify-content: center;
        align-items: center;
        gap: 8px;
        margin-top: 40px;
        flex-wrap: wrap;
    }

    .page-link {
        display: inline-block;
        padding: 10px 16px;
        text-decoration: none;
        color: #555;
        background: #fff;
        border: 2px solid #ddd;
        border-radius: 8px;
        font-weight: 600;
        font-size: 14px;
        transition: all 0.3s ease;
        min-width: 40px;
        text-align: center;
    }

    .page-link:hover {
        background: #f8f9fa;
        border-color: #444;
        color: #444;
        transform: translateY(-1px);
    }

    /* 데이터 없을 때 */
    .no-data {
        text-align: center;
        padding: 60px 20px;
        color: #666;
        font-size: 18px;
        background: #f8f9fa;
        border-radius: 12px;
        margin: 20px 0;
    }

    .no-data::before {
        content: "📰";
        display: block;
        font-size: 48px;
        margin-bottom: 20px;
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

    /* 반응형 디자인 */
    @media (max-width: 768px) {
        .header-line1 {
            flex-direction: column;
            gap: 10px;
            text-align: center;
        }
        
        .header-line2 {
            padding: 12px 20px;
            flex-direction: column;
            gap: 15px;
        }
        
        .main-content {
            padding: 20px;
        }
        
        .news-item {
            flex-direction: column;
            text-align: center;
        }
        
        .news-image {
            width: 100%;
            height: 200px;
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
    <!-- 뉴스 관리 헤더 -->
    <div class="news-header">
      <h1>경제 뉴스</h1>
    </div>
    
    <div class="page-info">
      현재 페이지: ${currentPage} / 전체 페이지: ${totalPages}
    </div>

    <c:choose>
      <c:when test="${not empty newsList}">
        <div class="news-container">
          <c:forEach var="news" items="${newsList}" varStatus="status">
            <div class="news-item" onclick="window.open('${news.link}', '_blank')">
              <div class="news-index">
                ${ (currentPage - 1) * pageSize + status.index + 1 }
              </div>
              <img class="news-image" src="${news.imageUrl}" alt="뉴스 이미지" />
              <div class="news-content">
                <h3 class="news-title" title="${news.title}">
                  <c:choose>
                    <c:when test="${fn:length(news.title) > 40}">
                      ${fn:substring(news.title, 0, 40)}...
                    </c:when>
                    <c:otherwise>
                      ${news.title}
                    </c:otherwise>
                  </c:choose>
                </h3>
                <div>
                  <p style="font-size: 12px; color: #999;">작성일: ${news.pubDate}</p>
                </div>
              </div>
            </div>
          </c:forEach>
        </div>
      </c:when>
      <c:otherwise>
        <div class="no-data">
          <p>뉴스 데이터를 불러올 수 없습니다.</p>
        </div>
      </c:otherwise>
    </c:choose>

    <!-- 페이지 네비게이션 바 -->
    <div class="pagination">
      <c:if test="${currentPage > 1}">
        <a href="/news/crawled?page=${currentPage - 1}" class="page-link">이전</a>
      </c:if>

      <c:forEach begin="1" end="${totalPages}" var="i">
        <a href="/news/crawled?page=${i}" class="page-link"
           style="${i == currentPage ? 'background-color: #800080; color: white; font-weight: bold;' : ''}">
           ${i}
        </a>
      </c:forEach>

      <c:if test="${currentPage < totalPages}">
        <a href="/news/crawled?page=${currentPage + 1}" class="page-link">다음</a>
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