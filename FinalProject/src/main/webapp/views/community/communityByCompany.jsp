<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page session="true" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>기업별 커뮤니티</title>
    <style>
        /* 💡 너가 준 CSS 그대로 재사용 */
        html, body { margin: 0; padding: 0; height: 100%; width: 100%; box-sizing: border-box; font-family: Arial, sans-serif; }
        .main-content { padding: 20px; }
        table { width: 100%; border-collapse: collapse; margin-top: 15px; }
        table, th, td { border: 1px solid #ccc; }
        th, td { text-align: center; padding: 10px; }
    </style>
</head>
<body>

<div class="main-content">
    <h2>🏢 기업 게시판</h2>
    
    <table>
        <thead>
        <tr>
            <th>번호</th>
            <th>제목</th>
            <th>작성자</th>
            <th>작성일</th>
            <th>조회수</th>
            <th>추천</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="post" items="${commuList}">
            <tr>
                <td>${post.commuNum}</td>
                <td><a href="/community/detail/${post.commuNum}">${post.commuSubject}</a></td>
                <td>${post.writerName}</td>
                <td><fmt:formatDate value="${post.commuRegist}" pattern="yyyy-MM-dd" /></td>
                <td>${post.commuViews}</td>
                <td>${post.commuGood}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

</body>
</html>
