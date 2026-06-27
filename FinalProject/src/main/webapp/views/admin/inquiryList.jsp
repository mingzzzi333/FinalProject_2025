<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>문의 목록 - 관리자</title>
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

    /* 문의 목록 페이지 전용 스타일 */
    .inquiry-container {
        max-width: 1200px;
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

    .inquiry-header p {
        color: #666;
        font-size: 16px;
        font-weight: 500;
    }

    .inquiry-table-container {
        background: #fff;
        border-radius: 16px;
        box-shadow: 0 6px 20px rgba(0, 0, 0, 0.08);
        overflow: hidden;
        border: 1px solid #e5e7eb;
    }

    .inquiry-table {
        width: 100%;
        border-collapse: collapse;
        font-size: 15px;
    }

    .inquiry-table thead {
        background: linear-gradient(135deg, #444 0%, #666 100%);
        color: #fff;
    }

    .inquiry-table thead th {
        padding: 20px 16px;
        text-align: center;
        font-weight: 600;
        font-size: 14px;
        letter-spacing: 0.5px;
        border: none;
    }

    .inquiry-table tbody tr {
        border-bottom: 1px solid #f1f3f4;
        transition: all 0.2s ease;
        cursor: pointer;
    }

    .inquiry-table tbody tr:hover {
        background: linear-gradient(135deg, #f8f9ff 0%, #eef6ff 100%);
        transform: translateY(-1px);
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
    }

    .inquiry-table tbody tr:last-child {
        border-bottom: none;
    }

    .inquiry-table tbody td {
        padding: 20px 16px;
        border: none;
        vertical-align: middle;
    }

    .inquiry-table .col-no {
        width: 8%;
        text-align: center;
        font-weight: 600;
        color: #666;
    }

    .inquiry-table .col-title {
        width: 40%;
        font-weight: 500;
        color: #333;
    }

    .inquiry-table .col-title:hover {
        color: #444;
        font-weight: 600;
    }

    .inquiry-table .col-member {
        width: 15%;
        text-align: center;
        color: #555;
        font-weight: 500;
    }

    .inquiry-table .col-status {
        width: 12%;
        text-align: center;
    }

    .inquiry-table .col-date {
        width: 25%;
        text-align: center;
        color: #666;
        font-size: 14px;
    }

    .status-badge {
        display: inline-block;
        padding: 6px 12px;
        border-radius: 20px;
        font-size: 12px;
        font-weight: 600;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }

    .status-waiting {
        background: #fef3c7;
        color: #d97706;
        border: 1px solid #fbbf24;
    }

    .status-answered {
        background: #d1fae5;
        color: #059669;
        border: 1px solid #34d399;
    }

    .status-processing {
        background: #dbeafe;
        color: #2563eb;
        border: 1px solid #60a5fa;
    }

    .empty-state {
        text-align: center;
        padding: 60px 20px;
        color: #9ca3af;
    }

    .empty-state .icon {
        font-size: 48px;
        margin-bottom: 16px;
        display: block;
    }

    .empty-state h3 {
        font-size: 18px;
        font-weight: 600;
        margin-bottom: 8px;
        color: #6b7280;
    }

    .empty-state p {
        font-size: 14px;
        margin: 0;
    }

    .stats-container {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
        gap: 20px;
        margin-bottom: 30px;
    }

    .stats-card {
        background: #fff;
        padding: 24px;
        border-radius: 12px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
        text-align: center;
        border: 1px solid #e5e7eb;
    }

    .stats-card .number {
        font-size: 32px;
        font-weight: 700;
        color: #444;
        margin-bottom: 8px;
    }

    .stats-card .label {
        font-size: 14px;
        color: #666;
        font-weight: 500;
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
    <!-- 문의 목록 헤더 -->
    <div class="inquiry-header">
      <h1>📩 문의 목록 관리</h1>
      <p>회원들의 문의사항을 확인하고 답변을 작성하세요</p>
    </div>

    <!-- 통계 카드 -->
    <div class="stats-container">
      <div class="stats-card">
        <div class="number">${fn:length(inquiries)}</div>
        <div class="label">전체 문의</div>
      </div>
      <div class="stats-card">
        <div class="number">
          <c:set var="waitingCount" value="0" />
          <c:forEach var="i" items="${inquiries}">
            <c:if test="${i.inquiryStatus == '대기'}">
              <c:set var="waitingCount" value="${waitingCount + 1}" />
            </c:if>
          </c:forEach>
          ${waitingCount}
        </div>
        <div class="label">답변 대기</div>
      </div>
      <div class="stats-card">
        <div class="number">
          <c:set var="answeredCount" value="0" />
          <c:forEach var="i" items="${inquiries}">
            <c:if test="${i.inquiryStatus == '완료'}">
              <c:set var="answeredCount" value="${answeredCount + 1}" />
            </c:if>
          </c:forEach>
          ${answeredCount}
        </div>
        <div class="label">답변 완료</div>
      </div>
    </div>

    <!-- 문의 목록 테이블 -->
    <div class="inquiry-table-container">
      <c:choose>
        <c:when test="${not empty inquiries}">
          <table class="inquiry-table">
            <thead>
			  <tr>
			    <th class="col-no" style="color: #fff;">No</th>
			    <th class="col-title" style="color: #fff;">제목</th>
			    <th class="col-member" style="color: #fff;">문의자</th>
			    <th class="col-status" style="color: #fff;">상태</th>
			    <th class="col-date" style="color: #fff;">등록일</th>
			  </tr>
			</thead>
            <tbody>
              <c:forEach var="i" items="${inquiries}" varStatus="status">
                <tr onclick="location.href='/admin/inquiry/detail?inquiryNum=${i.inquiryNum}'">
                  <td class="col-no">${status.index + 1}</td>
                  <td class="col-title">${i.inquiryTitle}</td>
                  <td class="col-member">${i.memberId}</td>
                  <td class="col-status">
                    <c:choose>
                      <c:when test="${i.inquiryStatus == '대기'}">
                        <span class="status-badge status-waiting">대기</span>
                      </c:when>
                      <c:when test="${i.inquiryStatus == '완료'}">
                        <span class="status-badge status-answered">완료</span>
                      </c:when>
                      <c:otherwise>
                        <span class="status-badge status-processing">${i.inquiryStatus}</span>
                      </c:otherwise>
                    </c:choose>
                  </td>
                  <td class="col-date">
                    <fmt:formatDate value="${i.inquiryRegist}" pattern="yyyy-MM-dd HH:mm" />
                  </td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </c:when>
        <c:otherwise>
          <div class="empty-state">
            <span class="icon">📭</span>
            <h3>등록된 문의가 없습니다</h3>
            <p>회원들의 문의가 등록되면 여기에 표시됩니다.</p>
          </div>
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