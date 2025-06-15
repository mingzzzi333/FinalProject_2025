<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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

        .search-form button:hover {
          background-color: #3e78c2;
      }

        .search-box input[type="text"] {
           border : 1px;
           border-radius: 20px 0 0 20px;
           margin-top: 16px;
            width: 600px;
            height: 40px;
            padding: 10px;
            font-size: 14px;
        }

        .search-box button {
           border : 1px;
           border-radius: 0 20px 20px 0;
           margin-top: 15px;
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
        
      
    </style>
    
    <!-- 문의등록폼 -->
    <style>
    .inquiry-form-container {
        max-width: 600px;
        margin: 30px auto;
        padding: 25px;
        background-color: #f9f9f9;
        border-radius: 12px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        font-family: Arial, sans-serif;
    }

    .inquiry-form-container h2 {
        margin-bottom: 20px;
        font-size: 22px;
        color: #333;
        text-align: center;
    }

    .form-group {
        margin-bottom: 18px;
    }

    .form-group label {
        display: block;
        font-weight: bold;
        margin-bottom: 6px;
        color: #555;
    }

    .form-group input[type="text"],
    .form-group textarea {
        width: 100%;
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 6px;
        font-size: 14px;
        resize: none;
    }

    .form-group textarea {
        height: 120px;
    }

    .form-submit {
        text-align: center;
    }

    .form-submit button {
        background-color: #4CAF50;
        color: white;
        padding: 10px 25px;
        border: none;
        border-radius: 6px;
        font-size: 14px;
        cursor: pointer;
    }

    .form-submit button:hover {
        background-color: #45a049;
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
<div class="inquiry-form-container">
    <h2>📩 문의하기</h2>
    <form action="/inquiry/add" method="post">
        <div class="form-group">
            <label for="inquiryTitle">제목</label>
            <input type="text" id="inquiryTitle" name="inquiryTitle" required />
        </div>
        <div class="form-group">
            <label for="inquiryContent">내용</label>
            <textarea id="inquiryContent" name="inquiryContent" required></textarea>
        </div>
        <div class="form-submit">
            <button type="submit">등록</button>
        </div>
    </form>
</div>
<div class="main-content">


<hr/>

<!-- 내가 등록한 문의 목록 -->
<h3>📋 나의 문의 목록</h3>
<table border="1" width="100%" cellpadding="4" cellspacing="0" style="border-collapse: collapse; font-size: 13px;">
    <thead style="background-color: #f9f9f9;">
        <tr style="height: 30px;">
            <th style="width: 6%;">No</th>
            <th style="width: 12%;">제목</th>
            <th style="width: 12%;">상태</th>
            <th style="width: 18%;">등록일</th>
            <th style="width: 39%;">문의 내용 및 답변</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="i" items="${inquiries}" varStatus="status">
            <tr style="height: 36px; line-height: 1.2;">
                <td style="text-align: center;">${status.index + 1}</td>
                <td style="padding: 6px;">${i.inquiryTitle}</td>
                <td style="text-align: center;">${i.inquiryStatus}</td>
                <td style="text-align: center;">
                    <fmt:formatDate value="${i.inquiryRegist}" pattern="yyyy-MM-dd HH:mm" />
                </td>
                <td style="padding: 6px;">
                    <div><b>문의 내용:</b> ${i.inquiryContent}</div>
                    <c:if test="${not empty i.answerContent}">
                        <div style="margin-top: 4px; background-color: #f0f8ff; padding: 4px; border-left: 3px solid #2196F3;">
                            <b>문의 답변:</b> ${i.answerContent}
                        </div>
                    </c:if>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>

    
    
    
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
