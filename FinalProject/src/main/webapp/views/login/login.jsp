<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
        	width: 800px;     /* 입력창 너비 */
        	height: 30px;     /* 입력창 높이 */
            padding: 5px;
            font-size: 14px;
        }

        .search-box button {
        	width: 100px;     /* 입력창 너비 */
        	height: 40px;     /* 입력창 높이 */
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
    </style>
</head>
<body>
    <div class="header">
        <div class="header-line1">
            <div><a href="/home" class="no-style-link">로고 또는 네비게이션</a></div>
            <div class="auth-buttons">
                <a href="/login">로그인</a> |
                <a href="/member/memberWrite">회원가입</a>
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
        <h1>메인 콘텐츠 영역</h1>
        <p>이 부분은 화면 크기에 따라 자동으로 조절됩니다.</p>
    <form action="/login/loginAction" method="post">
    <table border="1">
        <tr>
            <td colspan="2" align="left">
                자동 로그인 <input type="checkbox" name="autoLogin">
                &nbsp;|&nbsp;
                아이디 저장
                <input type="checkbox" name="idStore"/>
                    <c:if test="${loginCommand.idStore}"></c:if>>
            </td>
        </tr>
        <tr>
            <td >
                <input type="text" name="userId"  placeholder="아이디"><br/>
                <input type="password" name="userPw" placeholder="비밀번호">
            </td>
            <td colspan="2"><input type="submit"  value="로그인"/></td></tr>
        </tr>
        <tr>
            <td colspan="2" align="center">
                <a href="/help/findId">아이디</a> /
                <a href="/help/findPassword">비밀번호 찾기</a> |
                <a href="/member/memberWrite">회원가입</a>
            </td>
        </tr>
    </table>
</form>
    </div>
</body>
</html>
