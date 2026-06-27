<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="finalProject.domain.AuthInfoDTO" %>

<%
    finalProject.domain.AuthInfoDTO authInfo = (finalProject.domain.AuthInfoDTO) session.getAttribute("authInfo");
    request.setAttribute("authInfo", authInfo);
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <title>INVEST YATRA - 게시글 목록</title>
    <!-- jQuery 및 FontAwesome -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600&display=swap');

        body {
            font-family: 'Montserrat', sans-serif;
            background-color: #f9fafb;
            margin: 0; padding: 0;
            color: #333;
            line-height: 1.6;
        }
        
        /* 헤더 1열 - 기존과 동일 */
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

        /* 헤더 2열 - 기존과 동일 */
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

        /* 메인 컨텐츠 영역 */
        .content-area {
            max-width: 1200px;
            margin: 30px auto 60px;
            background: white;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgb(0 0 0 / 0.1);
            padding: 40px;
        }

        /* 페이지 제목 */
        .page-title {
            text-align: center;
            font-size: 32px;
            font-weight: 700;
            color: #ff6b6b;
            margin-bottom: 30px;
            padding-bottom: 15px;
            border-bottom: 3px solid #ff6b6b;
        }
		/*글쓰기, 목록*/
        .write-section {
		    display: flex;
		    justify-content: space-between; /* 왼쪽-오른쪽 배치 */
		    align-items: center;
		    margin-bottom: 20px;
		}
		
		.list-btn {
		    background: #e0e0e0; /* 회색 */
		    color: #555;
		    padding: 12px 24px;
		    border-radius: 25px;
		    text-decoration: none;
		    font-weight: 600;
		    font-size: 14px;
		    display: inline-flex;
		    align-items: center;
		    gap: 8px;
		    transition: all 0.3s ease;
		    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
		}
		
		.list-btn:hover {
		    background: #d5d5d5;
		    transform: translateY(-1px);
		}
		
		.write-btn {
		    background: linear-gradient(135deg, #ff6b6b, #ff5252);
		    color: white;
		    padding: 12px 24px;
		    border-radius: 25px;
		    text-decoration: none;
		    font-weight: 600;
		    font-size: 14px;
		    display: inline-flex;
		    align-items: center;
		    gap: 8px;
		    transition: all 0.3s ease;
		    box-shadow: 0 4px 15px rgba(255, 107, 107, 0.3);
		}
		
		.write-btn:hover {
		    transform: translateY(-2px);
		    box-shadow: 0 6px 20px rgba(255, 107, 107, 0.4);
		    background: linear-gradient(135deg, #e85757, #f44336);
		}


        /* 게시글 리스트 컨테이너 */
        .post-list-container {
            background: #fff;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        }

        /* 테이블 헤더 */
        .post-list-header {
            background: linear-gradient(135deg, #ff6b6b, #ff8a80);
            color: white;
            padding: 20px 0;
            display: grid;
            grid-template-columns: 80px 1fr 150px 120px 80px 80px;
            gap: 20px;
            align-items: center;
            font-weight: 700;
            font-size: 14px;
            text-align: center;
        }

        /* 게시글 항목 */
        .post-item {
            display: grid;
            grid-template-columns: 80px 1fr 150px 120px 80px 80px;
            gap: 20px;
            align-items: center;
            padding: 20px 0;
            border-bottom: 1px solid #f0f0f0;
            transition: all 0.3s ease;
            text-align: center;
        }
        .post-item:hover {
            background-color: #fafafa;
            transform: translateY(-1px);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
        }
        .post-item:last-child {
            border-bottom: none;
        }

        /* 번호 스타일 */
        .post-number {
            font-weight: 700;
            color: #ff6b6b;
            font-size: 16px;
        }

        /* 제목 스타일 */
        .post-title {
            text-align: left;
            padding: 0 15px;
        }
        .post-title a {
            color: #333;
            text-decoration: none;
            font-weight: 600;
            font-size: 16px;
            line-height: 1.4;
            display: block;
            transition: color 0.3s ease;
        }
        .post-title a:hover {
            color: #ff6b6b;
        }

        /* 작성자 스타일 */
        .post-author {
            color: #666;
            font-weight: 500;
            font-size: 14px;
        }

        /* 날짜 스타일 */
        .post-date {
            color: #888;
            font-size: 13px;
        }

        /* 조회수, 좋아요 스타일 */
        .post-views, .post-likes {
            font-weight: 600;
            font-size: 14px;
        }
        .post-views {
            color: #4CAF50;
        }
        .post-likes {
            color: #ff6b6b;
        }

        /* 빈 상태 메시지 */
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #999;
            font-size: 18px;
        }
        .empty-state i {
            font-size: 48px;
            color: #ddd;
            margin-bottom: 20px;
            display: block;
        }

        /* 반응형 디자인 */
        @media (max-width: 768px) {
            .content-area {
                margin: 20px;
                padding: 20px;
            }
            .post-list-header,
            .post-item {
                grid-template-columns: 60px 1fr 100px 70px 60px;
            }
            .post-author {
                display: none;
            }
            .post-list-header .author-header {
                display: none;
            }
        }
    </style>
</head>
<body>

<!-- 헤더 1열 -->
<div class="header-line1">
    <a href="/home" style="color: inherit; text-decoration: none;">INVEST YATRA</a>
    <div class="auth-links">
        <c:choose>
            <c:when test="${not empty authInfo}">
                <span>${authInfo.userId}님 (${authInfo.grade})</span>
                <a href="/logout">로그아웃</a>
            </c:when>
            <c:otherwise>
                <a href="/login">로그인</a>
                <a href="/member/memberWrite">회원가입</a>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<!-- 헤더 2열 -->
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

<!-- 메인 컨텐츠 영역 -->
<div class="content-area">
    <!-- 페이지 제목 -->
    <div class="page-title">
        ${param.boardTitle} - 게시글 목록
    </div>

    <!-- 글쓰기 버튼 영역 -->
	<div class="write-section">
	    <a href="/community/back" class="list-btn">
	        <i class="fas fa-list"></i>
	        목록
	    </a>
	    <a href="write?boardNum=${boardNum}" class="write-btn">
	        <i class="fas fa-pen"></i>
	        글쓰기
	    </a>
	</div>


    <!-- 게시글 목록 -->
    <div class="post-list-container">
        <!-- 테이블 헤더 -->
        <div class="post-list-header">
            <div>번호</div>
            <div>제목</div>
            <div class="author-header">작성자</div>
            <div>작성일</div>
            <div>조회수</div>
            <div>좋아요</div>
        </div>

        <!-- 게시글 목록 내용 -->
        <c:choose>
            <c:when test="${not empty list}">
                <c:forEach var="item" items="${list}" varStatus="status">
                    <div class="post-item">
                        <!-- 번호 -->
                        <div class="post-number">${status.count}</div>
                        
                        <!-- 제목 -->
                        <div class="post-title">
                            <a href="detail?commuNum=${item.commuNum}&boardNum=${boardNum}">
                         ${item.commuSubject}
                     </a>

                        </div>
                        
                        <!-- 작성자 -->
                        <div class="post-author">
                            ${item.writerName != null ? item.writerName : item.commuWriter}
                        </div>
                        
                        <!-- 작성일 -->
                        <div class="post-date">
                            <fmt:formatDate value="${item.commuRegist}" pattern="yyyy-MM-dd"/>
                        </div>
                        
                        <!-- 조회수 -->
                        <div class="post-views">
                            ${item.commuViews}
                        </div>
                        
                        <!-- 좋아요 -->
                        <div class="post-likes">
                            ${item.commuGood}
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="empty-state">
                    <i class="fas fa-inbox"></i>
                    등록된 게시글이 없습니다.
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

</body>
</html>