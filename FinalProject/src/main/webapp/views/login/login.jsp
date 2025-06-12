<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    finalProject.domain.AuthInfoDTO auth =
        (finalProject.domain.AuthInfoDTO) session.getAttribute("authInfo");
    if (auth != null) {
        out.println("세션 있음 → 아이디: " + auth.getUserId() + ", 등급: " + auth.getGrade());
    } else {
        out.println("세션 없음");
    }
%>
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
        
        .login-box {
		    width: 400px;
		    margin: 50px auto;
		    padding: 30px;
		    border: 1px solid #ccc;
		    border-radius: 12px;
		    background-color: #f9f9f9;
		    box-shadow: 0 0 10px rgba(0,0,0,0.1);
		}
		
		.login-box table {
		    width: 100%;
		    border-collapse: collapse;
		}
		
		.login-box td {
		    padding: 10px;
		}
		
		.login-box input[type="text"],
		.login-box input[type="password"] {
		    width: 100%;
		    padding: 10px;
		    font-size: 14px;
		    margin-top: 5px;
		    box-sizing: border-box;
		}
		
		.login-box input[type="submit"] {
		    width: 100%;
		    padding: 10px;
		    font-size: 15px;
		    background-color: #5B9BD5;
		    color: white;
		    border: none;
		    border-radius: 6px;
		    cursor: pointer;
		    margin-top: 10px;
		}
		
		
		
		.login-box a {
		    text-decoration: none;
		    color: #333;
		    font-size: 13px;
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
        <h1>메인 콘텐츠 영역</h1>
        <p>이 부분은 화면 크기에 따라 자동으로 조절됩니다.</p>
    <div class="login-box">
    <form action="/login/loginAction" method="post">
        <table>
            <tr>
                <td colspan="2" align="left">
                    <label><input type="checkbox" name="autoLogin"> 자동 로그인</label>
                    &nbsp;|&nbsp;
                    <label><input type="checkbox" name="idStore"> 아이디 저장</label>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <input type="text" name="userId" placeholder="아이디" /><br/>
                    <input type="password" name="userPw" placeholder="비밀번호" />
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <input type="submit" value="로그인" />
                </td>
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

    </div>
</body>
</html>
