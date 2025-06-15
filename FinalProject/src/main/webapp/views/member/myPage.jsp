<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page session="true" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>👤 내 정보</title>
    <style>
        html, body {
            margin: 0;
            padding: 0;
            height: 100%;
            width: 100%;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }

        .no-style-link {
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

        .header-line1 { background-color: #eaeaea; }
        .header-line2 { background-color: #dcdcdc; }

        .auth-buttons a, .nav-links a {
            margin-left: 10px;
            text-decoration: none;
            color: #333;
            font-weight: bold;
        }

        .main-content {
            width: 100%;
            height: calc(100% - 100px);
            background-color: #ffffff;
            overflow: auto;
            padding: 20px;
        }

        .container {
            max-width: 500px;
            margin: auto;
            background: #fff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }

        h1 {
            text-align: center;
            margin-bottom: 30px;
        }

        .info-row {
            margin: 15px 0;
            font-size: 16px;
        }

        .info-row span {
            display: inline-block;
            width: 100px;
            font-weight: bold;
        }

        .slide-panel {
            width: 20%;
            height: 100%;
            background-color: #fff;
            position: fixed;
            top: 0;
            right: -50%;
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
        }

        .overlay {
            display: none;
            position: fixed;
            top: 0; left: 0;
            width: 100%; height: 100%;
            background: rgba(0, 0, 0, 0.4);
            z-index: 998;
        }
    </style>
</head>
<body>

<div class="header">
    <div class="header-line1">
        <div><a href="/home" class="no-style-link">로고 또는 네비게이션</a></div>
        <div class="auth-buttons">
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
        <div class="nav-links">
            <a href="/news">뉴스</a> |
            <a href="/stock">인기주식</a> |
            <a href="/communityMain">토론장</a>
        </div>
    </div>
</div>

<div class="main-content">
    <div class="container">
        <h1>👤 내 정보</h1>

        <div class="info-row">
            <span>아이디:</span> ${memberInfo.memberId}
        </div>
        <div class="info-row">
            <span>회원번호:</span> ${memberInfo.memberNum}
        </div>
        <div class="info-row">
            <span>이름:</span> ${memberInfo.memberName}
        </div>
        <div class="info-row">
            <span>성별:</span> ${memberInfo.memberGender}
        </div>
        <div class="info-row">
            <span>이메일:</span> ${memberInfo.memberEmail}
        </div>
        <div class="info-row">
            <span>전화번호:</span> ${memberInfo.memberPhone}
        </div>
        <div class="info-row">
            <span>주소:</span> ${memberInfo.memberAddr} ${memberInfo.memberDetailAddr}
        </div>
        <div class="info-row">
            <span>우편번호:</span> ${memberInfo.memberPost}
        </div>
        <div class="info-row">
		    <span>생년월일:</span> ${fn:substringBefore(memberInfo.memberBirth, ' ')}
		</div>
        <div class="info-row">
            <span>등급:</span> ${sessionScope.authInfo.grade}
        </div>

        <c:if test="${not empty memberInfo.memberImg}">
            <div class="info-row">
                <span>프로필 이미지:</span><br />
                <img src="/upload/${memberInfo.memberImg}" alt="프로필 이미지" style="width:150px; height:auto;" />
            </div>
        </c:if>
    </div>
    <div style="text-align:center; margin-top: 30px;">
    <form action="/member/memberEdit" method="get">
        <button type="submit" style="padding: 10px 20px;">수정하기</button>
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
        <ul style="list-style-type: disc; padding-left: 20px; line-height: 1.8;">
            <li><a href="/member/myPage">회원정보</a></li>
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
</script>

</body>
</html>
