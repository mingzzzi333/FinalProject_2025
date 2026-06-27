<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>회원가입</title>
  <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@500;700&display=swap" rel="stylesheet">
  
  <!-- Daum 주소 API -->
  <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  
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

    /* 회원가입 페이지 전용 스타일 */
    .signup-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 30px;
      padding-bottom: 15px;
      border-bottom: 2px solid #FF9898;
    }

    .signup-title {
      font-size: 28px;
      font-weight: 700;
      color: #333;
    }

    .signup-container {
      display: flex;
      justify-content: center;
      align-items: flex-start;
      padding: 20px 0;
    }

    .signup-form {
      background: linear-gradient(135deg, #fff 0%, #f8f9fa 100%);
      padding: 40px;
      border-radius: 15px;
      box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
      max-width: 600px;
      width: 100%;
    }

    .form-table {
      width: 100%;
      border-collapse: collapse;
      margin-bottom: 20px;
    }

    .form-table th {
      background: linear-gradient(135deg, #FF6B6B 0%, #FF8E8E 100%);
      color: white;
      padding: 12px 15px;
      text-align: left;
      font-weight: 600;
      font-size: 14px;
      width: 130px;
      border-radius: 5px 0 0 5px;
    }

    .form-table td {
      padding: 12px 15px;
      background: #fff;
      border-bottom: 1px solid #e9ecef;
    }

    .form-table tr:last-child td {
      border-bottom: none;
    }

    .form-input {
      width: 100%;
      padding: 10px 12px;
      font-size: 14px;
      border: 2px solid #e9ecef;
      border-radius: 6px;
      box-sizing: border-box;
      transition: border-color 0.3s;
    }

    .form-input:focus {
      outline: none;
      border-color: #FF6B6B;
    }

    .form-input[type="file"] {
      padding: 8px;
      background: #f8f9fa;
    }

    .radio-group {
      display: flex;
      gap: 15px;
      align-items: center;
    }

    .radio-group input[type="radio"] {
      margin-right: 5px;
    }

    .radio-group label {
      display: flex;
      align-items: center;
      cursor: pointer;
      font-size: 14px;
    }

    .address-group {
      display: flex;
      gap: 10px;
      align-items: center;
    }

    .address-input {
      flex: 1;
    }

    .address-btn {
      background: linear-gradient(135deg, #FF6B6B 0%, #FF8E8E 100%);
      color: white;
      border: none;
      padding: 10px 15px;
      border-radius: 6px;
      cursor: pointer;
      font-size: 12px;
      font-weight: 500;
      white-space: nowrap;
      transition: transform 0.2s, box-shadow 0.2s;
    }

    .address-btn:hover {
      transform: translateY(-1px);
      box-shadow: 0 3px 10px rgba(255, 107, 107, 0.3);
    }

    .form-buttons {
      display: flex;
      gap: 15px;
      justify-content: center;
      margin-top: 30px;
      padding-top: 20px;
      border-top: 1px solid #e9ecef;
    }

    .btn-primary {
      background: linear-gradient(135deg, #FF6B6B 0%, #FF8E8E 100%);
      color: white;
      border: none;
      padding: 12px 30px;
      border-radius: 8px;
      cursor: pointer;
      font-size: 16px;
      font-weight: 600;
      transition: transform 0.2s, box-shadow 0.2s;
    }

    .btn-primary:hover {
      transform: translateY(-1px);
      box-shadow: 0 5px 15px rgba(255, 107, 107, 0.3);
    }

    .btn-secondary {
      background: #6c757d;
      color: white;
      border: none;
      padding: 12px 30px;
      border-radius: 8px;
      cursor: pointer;
      font-size: 16px;
      font-weight: 600;
      transition: transform 0.2s, box-shadow 0.2s;
    }

    .btn-secondary:hover {
      background: #5a6268;
      transform: translateY(-1px);
      box-shadow: 0 5px 15px rgba(108, 117, 125, 0.3);
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

<!-- 본문 영역 -->
<div class="main-content">
  <div class="signup-header">
    <h1 class="signup-title">👤 회원가입</h1>
  </div>

  <div class="signup-container">
    <div class="signup-form">
      <form action="memberWrite" method="post" enctype="multipart/form-data">
        <table class="form-table">
          <tr>
            <th>회원번호</th>
            <td>
              <input type="text" name="memNum" class="form-input" value="${memberNum}" readonly />
            </td>
          </tr>
          <tr>
            <th>회원아이디 *</th>
            <td>
              <input type="text" name="memId" class="form-input" required />
            </td>
          </tr>
          <tr>
            <th>비밀번호 *</th>
            <td>
              <input type="password" name="memPw" class="form-input" required />
            </td>
          </tr>
          <tr>
            <th>이름 *</th>
            <td>
              <input type="text" name="memName" class="form-input" required />
            </td>
          </tr>
          <tr>
            <th>연락처 *</th>
            <td>
              <input type="text" name="memPhone" class="form-input" placeholder="010-0000-0000" required />
            </td>
          </tr>
          <tr>
            <th>성별</th>
            <td>
              <div class="radio-group">
                <label>
                  <input type="radio" name="memGender" value="남자" checked /> 남자
                </label>
                <label>
                  <input type="radio" name="memGender" value="여자" /> 여자
                </label>
              </div>
            </td>
          </tr>
          <tr>
            <th>이메일 *</th>
            <td>
              <input type="email" name="memEmail" class="form-input" placeholder="example@domain.com" required />
            </td>
          </tr>
          <tr>
            <th>주소</th>
            <td>
              <div class="address-group">
                <input type="text" name="memAddr" id="sample4_roadAddress" class="form-input address-input" placeholder="도로명 주소" />
                <button type="button" class="address-btn" onclick="execDaumPostcode();">주소검색</button>
              </div>
            </td>
          </tr>
          <tr>
            <th>상세주소</th>
            <td>
              <input type="text" name="memDetailAddr" class="form-input" placeholder="상세주소" />
            </td>
          </tr>
          <tr>
            <th>우편번호</th>
            <td>
              <input type="text" name="memPost" id="sample4_postcode" class="form-input" placeholder="우편번호" />
            </td>
          </tr>
          <tr>
            <th>생년월일</th>
            <td>
              <input type="date" name="memBirth" class="form-input" />
            </td>
          </tr>
          <tr>
            <th>프로필 이미지</th>
            <td>
              <input type="file" name="memberImgFile" class="form-input" accept="image/*" />
            </td>
          </tr>
        </table>
        
        <div class="form-buttons">
          <input type="submit" value="회원가입" class="btn-primary" />
          <input type="button" value="목록으로" class="btn-secondary" onclick="location.href='memberList'" />
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
            <li><a href="/myPage">회원정보</a></li>
            <li><a href="/myAsset">내 자산</a></li>
            <li><a href="/myStoke">보유종목</a></li>
            <li><a href="/wish">관심종목</a></li>
            <li><a href="/inquiry">문의하기</a></li>
        </ul>
    </div>
</div>

<script>
// 주소 검색 스크립트
function execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            var roadAddr = data.roadAddress; // 도로명 주소
            var zonecode = data.zonecode; // 우편번호

            // 주소와 우편번호 input에 값 넣기
            document.getElementById("sample4_roadAddress").value = roadAddr;
            document.getElementById("sample4_postcode").value = zonecode;
        }
    }).open();
}

// 슬라이딩 패널 스크립트
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