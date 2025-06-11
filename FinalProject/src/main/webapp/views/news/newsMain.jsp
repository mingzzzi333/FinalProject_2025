<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%
    finalProject.domain.AuthInfoDTO auth =
        (finalProject.domain.AuthInfoDTO) session.getAttribute("authInfo");
    if (auth != null) {
        out.println("세션 있음 → 아이디: " + auth.getUserId() + ", 등급: " + auth.getGrade());
    } else {
        out.println("세션 없음");
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>뉴스</title>
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
            text-decoration: none;   /* 밑줄 제거 */
            color: inherit;          /* 부모 요소의 색상 따라감 */
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
            background-color: #eaeaea;
        }

        .header-line2 {
            background-color: #dcdcdc;
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
            background-color: #ffffff;
            overflow: auto;
            padding: 20px;
        }

        .search-box input[type="text"] {
            width: 800px;
            height: 30px;
            padding: 5px;
            font-size: 14px;
        }

        .search-box button {
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
        
        /* 페이지 네비게이션 스타일 */
        .pagination {
            display: flex;
            justify-content: center;
            align-items: center;
            margin-top: 30px;
            gap: 8px;
            flex-wrap: wrap;
        }

        .page-link {
            padding: 6px 12px;
            border-radius: 10px;
            background-color: #f1f1f1;
            color: #333;
            text-decoration: none;
            font-size: 14px;
            font-weight: bold;
            transition: all 0.2s ease;
        }

        .page-link:hover {
            background-color: #800080; /* 보라색 */
            color: #fff;
        }
        
        /* 뉴스 항목 스타일 */
        .news-item {
            display: flex;
            gap: 8px;
            align-items: center;
            border: 1px solid #ccc;
            border-radius: 6px;
            padding: 5px;
            margin-bottom: 8px;
            background-color: #fafafa;
        }
        .news-index {
            width: 24px;
            text-align: center;
            font-weight: bold;
            font-size: 12px;
            color: #666;
        }
        .news-image {
            width: 70px;
            height: 52px;
            object-fit: cover;
            border-radius: 3px;
        }
        .news-content {
            display: flex;
            flex-direction: column;
        }
        .news-title {
            font-size: 14px;
            margin: 0;
        }
        .news-title a {
            color: black;
            text-decoration: none;
        }
        .news-title a:hover {
            text-decoration: underline;
        }
        .news-date {
            font-size: 12px;
            color: #666;
            margin-top: 3px;
        }
    </style>
</head>
<body>
    <div class="header">
        <div class="header-line1">
            <div><a href="/home" class="no-style-link">로고 또는 네비게이션</a></div>
            <div class="auth-buttons">
                <c:choose>
                    <c:when test="${sessionScope.authInfo.grade == 'mem'}">
                        <a href="/member/myPage">내 정보</a> |
                        <a href="/logout">로그아웃</a>
                    </c:when>
                    <c:when test="${sessionScope.authInfo.grade == 'emp'}">
                        <a href="/admin">관리하기</a> |
                        <a href="/logout">로그아웃</a>
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
                    <a href="/community">토론장</a>
                </div>
                <div class="search-box">
                    <form action="/search" method="get">
                        <input type="text" name="query" placeholder="검색어 입력" />
                        <button type="submit">검색</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <div class="main-content">
        <h1>경제 뉴스</h1>
        <div style="margin-bottom: 15px; font-weight: bold; font-size: 16px; color: #555;">
            현재 페이지: ${currentPage} / 전체 페이지: ${totalPages}
        </div>

        <c:choose>
            <c:when test="${not empty newsList}">
                <div style="display: flex; flex-direction: column; gap: 20px;">
                    <c:forEach var="news" items="${newsList}" varStatus="status">
                        <div class="news-item" onclick="window.open('${news.link}', '_blank')" style="cursor: pointer;">
                            <div class="news-index">
                                ${ (currentPage - 1) * pageSize + status.index + 1 }
                            </div>
                            <img class="news-image" src="${news.imageUrl}" alt="뉴스 이미지" />
                            <div class="news-content">
                                <h3 class="news-title" title="${news.title}">
                                    <c:choose>
                                        <c:when test="${fn:length(news.title) > 40}">
                                            ${fn:substring(news.title, 0, 40)}...
                                        </c:when>
                                        <c:otherwise>
                                            ${news.title}
                                        </c:otherwise>
                                    </c:choose>
                                </h3>
                                <div>
                            <p style="font-size: 12px; color: #999;">작성일: ${news.pubDate}</p>
                        </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <p>뉴스 데이터를 불러올 수 없습니다.</p>
            </c:otherwise>
        </c:choose>

        <!-- 페이지 네비게이션 바 -->
        <div class="pagination">
            <c:if test="${currentPage > 1}">
                <a href="/news/crawled?page=${currentPage - 1}" class="page-link">이전</a>
            </c:if>

            <c:forEach begin="1" end="${totalPages}" var="i">
                <a href="/news/crawled?page=${i}" class="page-link"
                   style="${i == currentPage ? 'background-color: #800080; color: white; font-weight: bold;' : ''}">
                   ${i}
                </a>
            </c:forEach>

            <c:if test="${currentPage < totalPages}">
                <a href="/news/crawled?page=${currentPage + 1}" class="page-link">다음</a>
            </c:if>
        </div>

    </div>
</body>
</html>
