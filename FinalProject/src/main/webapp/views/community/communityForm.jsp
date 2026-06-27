<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="finalProject.domain.AuthInfoDTO" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>INVEST YATRA - 게시글 작성</title>
<!-- jQuery 및 FontAwesome -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<style>
@import url('https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600;700&display=swap');

* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

body {
  font-family: 'Montserrat', sans-serif;
  background-color: #f9fafb;
  color: #333;
  line-height: 1.6;
}

/* 헤더 스타일 */
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

.header-line1 .auth-links span {
  margin-right: 10px;
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

.nav-links a:not(:last-child)::after {
  content: "|";
  margin-left: 10px;
  color: #aaa;
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
  background: #FFF2EB;
  min-height: calc(100vh - 150px);
  padding: 40px;
}

/* 게시글 작성 폼 스타일 */
.write-container {
  max-width: 800px;
  margin: 0 auto;
  background: white;
  border-radius: 15px;
  box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
  overflow: hidden;
}

.write-header {
  background: linear-gradient(135deg, #FF6B6B, #FF8E8E);
  color: white;
  padding: 30px;
  text-align: center;
}

.write-header h1 {
  font-size: 28px;
  font-weight: 700;
  margin: 0;
}

.write-form {
  padding: 40px;
}

.form-group {
  margin-bottom: 25px;
}

.form-group label {
  display: block;
  font-weight: 600;
  color: #333;
  margin-bottom: 8px;
  font-size: 15px;
}

.form-group input[type="text"],
.form-group input[type="file"],
.form-group textarea {
  width: 100%;
  padding: 12px 16px;
  border: 2px solid #e0e6ed;
  border-radius: 10px;
  font-size: 14px;
  font-family: 'Montserrat', sans-serif;
  transition: border-color 0.3s, box-shadow 0.3s;
}

.form-group input[type="text"]:focus,
.form-group textarea:focus {
  outline: none;
  border-color: #FF6B6B;
  box-shadow: 0 0 0 3px rgba(255, 107, 107, 0.1);
}

.form-group input[readonly] {
  background-color: #f8f9fa;
  color: #6c757d;
}

.form-group textarea {
  resize: vertical;
  min-height: 200px;
}

.file-input-group {
  display: flex;
  gap: 20px;
}

.file-input-group .form-group {
  flex: 1;
  margin-bottom: 0;
}

.submit-container {
  text-align: center;
  padding-top: 20px;
  border-top: 2px solid #f1f3f4;
  margin-top: 30px;
}

.submit-btn {
  background: linear-gradient(135deg, #FF6B6B, #FF8E8E);
  color: white;
  border: none;
  padding: 15px 40px;
  font-size: 16px;
  font-weight: 600;
  border-radius: 25px;
  cursor: pointer;
  transition: all 0.3s;
  box-shadow: 0 4px 15px rgba(255, 107, 107, 0.3);
}

.submit-btn:hover {
  transform: translateY(-2px);
  box-shadow: 0 6px 20px rgba(255, 107, 107, 0.4);
}

.cancel-btn {
  background: #6c757d;
  color: white;
  border: none;
  padding: 15px 40px;
  font-size: 16px;
  font-weight: 600;
  border-radius: 25px;
  cursor: pointer;
  transition: all 0.3s;
  margin-right: 15px;
  text-decoration: none;
  display: inline-block;
}

.cancel-btn:hover {
  background: #5a6268;
  transform: translateY(-2px);
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
  background-color: #ffe5e5;
  color: #FF6B6B;
}

.top-link {
  display: inline-block;
  margin-bottom: 20px;
  color: #FF6B6B;
  text-decoration: none;
  font-weight: 600;
}

.top-link:hover {
  text-decoration: underline;
}
</style>
</head>
<body>

<!-- 헤더 -->
<div class="header-line1">
  <div>
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
            <a href="/adminMain">관리하기</a>
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

<div class="header-line2">
  <div class="nav-links">
    <a href="/news">뉴스</a>
    <a href="/stock">인기주식</a>
    <a href="/communityMain">토론장</a>
  </div>
  <div class="search-box">
    <form action="/search" method="get">
      <input type="text" name="query" placeholder="검색어 입력" />
      <button type="submit">🔍</button>
    </form>
  </div>
</div>

<!-- 본문 영역 -->
<div class="main-content">
  <a href="/stockdata" class="top-link"><i class="fas fa-chart-line"></i> </a>
  
  <div class="write-container">
    <div class="write-header">
      <h1><i class="fas fa-edit"></i> 게시글 작성</h1>
    </div>
    
    <div class="write-form">
      <form action="${pageContext.request.contextPath}/community/write" method="post" enctype="multipart/form-data">
        <!-- 게시판 번호는 숨겨진 필드로 보냅니다 -->
        <input type="hidden" name="boardNum" value="${boardNum}" />
        
        <div class="form-group">
          <label for="memNum"><i class="fas fa-user-tag"></i> 회원번호</label>
          <input type="text" id="memNum" name="memNum" value="${memNum}" readonly />
        </div>
        
        <div class="form-group">
          <label for="memName"><i class="fas fa-user"></i> 작성자</label>
          <input type="text" id="memName" name="memName" value="${memName}" readonly />
        </div>
        
        <div class="form-group">
          <label for="commuSubject"><i class="fas fa-heading"></i> 제목</label>
          <input type="text" id="commuSubject" name="commuSubject" placeholder="제목을 입력해주세요" required />
        </div>
        
        <div class="form-group">
          <label for="commuContents"><i class="fas fa-align-left"></i> 내용</label>
          <textarea id="commuContents" name="commuContents" placeholder="내용을 입력해주세요" required></textarea>
        </div>
        
        <div class="file-input-group">   
          <div class="form-group">
            <label for="commuImageFile"><i class="fas fa-image"></i> 이미지파일</label>
            <input type="file" id="commuImageFile" name="commuImageFile" multiple="multiple" accept="image/*" />
          </div>
        </div>
        
        <div class="submit-container">
          <a href="javascript:history.back()" class="cancel-btn">
            <i class="fas fa-times"></i> 취소
          </a>
          <button type="submit" class="submit-btn">
            <i class="fas fa-check"></i> 등록
          </button>
        </div>
      </form>
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