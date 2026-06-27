<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>👤 회원 정보 수정</title>
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

    /* 회원정보 수정 페이지 전용 스타일 */
    .container {
        max-width: 700px;
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

    .form-row {
        margin-bottom: 25px;
    }

    .form-row label {
        display: block;
        margin-bottom: 8px;
        font-weight: 600;
        color: #333;
        font-size: 14px;
    }

    .form-row input, 
    .form-row select {
        width: 100%;
        padding: 12px 16px;
        border: 2px solid #e5e5e5;
        border-radius: 8px;
        font-size: 14px;
        transition: border-color 0.3s ease;
        box-sizing: border-box;
    }

    .form-row input:focus,
    .form-row select:focus {
        outline: none;
        border-color: #FF6B6B;
        box-shadow: 0 0 0 3px rgba(255, 107, 107, 0.1);
    }

    .form-row input[readonly] {
        background-color: #f8f9fa;
        color: #666;
    }

    /* 성별 라디오버튼 스타일 */
    .gender-row {
        display: flex;
        align-items: center;
        gap: 20px;
    }

    .gender-row > label {
        margin-bottom: 0;
        min-width: 60px;
    }

    .gender-options {
        display: flex;
        gap: 30px;
    }

    .gender-options label {
        display: flex;
        align-items: center;
        gap: 8px;
        font-weight: 400;
        cursor: pointer;
    }

    .gender-options input[type="radio"] {
        width: auto;
        margin: 0;
    }

    /* 비밀번호 변경 영역 */
    .password-toggle-row {
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 15px;
        background: #fef9f9;
        border-radius: 8px;
        border-left: 4px solid #FF6B6B;
        margin-bottom: 25px;
    }

    .password-toggle-row span {
        font-weight: 600;
        color: #333;
    }

    .toggle-pw-btn {
        background-color: #FF6B6B;
        color: white;
        border: none;
        border-radius: 20px;
        padding: 8px 16px;
        font-size: 14px;
        cursor: pointer;
        transition: background-color 0.3s;
    }

    .toggle-pw-btn:hover {
        background-color: #e85757;
    }

    #pwArea {
        background: #fff8f8;
        padding: 20px;
        border-radius: 8px;
        border: 1px solid #ffe5e5;
        margin-bottom: 25px;
    }

    #pwMsg {
        color: #e74c3c;
        font-size: 13px;
        margin: 8px 0 0 0;
        font-weight: 500;
    }

    /* 프로필 이미지 영역 */
    .image-preview {
        margin-top: 15px;
        text-align: center;
    }

    .image-preview img {
        width: 120px;
        height: 120px;
        border-radius: 50%;
        object-fit: cover;
        border: 3px solid #FF6B6B;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    }

    .image-preview p {
        margin-top: 10px;
        font-size: 14px;
        color: #666;
    }

    /* 버튼 스타일 */
    .form-actions {
        text-align: center;
        margin-top: 40px;
        display: flex;
        gap: 15px;
        justify-content: center;
    }

    .submit-btn {
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

    .submit-btn:hover {
        background-color: #e85757;
        transform: translateY(-2px);
        box-shadow: 0 6px 16px rgba(255, 107, 107, 0.4);
    }

    .cancel-btn {
        background-color: #6c757d;
        color: white;
        border: none;
        border-radius: 25px;
        padding: 12px 30px;
        font-size: 16px;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.3s ease;
        text-decoration: none;
        display: inline-block;
    }

    .cancel-btn:hover {
        background-color: #5a6268;
        transform: translateY(-2px);
        color: white;
        text-decoration: none;
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
        <h1>👤 회원 정보 수정</h1>
        <form action="/member/memberUpdate" method="post" onsubmit="return validateForm();" enctype="multipart/form-data">
            <!-- 아이디 (수정 불가능) -->
            <div class="form-row">
                <label>아이디</label>
                <input type="text" name="memberId" value="${memberInfo.memberId}" readonly />
            </div>

            <!-- 비밀번호 변경 버튼 -->
            <div class="password-toggle-row">
                <span>비밀번호:</span>
                <button type="button" class="toggle-pw-btn" onclick="togglePwArea()">비밀번호 변경</button>
            </div>

            <!-- 비밀번호 입력 영역 (초기에는 숨김) -->
            <div id="pwArea" style="display:none;">
                <div class="form-row">
                    <label>새 비밀번호</label>
                    <input type="password" id="pw" name="memberPw" placeholder="새 비밀번호를 입력하세요" />
                </div>
                <div class="form-row">
                    <label>비밀번호 확인</label>
                    <input type="password" id="pwCheck" placeholder="비밀번호를 다시 입력하세요" />
                    <p id="pwMsg"></p>
                </div>
            </div>

            <!-- 이름 -->
            <div class="form-row">
                <label>이름</label>
                <input type="text" name="memberName" value="${memberInfo.memberName}" />
            </div>

            <!-- 성별 -->
            <div class="form-row gender-row">
                <label>성별</label>
                <div class="gender-options">
                    <label><input type="radio" name="memberGender" value="남자" <c:if test="${memberInfo.memberGender == '남자'}">checked</c:if>> 남자</label>
                    <label><input type="radio" name="memberGender" value="여자" <c:if test="${memberInfo.memberGender == '여자'}">checked</c:if>> 여자</label>
                </div>
            </div>

            <!-- 이메일 -->
            <div class="form-row">
                <label>이메일</label>
                <input type="email" name="memberEmail" value="${memberInfo.memberEmail}" />
            </div>

            <!-- 전화번호 -->
            <div class="form-row">
                <label>전화번호</label>
                <input type="text" name="memberPhone" value="${memberInfo.memberPhone}" />
            </div>

            <!-- 주소 -->
            <div class="form-row">
                <label>주소</label>
                <input type="text" name="memberAddr" value="${memberInfo.memberAddr}" />
            </div>
            <div class="form-row">
                <label>상세주소</label>
                <input type="text" name="memberDetailAddr" value="${memberInfo.memberDetailAddr}" />
            </div>

            <!-- 우편번호 -->
            <div class="form-row">
                <label>우편번호</label>
                <input type="text" name="memberPost" value="${memberInfo.memberPost}" />
            </div>

            <!-- 생년월일 -->
            <div class="form-row">
                <label>생년월일</label>
                <input type="date" name="memberBirth" value="${fn:substringBefore(memberInfo.memberBirth, ' ')}" />
            </div>

            <!-- 프로필 이미지 -->
            <div class="form-row">
                <label>프로필 이미지 변경</label>
                <input type="file" name="memberImgFile" accept="image/*" />
                <c:if test="${not empty memberInfo.memberImg}">
                    <div class="image-preview">
                        <img src="/upload/${memberInfo.memberImg}" alt="현재 프로필 이미지" />
                        <p>현재 프로필 이미지</p>
                    </div>
                </c:if>
            </div>

            <!-- 제출 버튼 -->
            <div class="form-actions">
                <button type="submit" class="submit-btn">수정 완료</button>
                <a href="/member/myPage" class="cancel-btn">취소</a>
            </div>
        </form>
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

function togglePwArea() {
    const pwArea = document.getElementById("pwArea");
    pwArea.style.display = pwArea.style.display === "none" ? "block" : "none";
}

function validateForm() {
    const pwAreaVisible = document.getElementById("pwArea").style.display !== "none";
    const pw = document.getElementById("pw").value;
    const pwCheck = document.getElementById("pwCheck").value;
    const msg = document.getElementById("pwMsg");

    msg.textContent = "";

    if (pwAreaVisible) {
        if (!pw) {
            msg.textContent = "비밀번호를 입력해주세요.";
            return false;
        }
        if (pw !== pwCheck) {
            msg.textContent = "비밀번호가 일치하지 않습니다.";
            return false;
        }
    }
    return true; // 통과 시 제출 허용
}
</script>

</body>
</html>