<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>내 자산 관리</title>
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

    /* 내 자산 페이지 전용 스타일 */
    .asset-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 30px;
      padding-bottom: 15px;
      border-bottom: 2px solid #FF9898;
    }

    .asset-title {
      font-size: 28px;
      font-weight: 700;
      color: #333;
    }

    .asset-form {
      background: white;
      padding: 30px;
      border-radius: 12px;
      box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
      margin-bottom: 30px;
    }

    .form-group {
      margin-bottom: 20px;
    }

    .form-group label {
      display: block;
      margin-bottom: 5px;
      font-weight: 600;
      color: #555;
    }

    .form-group input {
      width: 100%;
      padding: 12px 15px;
      border: 2px solid #e0e0e0;
      border-radius: 8px;
      font-size: 14px;
      transition: border-color 0.3s;
      box-sizing: border-box;
    }

    .form-group input:focus {
      outline: none;
      border-color: #FF9898;
      box-shadow: 0 0 5px rgba(255, 152, 152, 0.3);
    }

    .submit-btn {
      background: #FF9898;
      color: white;
      padding: 12px 30px;
      border: none;
      border-radius: 8px;
      font-weight: 600;
      font-size: 16px;
      cursor: pointer;
      transition: background-color 0.3s;
      width: 100%;
    }

    .submit-btn:hover {
      background: #e67b7b;
    }

    .preview-section {
      background: #FFEAEA;
      padding: 20px;
      border-radius: 12px;
      border-left: 4px solid #FF9898;
      margin-top: 20px;
    }

    .preview-section h3 {
      color: #FF6B6B;
      margin-bottom: 15px;
      font-size: 18px;
    }

    .preview-item {
      display: flex;
      justify-content: space-between;
      margin-bottom: 10px;
      padding: 8px 0;
      border-bottom: 1px dotted #ddd;
    }

    .preview-item:last-child {
      border-bottom: none;
    }

    .preview-label {
      font-weight: 600;
      color: #555;
    }

    .preview-value {
      color: #333;
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
      color: #FF9898;
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
      color: #FF9898;
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

<!-- 본문 영역 (내 자산 페이지 전용 내용) -->
<div class="main-content">
  <div class="asset-header">
    <h1 class="asset-title">💰 내 자산 관리</h1>
  </div>

  <div class="asset-form">
    <form action="/member/myAsset" method="post">
      <div class="form-group">
        <label for="accountNum">계좌번호</label>
        <input type="text" name="accountNum" id="accountNum" value="${account.accountNum}" 
               maxlength="12" placeholder="계좌번호를 입력하세요" />
      </div>
      
      <div class="form-group">
        <label for="accountName">예금주명</label>
        <input type="text" name="accountName" id="accountName" value="${account.accountName}" 
               maxlength="12" placeholder="예금주명을 입력하세요" />
      </div>
      
      <div class="form-group">
        <label for="accountCash">잔액</label>
        <input type="number" name="accountCash" id="accountCash" value="${account.accountCash}" 
               placeholder="잔액을 입력하세요" />
      </div>
      
      <input type="hidden" name="accountType" value="일반" />
      <button type="submit" class="submit-btn">💾 저장하기</button>
    </form>
  </div>

  <!-- 실시간 미리보기 -->
  <div class="preview-section">
    <h3>📋 입력 정보 미리보기</h3>
    <div class="preview-item">
      <span class="preview-label">계좌번호:</span>
      <span class="preview-value" id="previewAccountNum">-</span>
    </div>
    <div class="preview-item">
      <span class="preview-label">예금주명:</span>
      <span class="preview-value" id="previewAccountName">-</span>
    </div>
    <div class="preview-item">
      <span class="preview-label">잔액:</span>
      <span class="preview-value" id="previewAccountCash">0 원</span>
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
            <li><a href="/myPage">회원정보</a></li>
            <li><a href="/myAsset">내 자산</a></li>
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

// 실시간 미리보기 기능
const accountNumInput = document.getElementById("accountNum");
const accountNameInput = document.getElementById("accountName");
const accountCashInput = document.getElementById("accountCash");

const previewAccountNum = document.getElementById("previewAccountNum");
const previewAccountName = document.getElementById("previewAccountName");
const previewAccountCash = document.getElementById("previewAccountCash");

function updatePreview() {
    previewAccountNum.textContent = accountNumInput.value || '-';
    previewAccountName.textContent = accountNameInput.value || '-';
    
    const cashValue = accountCashInput.value;
    if (cashValue) {
        previewAccountCash.textContent = parseInt(cashValue).toLocaleString() + ' 원';
    } else {
        previewAccountCash.textContent = '0 원';
    }
}

// 입력 이벤트에 리스너 연결
accountNumInput.addEventListener("input", updatePreview);
accountNameInput.addEventListener("input", updatePreview);
accountCashInput.addEventListener("input", updatePreview);

// 초기 렌더링
updatePreview();
</script>
</body>
</html>