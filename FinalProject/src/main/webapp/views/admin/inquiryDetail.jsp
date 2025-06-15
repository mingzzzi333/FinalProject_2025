<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    finalProject.domain.AuthInfoDTO auth =
        (finalProject.domain.AuthInfoDTO) session.getAttribute("authInfo");
    if (auth != null) {
        out.println("세션 있음 → 아이디: " + auth.getUserId() + ", 등급: " + auth.getGrade());
    } else {
        out.println("세션 없음");
    }
%>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>관리자 메인 페이지</title>
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

        .no-style-link:hover,
        .no-style-link:visited,
        .no-style-link:active {
            text-decoration: none;
            color: inherit;
        }

        .header {
            width: 100%;
            height: 100px;
            background-color: #444;
            color: #fff;
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
            background-color: #333;
        }

        .header-line2 {
            background-color: #555;
        }

        .auth-buttons a, .nav-links a {
            margin-left: 10px;
            text-decoration: none;
            color: #fff;
            font-weight: bold;
        }

        .auth-buttons a:hover, .nav-links a:hover {
            text-decoration: underline;
        }

        .main-content {
            width: 100%;
            height: calc(100% - 100px);
            background-color: #f8f8f8;
            overflow: auto;
            padding: 30px;
        }

        .admin-menu {
            list-style: none;
            padding: 0;
        }

        .admin-menu li {
            margin: 10px 0;
            font-size: 18px;
        }

        .admin-menu a {
            text-decoration: none;
            color: #333;
            font-weight: bold;
        }

        .admin-menu a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<div class="header">
    <div class="header-line1">
        <div><a href="/home" class="no-style-link">로고 또는 네비게이션</a></div>
        <div class="auth-buttons">
            <a href="/logout">로그아웃</a>
        </div>
    </div>
    <div class="header-line2">
        <div class="nav-links">
            <a href="/admin/stock/form">📈 주식 등록 · 목록</a> |
            <a href="/admin/newsAdmin">📰 뉴스 등록</a> |
            <a href="/admin/company/form">🏢 기업 등록</a> |
         <a href="/admin/communityAdmin?empNum=${sessionScope.authInfo.userNum}">💬 토론장 관리</a> |
            <a href="/admin/inquiry/list">❓ 문의 답변</a>
        </div>
    </div>
</div>

<div class="main-content">
    <h2>문의 상세</h2>
<p><strong>문의자:</strong> ${inquiry.memberId}</p>
<p><strong>제목:</strong> ${inquiry.inquiryTitle}</p>
<p><strong>내용:</strong> ${inquiry.inquiryContent}</p>

<c:choose>
    <c:when test="${empty inquiry.answerContent}">
        <form action="/admin/inquiry/answer" method="post">
            <input type="hidden" name="inquiryNum" value="${inquiry.inquiryNum}" />
            <textarea name="answerContent" rows="5" cols="50"></textarea><br/>
            <button type="submit">답변 등록</button>
        </form>
    </c:when>
    <c:otherwise>
        <p><b>답변:</b> ${inquiry.answerContent}</p>
    </c:otherwise>
</c:choose>
</div>
</body>
</html>
