<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page session="true" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>메인 화면</title>
    <style>
        html, body {
            margin: 0;
            padding: 0;
            height: 100%;
            width: 100%;
            box-sizing: border-box;
            background-color: #FFF2EB;
            font-family: Arial, sans-serif;
        }

        .no-style-link {
            text-decoration: none;
            color: inherit;
        }

        .no-style-link:hover,
        .no-style-link:visited,
        .no-style-link:active {
            text-decoration: none;
            color: inherit;
        }

        .header {
            width: 100%;
            height: 100px;
            background-color: #f5f5f5;
            border-bottom: 1px solid #ccc;
        }

        .header-line1, .header-line2 {
            height: 50%;
            padding: 0 20px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .header-line1 {
          height: 50%;
          padding: 0 20px;
          display: flex;
          align-items: center;
          justify-content: space-between;
          background: #FF9898;
          color: #FFF;
      }

      .left-section,
      .center-section,
      .auth-buttons {
          flex: 1;
      }
      .center-section {
          text-align: center;
      }
      .auth-buttons {
          text-align: right;
      }
      
        .header-line2 {
            background: #FFDCDC;
        }

        .auth-buttons a, .nav-links a {
            margin-left: 10px;
            text-decoration: none;
            color: #333;
            font-weight: bold;
        }

        .auth-buttons a:hover, .nav-links a:hover {
            text-decoration: underline;
        }

        .main-content {
            width: 100%;
            height: calc(100% - 100px);
            background: #FFF2EB;
            overflow: auto;
            padding: 20px;
        }

        .search-form button:hover {
          background-color: #FF9898;
      }

       .search-box input[type="text"] {
           border : 1px;
           border-radius: 20px 0 0 20px;
           margin-top: 2px;
            width: 600px;
            height: 20px;
            padding: 10px;
            font-size: 14px;
        }

        .search-box button {
           border : 1px;
           border-radius: 0 20px 20px 0;
           margin-top: 2px;
            width: 100px;
            height: 40px;
            padding: 5px 10px;
            font-size: 14px;
            cursor: pointer;
        }


        .nav-search-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            width: 100%;
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

        /* 슬라이딩 패널 스타일 */
      .slide-panel {
          width: 20%;
          height: 100%;
          background-color: #FFDCDC;
          position: fixed;
          top: 0;
          right: -50%;
          transition: right 0.3s ease-in-out;
          z-index: 999;
          box-shadow: -2px 0 12px rgba(255, 152, 152, 0.4);
          border-left: 5px solid #FF9898;
          font-family: 'Arial', sans-serif;
      }
      
      .slide-panel.open {
          right: 0;
      }
      
      .slide-panel-content {
          padding: 30px 20px;
          position: relative;
          font-size: 16px;
          color: #333;
          background-color: #fff;
          border-radius: 10px;
          margin: 20px;
          box-shadow: 0 0 10px rgba(255, 152, 152, 0.2);
      }
      
      .close-btn {
          position: absolute;
          top: 10px;
          right: 20px;
          font-size: 26px;
          font-weight: bold;
          color: #FF9898;
          cursor: pointer;
          transition: color 0.2s ease;
      }
      
      .close-btn:hover {
          color: #cc6d6d;
      }
      
      .slide-panel-content h2 {
          color: #FF6B6B;
          margin-bottom: 20px;
          border-bottom: 2px solid #FF9898;
          padding-bottom: 10px;
      }
      
      /* UL 메뉴 스타일 */
      .panel-menu {
          list-style-type: none;
          padding-left: 0;
      }
      
      .panel-menu li {
          margin: 15px 0;
      }
      
      .panel-menu li a {
          text-decoration: none;
          color: #333;
          font-weight: bold;
          padding: 10px 15px;
          display: block;
          border-radius: 6px;
          background-color: #ffeaea;
          transition: all 0.3s ease;
      }
      
      .panel-menu li a:hover {
          background-color: #FF9898;
          color: white;
      }

      
    </style>
</head>
<body>
<div class="header">
    <div class="header-line1">
    <div class="left-section" style="flex: 1;"></div>

    <div class="center-section" style="flex: 1; text-align: center;">
        <a href="/home" class="no-style-link">INVEST YATRA</a>
    </div>

    <div class="auth-buttons" style="flex: 1; text-align: right;">
        <c:choose>
            <c:when test="${not empty sessionScope.authInfo}">
                <c:choose>
                    <c:when test="${sessionScope.authInfo.grade == 'mem'}">
                        <a href="#" onclick="openMyPage()">내 정보</a> |
                        <a href="/logout">로그아웃</a>
                    </c:when>
                    <c:when test="${sessionScope.authInfo.grade == 'emp'}">
                        <a href="/adminMain">관리하기</a> |
                        <a href="/logout">로그아웃</a>
                    </c:when>
                </c:choose>
            </c:when>
            <c:otherwise>
                <a href="/login">로그인</a> |
                <a href="/member/memberWrite">회원가입</a>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<div class="header-line2">
    <div class="nav-search-container">
        <div class="nav-links">
            <a href="/news">뉴스</a> |
            <a href="/stock">인기주식</a> |
            <a href="/communityMain">토론장</a>
        </div>
        <div class="search-box">
            <form action="/search" method="get">
                <input type="text" name="query" placeholder="검색어 입력" />
                <button type="submit">🔍</button>
            </form>
        </div>
    </div>
</div>

</div>

<div class="main-content">

<form action="/member/myAsset" method="post">
    <input type="text" name="accountNum" id="accountNum" value="${account.accountNum}" maxlength="12" placeholder="계좌번호" />
    <input type="text" name="accountName" id="accountName" value="${account.accountName}" maxlength="12" placeholder="예금주명" />
    <input type="number" name="accountCash" id="accountCash" value="${account.accountCash}" placeholder="잔액" />
    <input type="hidden" name="accountType" value="일반" />
    <button type="submit">저장</button>
</form>

<!-- 실시간 출력 영역 -->
<div id="accountPreview" style="margin-top: 20px; padding: 10px; background: #ffeaea; border-radius: 10px;">
    <h3>입력 정보 미리보기</h3>
    <p>계좌번호: <span id="previewAccountNum"></span></p>
    <p>예금주명: <span id="previewAccountName"></span></p>
    <p>잔액: <span id="previewAccountCash"></span> 원</p>
</div>

</div>


<!-- 오버레이 -->
<div id="overlay" class="overlay" onclick="closeMyPage()"></div>

<!-- 오른쪽 슬라이딩 패널 -->
<div id="myPagePanel" class="slide-panel">
    <div class="slide-panel-content">
        <span class="close-btn" onclick="closeMyPage()">×</span>
        <h2>👤 내 정보</h2>
        <ul class="panel-menu">
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


<script>
    const accountNumInput = document.getElementById("accountNum");
    const accountNameInput = document.getElementById("accountName");
    const accountCashInput = document.getElementById("accountCash");

    const previewAccountNum = document.getElementById("previewAccountNum");
    const previewAccountName = document.getElementById("previewAccountName");
    const previewAccountCash = document.getElementById("previewAccountCash");

    function updatePreview() {
        previewAccountNum.textContent = accountNumInput.value;
        previewAccountName.textContent = accountNameInput.value;
        previewAccountCash.textContent = accountCashInput.value.toLocaleString(); // 콤마 포함
    }

    // 입력 이벤트에 리스너 연결
    accountNumInput.addEventListener("input", updatePreview);
    accountNameInput.addEventListener("input", updatePreview);
    accountCashInput.addEventListener("input", updatePreview);

    // 초기 렌더링 (서버 값으로 채워져 있으면 바로 반영)
    updatePreview();
</script>

</body>
</html>