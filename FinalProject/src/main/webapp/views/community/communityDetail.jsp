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
    <title>INVEST YATRA - 게시글 상세보기</title>
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
        
        .no-style-link {
            color: #fff;
            text-decoration: none;
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
        .content-area {
            max-width: 900px;
            margin: 30px auto 60px;
            background: white;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgb(0 0 0 / 0.1);
            padding: 30px 40px;
        }

        /* 게시글 박스 */
        .post-box {
            margin-bottom: 30px;
        }
        .post-title {
            font-size: 28px;
            font-weight: 700;
            color: #222;
            margin-bottom: 10px;
            border-bottom: 2px solid #ff6b6b;
            padding-bottom: 8px;
        }
        .post-meta {
            color: #777;
            font-size: 14px;
            margin-bottom: 20px;
            border-bottom: 1px solid #eee;
            padding-bottom: 10px;
        }
        .post-content {
            font-family: 'Noto Sans KR', sans-serif;
            font-size: 16px;
            white-space: pre-wrap;
            word-break: break-word;
            color: #444;
            line-height: 1.5;
            margin-bottom: 30px;
            padding: 20px 0;
        }
        .post-content img {
            border-radius: 10px;
            margin-top: 10px;
            max-width: 100%;
            height: auto;
            box-shadow: 0 2px 10px rgb(0 0 0 / 0.1);
        }

        /* 좋아요 버튼 영역 (가운데 정렬) */
        .like-section {
            text-align: center;
            margin: 30px 0;
        }

        .like-btn {
            background: none;
            border: 2px solid #ff6b6b;
            padding: 12px 30px;
            border-radius: 30px;
            cursor: pointer;
            font-size: 18px;
            font-weight: 600;
            transition: all 0.3s ease;
            color: #ff6b6b;
        }

        .like-btn:hover {
            background-color: #ff6b6b;
            color: white;
            transform: scale(1.05);
        }

        .like-btn.liked {
            color: white;
            background-color: #ff6b6b;
            border-color: #e85757;
        }

        /* 핑크색 구분선 */
        .divider {
            border-top: 2px solid #ff6b6b;
            margin: 5px 0;
        }

        /* 목록으로 버튼과 수정/삭제 버튼을 같은 줄에 배치 */
        .action-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin: 20px 0;
            padding: 0 10px;
        }

        .back-button {
            margin: 0;
        }
        .back-button .btn {
            background-color: #6c757d;
            border: none;
            color: white;
            font-weight: 600;
            padding: 10px 20px;
            border-radius: 30px;
            cursor: pointer;
            transition: background-color 0.3s;
            font-size: 14px;
            text-decoration: none;
            display: inline-block;
        }
        .back-button .btn:hover {
            background-color: #545b62;
        }

        /* 수정/삭제 버튼 영역 */
        .post-actions {
            margin: 0;
        }
        .post-actions form {
            display: inline-block;
            margin-left: 10px;
        }
        .post-actions button, .post-actions .btn {
            background-color: #ff6b6b;
            border: none;
            color: white;
            font-weight: 600;
            padding: 8px 18px;
            border-radius: 30px;
            cursor: pointer;
            transition: background-color 0.3s;
            font-size: 14px;
            text-decoration: none;
            display: inline-block;
        }
        .post-actions button:hover, .post-actions .btn:hover {
            background-color: #e85757;
        }
        .post-actions .btn-danger {
            background-color: #dc3545;
        }
        .post-actions .btn-danger:hover {
            background-color: #c82333;
        }

        /* 댓글 영역 */
        .comment-section {
            margin-top: 30px;
        }
        .comment-section h4 {
            color: #ff6b6b;
            font-size: 20px;
            font-weight: 700;
            margin-bottom: 20px;
        }

        .comment {
            background: #fff0f0;
            padding: 16px 20px;
            border-radius: 12px;
            margin-bottom: 15px;
            box-shadow: 0 1px 5px rgb(0 0 0 / 0.05);
        }
        .comment strong {
            font-weight: 700;
            color: #c0392b;
            font-size: 14px;
        }
        .comment-date {
            font-size: 12px;
            color: #999;
            margin-left: 12px;
        }
        .comment p {
            margin: 8px 0 0;
            white-space: pre-wrap;
            font-size: 15px;
            color: #444;
        }
    </style>
</head>
<body>

<div class="header-line1">
    <div><a href="/home" class="no-style-link">INVEST YATRA</a></div>
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

