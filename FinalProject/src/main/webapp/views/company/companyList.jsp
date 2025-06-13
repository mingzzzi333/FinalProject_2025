<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page session="true" %>
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

        .search-box input[type="text"] {
            border: 1px solid #ccc;
            border-radius: 20px 0 0 20px;
            margin-top: 16px;
            width: 600px;
            height: 40px;
            padding: 10px;
            font-size: 14px;
        }

        .search-box button {
            border: 1px solid #ccc;
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
        
        /*기업 검색*/
        .search-form {
		    display: flex;
		    justify-content: center;
		    margin-top: 20px;
		}
		
		.search-input {
		    padding: 10px 15px;
		    font-size: 15px;
		    border: 2px solid #ccc;
		    border-right: none;
		    border-radius: 25px 0 0 25px;
		    outline: none;
		    width: 500px;
		    transition: border-color 0.3s ease;
		}
		
		.search-input:focus {
		    border-color: #1a73e8;
		}
		
		.search-button {
		    padding: 10px 20px;
		    font-size: 15px;
		    background-color: #1a73e8;
		    color: white;
		    border: 2px solid #1a73e8;
		    border-radius: 0 25px 25px 0;
		    cursor: pointer;
		    transition: background-color 0.3s ease;
		}
		
		.search-button:hover {
		    background-color: #155ab6;
		}
		        

        /* 기업 목록 테이블 스타일 */
        .company-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            font-size: 14px;
            text-align: center;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .company-table th {
            background-color: #f2f2f2;
            padding: 12px 10px;
            border-bottom: 2px solid #ccc;
        }

        .company-table td {
            padding: 10px;
            border-bottom: 1px solid #e0e0e0;
        }

        .company-table tr:hover {
            background-color: #f9f9f9;
        }

        .company-link {
            text-decoration: none;
            color: #1a73e8;
            font-weight: bold;
        }

        .company-link:hover {
            text-decoration: underline;
        }
      .pagination {
		    margin-top: 40px;
		    text-align: center;
		}
		
		.page-btn {
		    display: inline-block;
		    margin: 0 3px;
		    padding: 5px 5px;
		    background-color: #fff;
		    color: #000;
		    border: 1px solid #ccc;
		    border-radius: 3px;
		    font-size: 16px;
		    font-weight: 500;
		    text-decoration: none;
		    transition: all 0.3s ease;
		    cursor: pointer;
		    min-width: 15px;
		}
		
		.page-btn:hover {
		    background-color: #f2f2f2;
		    color: #000;
		}
		
		.page-btn.active {
		    background-color: #1a73e8;
		    color: #fff;
		    border: none;
		    pointer-events: none;
		    font-weight: 600;
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

<div class="main-content">
    <h2>    📋 기업 목록</h2>
    
    <form action="/company/list" method="get" class="search-form">
    	<input type="text" name="keyword" placeholder="🔍 기업명 검색" value="${param.keyword}" class="search-input">
    	<button type="submit" class="search-button">검색</button>
	</form>


    <table class="company-table">
        <thead>
            <tr>
                <th>기업코드</th>
                <th>기업명</th>
                <th>대표자</th>
                <th>업종</th>
                <th>설립일</th>
            </tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${not empty companyList}">
                    <c:forEach var="company" items="${companyList}">
                        <tr>
                            <td>${company.companyNum}</td>
                            <td><a href="/company/${company.companyNum}" class="company-link">${company.companyName}</a></td>
                            <td>${company.companyCeoName}</td>
                            <td>${company.companyType}</td>
                            <td><fmt:formatDate value="${company.companyYear}" pattern="yyyy-MM-dd"/></td>
                        </tr>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <tr>
                        <td colspan="5" style="text-align: center;">📭 검색 결과가 없습니다</td>
                    </tr>
                </c:otherwise>
            </c:choose>
        </tbody>
    </table>
	<!-- 페이징 영역 -->
	<div class="pagination">
    <c:if test="${totalPages > 1}">
        <c:if test="${hasPrev}">
            <a href="?page=${startPage - 1}&keyword=${param.keyword}" class="page-btn">◀◀</a>
        </c:if>

        <c:forEach var="i" begin="${startPage}" end="${endPage}">
            <c:choose>
                <c:when test="${i == currentPage}">
                    <span class="page-btn active">${i}</span>
                </c:when>
                <c:otherwise>
                    <a href="?page=${i}&keyword=${param.keyword}" class="page-btn">${i}</a>
                </c:otherwise>
            </c:choose>
        </c:forEach>

        <c:if test="${hasNext}">
            <a href="?page=${endPage + 1}&keyword=${param.keyword}" class="page-btn">▶▶</a>
        </c:if>
    </c:if>
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
            <li><a href="/myPage">회원정보</a></li>
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
