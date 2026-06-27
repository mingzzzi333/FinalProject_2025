<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>관심기업 목록</title>
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
        margin: 0 24px;
        border-radius: 12px;
        margin-top: 20px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
    }

    /* 찜목록 페이지 전용 스타일 */
    .wishlist-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 30px;
        padding-bottom: 20px;
        border-bottom: 2px solid #ffe5e5;
    }

    .wishlist-title {
        color: #FF6B6B;
        font-size: 28px;
        font-weight: 700;
        margin: 0;
    }

    .wishlist-count {
        background: #fff0f0;
        color: #FF6B6B;
        padding: 8px 16px;
        border-radius: 20px;
        font-weight: 600;
        border: 2px solid #ffe5e5;
    }

    .message {
        padding: 15px 20px;
        border-radius: 8px;
        margin-bottom: 20px;
        font-weight: 500;
    }

    .message.info {
        background-color: #e3f2fd;
        color: #1976d2;
        border: 1px solid #bbdefb;
    }

    .message.error {
        background-color: #ffebee;
        color: #d32f2f;
        border: 1px solid #ffcdd2;
    }

    .wishlist-table {
        width: 100%;
        border-collapse: collapse;
        border-radius: 12px;
        overflow: hidden;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
        background: #fff;
    }

    .wishlist-table thead {
        background: linear-gradient(135deg, #FF6B6B, #ff8a8a);
    }

    .wishlist-table th {
        padding: 18px 24px;
        text-align: left;
        color: #fff;
        font-weight: 600;
        font-size: 16px;
        letter-spacing: 0.5px;
    }

    .wishlist-table td {
        padding: 16px 24px;
        border-bottom: 1px solid #f5f5f5;
        color: #555;
        font-size: 15px;
    }

    .wishlist-table tr:hover {
        background-color: #fef9f9;
        transform: translateY(-1px);
        transition: all 0.3s ease;
    }

    .wishlist-table tr:last-child td {
        border-bottom: none;
    }

    .company-link {
        color: #FF6B6B;
        text-decoration: none;
        font-weight: 600;
        transition: all 0.3s ease;
    }

    .company-link:hover {
        color: #e85757;
        text-decoration: underline;
    }

    .empty-message {
        text-align: center;
        padding: 60px 20px;
        color: #999;
        font-size: 18px;
        background: #fafafa;
        border-radius: 12px;
        border: 2px dashed #ddd;
    }

    .empty-message .icon {
        font-size: 48px;
        margin-bottom: 20px;
        color: #ccc;
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

<!-- 본문 영역: 찜목록 -->
<div class="main-content">
  <div class="wishlist-header">
    <h1 class="wishlist-title">💝 관심기업 목록</h1>
    <div class="wishlist-count">총 ${wishCount}개 기업</div>
  </div>

  <!-- 메시지 표시 -->
  <c:if test="${not empty message}">
    <div class="message info">${message}</div>
  </c:if>

  <c:if test="${not empty error}">
    <div class="message error">${error}</div>
  </c:if>

  <!-- 찜목록 테이블 -->
  <c:choose>
    <c:when test="${wishCount > 0}">
      <table class="wishlist-table">
        <thead>
          <tr>
            <th>회사명</th>
            <th>찜 등록일</th>
            <th>작업</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="wish" items="${wishList}">
            <tr>
              <td>
                <a href="/company/detail?companyNum=${wish.companyNum}" class="company-link">
                  ${wish.companyName}
                </a>
              </td>
              <td>
                <fmt:formatDate value="${wish.wishDate}" pattern="yyyy년 MM월 dd일" />
              </td>
              <td>
                <button onclick="removeWish('${wish.companyNum}')" 
                 style="background:#ff6b6b; color:white; border:none; padding:6px 12px; border-radius:4px; cursor:pointer; font-size:12px;">
                삭제
            </button>
              </td>
            </tr>
          </c:forEach>
        </tbody>
      </table>
    </c:when>
    <c:otherwise>
      <div class="empty-message">
        <div class="icon">📭</div>
        <div>아직 관심 등록한 기업이 없습니다.</div>
        <div style="font-size: 14px; margin-top: 10px; color: #bbb;">
          기업 상세페이지에서 ❤️ 버튼을 클릭하여 관심기업을 등록해보세요!
        </div>
      </div>
    </c:otherwise>
  </c:choose>
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
            <li><a href="/wish/wishList" style="background-color: #FFDCDC; color: #FF6B6B;">관심종목</a></li>
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

function removeWish(companyNum) {
    if (confirm('해당 기업을 관심목록에서 삭제하시겠습니까?')) {
        fetch('/wish/remove', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: 'companyNum=' + encodeURIComponent(companyNum)
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                alert('관심목록에서 삭제되었습니다.');
                location.reload();
            } else {
                alert('삭제 중 오류가 발생했습니다.');
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert('삭제 중 오류가 발생했습니다.');
        });
    }
}
</script>
</body>
</html>