<div class="content-area">

    <!-- 1. 게시글 내용 -->
    <div class="post-box">
        <div class="post-title">${commu.commuSubject}</div>
        <div class="post-meta">
            작성자: ${commu.writerName} |
            작성일: <fmt:formatDate value="${commu.commuRegist}" pattern="yyyy-MM-dd HH:mm" /> |
            조회수: ${commu.commuViews} |
            좋아요: <span id="likeCount-${commu.commuNum}">${commu.commuGood}</span>개
        </div>
        <div class="post-content">
            ${commu.commuContents}

            <!-- 이미지 표시 -->
            <c:if test="${not empty commu.commuImageStoreName}">
                <img src="/community/images/${commu.commuImageStoreName}"
                     alt="${commu.commuImageOriginalName}" />
            </c:if>
        </div>
    </div>

    <!-- 2. 좋아요 버튼 (가운데 정렬, 개수 포함) -->
    <div class="like-section">
        <button id="likeBtn-${commu.commuNum}" class="like-btn" onclick="toggleLike(${commu.commuNum})">
            <i class="far fa-heart"></i> 좋아요 (<span id="likeCount-${commu.commuNum}">${commu.commuGood}</span>)
        </button>
    </div>

    <!-- 3. 첫 번째 핑크색 구분선 -->
    <div class="divider"></div>

    <!-- 4. 목록으로 버튼 (왼쪽)과 수정/삭제 버튼 (오른쪽) -->
    <div class="action-row">
        <div class="back-button">
            <a href="/community/list?boardNum=${boardNum}" class="btn">목록으로</a>
        </div>
        
        <c:if test="${sessionScope.authInfo.userNum == commu.memberNum}">
            <div class="post-actions">
                <a href="/community/edit/${commu.commuNum}" class="btn">수정</a>
                <form method="post" action="/community/delete" style="display: inline;">
                    <input type="hidden" name="commuNum" value="${commu.commuNum}"/>
                    <input type="hidden" name="boardNum" value="${boardNum}"/>
                    <button type="submit" class="btn btn-danger" onclick="return confirm('정말 삭제하시겠습니까?')">삭제</button>
                </form>
            </div>
        </c:if>
    </div>

    <!-- 5. 두 번째 핑크색 구분선 -->
    <div class="comment-section">
        <h4>댓글</h4>
        <c:forEach var="comment" items="${commentList}">
            <div class="comment">
                <strong>${comment.memberName}</strong>
                <span class="comment-date">
                    <fmt:formatDate value="${comment.commentDate}" pattern="yyyy-MM-dd HH:mm"/>
                </span>
                <p>${comment.commentContents}</p>
            </div>
        </c:forEach>
    </div>

    <!-- 숨겨진 필드: commuNum -->
    <input type="hidden" id="commuNum" value="${commu.commuNum}"/>

</div>

<!-- JavaScript: 좋아요 토글 및 상태 로드 -->
<script>
    // 좋아요 토글 함수
    function toggleLike(commuNum) {
        $.ajax({
            url: '/community/good/ajax/' + commuNum,
            type: 'POST',
            dataType: 'json',
            success: function(response) {
                if (response.success) {
                    updateLikeButton(commuNum, response.isLiked, response.likeCount);
                } else {
                    alert(response.message || '오류가 발생했습니다.');
                    if (response.message === '로그인이 필요합니다.') {
                        window.location.href = '/login';
                    }
                }
            },
            error: function(xhr, status, error) {
                console.error('좋아요 요청 실패:', error);
                alert('네트워크 오류가 발생했습니다.');
            }
        });
    }

    // 좋아요 버튼과 좋아요 개수 업데이트 함수
    function updateLikeButton(commuNum, isLiked, likeCount) {
        const likeBtn = $('#likeBtn-' + commuNum);

        if (isLiked) {
            likeBtn.addClass('liked');
            likeBtn.html('<i class="fas fa-heart"></i> 좋아요 (' + likeCount + ')');
        } else {
            likeBtn.removeClass('liked');
            likeBtn.html('<i class="far fa-heart"></i> 좋아요 (' + likeCount + ')');
        }
    }

    // 페이지 로드시 현재 좋아요 상태 로드
    function loadLikeStatus(commuNum) {
        $.ajax({
            url: '/community/like/status/' + commuNum,
            type: 'GET',
            dataType: 'json',
            success: function(response) {
                updateLikeButton(commuNum, response.isLiked, response.likeCount);
            },
            error: function(xhr, status, error) {
                console.error('좋아요 상태 로드 실패:', error);
            }
        });
    }

    $(document).ready(function() {
        const commuNum = $('#commuNum').val();
        if (commuNum) {
            loadLikeStatus(commuNum);
        }
    });
</script>

</body>
</html>