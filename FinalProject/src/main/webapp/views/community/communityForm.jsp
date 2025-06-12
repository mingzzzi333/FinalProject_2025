<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>토론장</title>
    <style>
        html, body {
            margin: 0;
            padding: 0;
            height: 100%;
            width: 100%;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
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
        
    </style>
</head>
<body>
    <div class="header">
        <div class="header-line1">
            <div>로고 또는 네비게이션</div>
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
                        <button type="submit">검색</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <div class="main-content">
        <h1>게시글 작성</h1>
        <form action="communityInsert" method="post" enctype="multipart/form-data">
			<table border=1 width=600>
				<tr><th>회원번호</th>
					<td><input type="text" name="memNum" value="${memberNum }"/></td></tr>
				<tr><th>작성자</th>
					<td><input type="text" name="memNum" value="${memberName }"/></td></tr>
				<tr><th>제목</th>
					<td><input type="text" name="commuSubject"/></td></tr>
				<tr><th>내용</th>
					<td><textarea name="commuContents" style="width: 500px; height: 200px;"></textarea></td></tr>
			    <tr><th>파일</th>
					<td><input type="file" name="commuFile" multiple="multiple"/></td></tr>
				<tr><th>이미지파일</th>
					<td><input type="file" name="commuImageFile" multiple="multiple"/></td></tr>		
				<tr><th colspan="2"><input type="submit" value="등록">
					<!-- <input type="button" value="목록으로" onclick="javascript:location.href='memberList'" /> -->
				</th></tr>
			</table>
			</form>
    </div>
</body>
</html>
