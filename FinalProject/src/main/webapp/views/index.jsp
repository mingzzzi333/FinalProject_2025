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
        
        
        /* 추가한곳 */
        .news-slider-container {
		    display: flex;
		    flex-direction: column;
		    align-items: center;
		    position: relative;
		}
		
		.news-slider-wrapper {
		    display: flex;
		    align-items: center;
		    justify-content: center;
		    width: 100%;
		}
		
		.news-slider {
		    display: flex;
		    overflow: hidden;
		    scroll-behavior: smooth;
		    width: 90%; /* ✅ 기존보다 넓게 */
		    padding: 10px 0;
		    margin: 0 20px;
		}
		
		.news-item {
		    flex: 0 0 auto;
		    width: 200px; /* ✅ 조금 넓게 */
		    margin: 0 10px;
		    cursor: pointer;
		    text-align: center;
		    border-radius: 10px;
		    transition: transform 0.3s ease;
		}
		
		.news-item img {
		    width: 100%;
		    height: 140px;
		    object-fit: cover;
		    border-radius: 10px;
		    transition: transform 0.3s ease;
		}
		
		.news-item img:hover {
		    transform: scale(1.1);
		}
		
		.news-title {
		    margin-top: 5px;
		    font-size: 14px;
		    white-space: nowrap;
		    overflow: hidden;
		    text-overflow: ellipsis;
		}
		
		/* ✅ 세련된 좌우 화살표 버튼 */
		.arrow-button {
		    width: 40px;
		    height: 40px;
		    margin-bottom: 30px; 
		    background-color: white;
		    border: 2px solid #1a73e8;
		    color: #1a73e8;
		    border-radius: 50%;
		    font-size: 20px;
		    font-weight: bold;
		    cursor: pointer;
		    box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
		    transition: all 0.3s ease;
		    display: flex;
		    align-items: center;
		    justify-content: center;
		}
		
		.arrow-button:hover {
		    background-color: #1a73e8;
		    color: white;
		}
		
		/* 더보기 버튼 동일 유지 */
		.more-button {
		    margin-top: 15px;
		    background-color: #1a73e8;
		    color: white;
		    border: none;
		    border-radius: 20px;
		    padding: 8px 20px;
		    font-size: 14px;
		    cursor: pointer;
		    transition: background-color 0.3s ease;
		    box-shadow: 0 2px 5px rgba(0,0,0,0.1);
		}
		
		.more-button:hover {
		    background-color: #155ab6;
		}
		ㄴ
		/*기업 리스트*/
		.company-table {
		    width: 100%;
		    margin-left: 40px; /* ✅ 원하는 만큼 조절 가능 */
		    border-collapse: collapse;
		    border-radius: 12px;
		    overflow: hidden;
		    box-shadow: 0 2px 10px rgba(0,0,0,0.05);
		    font-size: 14px;
		    margin-top: 20px;
		}
		
		.company-table thead {
		    background-color: #f0f5ff; /* 연한 남색 느낌 배경 */
		}
		
		
		.company-table th, .company-table td {
		    padding: 13px 40px;
		    text-align: left;
		    border-bottom: 1px solid #c5d7f0; /* ✅ 희미한 남색 테두리 */
		    max-width: 300px;
		    white-space: nowrap;
		    overflow: hidden;
		    text-overflow: ellipsis;
		}
		
		.company-table th {
		    color: #333;
		    font-weight: 600;
		}
		
		.company-table td {
		
		    color: #555;
		}
		
		.company-table a.company-link {
		
		    color: #1a73e8;
		    text-decoration: none;
		    font-weight: bold;
		}
		
		.company-table a.company-link:hover {
		    text-decoration: underline;
		}
		
		.company-table tr:hover {
		    background-color: #f9f9f9;
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
 <a href="/stockdata">실시간데이터</a>
<div class="main-content">
	<h2>📊 기업 리스트</h2>
<table class="company-table" style="margin-bottom: 30px; margin-left: 80px;" >
    <thead>
        <tr >
        	<th text-align: center;>No.</th>
            <th text-align: center;>기업명</th>
            <th text-align: center;>업종</th>
        </tr>
    </thead>
    <tbody>
        <c:choose>
            <c:when test="${not empty companyList}">
                <c:forEach var="company" items="${companyList}" varStatus="status">
				    <c:if test="${status.index < 5}">
				        <tr>
				 	       <td>${status.index + 1}</td>
				            <td><a href="/company/${company.companyNum}" class="company-link">${company.companyName}</a></td>
				            <td>${company.companyType}</td>
				        </tr>
				    </c:if>
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

	
    <h1>뉴스 콘텐츠 영역</h1>   
    <div class="news-slider-container">
    <div class="news-slider-wrapper">
        <button id="prevBtn" class="arrow-button">&larr;</button>
        <div class="news-slider">
            <c:forEach var="news" items="${newsList}">
                <div class="news-item" onclick="window.open('${news.link}', '_blank')">
                    <img src="${news.imageUrl}" alt="뉴스 이미지" />
                    <p class="news-title" title="${news.title}">
                        <c:choose>
                            <c:when test="${fn:length(news.title) > 15}">
                                ${fn:substring(news.title, 0, 15)}...
                            </c:when>
                            <c:otherwise>
                                ${news.title}
                            </c:otherwise>
                        </c:choose>
                    </p>
                    <p style="font-size: 12px; color: #999; margin: 2px 0 0 0;">작성일: ${news.pubDate}</p>
                </div>
            </c:forEach>
        </div>
        <button id="nextBtn" class="arrow-button">&rarr;</button>
    </div>

    <button id="moreBtn" class="more-button">더보기</button>
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
<script>
const slider = document.querySelector('.news-slider');
const prevBtn = document.getElementById('prevBtn');
const nextBtn = document.getElementById('nextBtn');

const scrollAmount = 190; // news-item width + margin

prevBtn.addEventListener('click', () => {
    slider.scrollBy({ left: -scrollAmount, behavior: 'smooth' });
});

nextBtn.addEventListener('click', () => {
    slider.scrollBy({ left: scrollAmount, behavior: 'smooth' });
});

/* 뉴스 더보기 버튼 */
document.getElementById("moreBtn").addEventListener("click", function() {
    window.location.href = "/news/crawled";
});
</script>
</body>
</html>
