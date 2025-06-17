<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page session="true" %>
<%@ page import="finalProject.domain.AuthInfoDTO" %>
<%
    finalProject.domain.AuthInfoDTO authInfo = (finalProject.domain.AuthInfoDTO) session.getAttribute("authInfo");
    request.setAttribute("authInfo", authInfo);
%>
<html>
<head>
    <title>자유게시판 - 게시글 수정</title>
    <style>
        body {
            font-family: 'Malgun Gothic', sans-serif;
            background-color: #f4f4f4;
            padding: 40px;
        }
        .form-box {
            background: white;
            padding: 30px;
            border: 1px solid #ccc;
            max-width: 700px;
            margin: auto;
        }
        .form-group { margin-bottom: 20px; }
        .form-group label { font-weight: bold; display: block; margin-bottom: 5px; }
        .form-group input[type="text"],
        .form-group textarea {
            width: 100%;
            padding: 10px;
            font-size: 14px;
        }
        .form-group textarea { height: 200px; resize: none; }
        .form-actions { text-align: right; }
        .form-actions button {
            padding: 10px 20px;
            font-size: 16px;
        }
    </style>
</head>
<body>
<div class="form-box">
    <h2>게시글 수정</h2>
    <form action="/community/update" method="post" enctype="multipart/form-data">
        <input type="hidden" name="commuNum" value="${commu.commuNum}" />

        <div class="form-group">
            <label for="commuSubject">제목</label>
            <input type="text" id="commuSubject" name="commuSubject" value="${commu.commuSubject}" required />
        </div>

        <div class="form-group">
            <label for="commuContents">내용</label>
            <textarea id="commuContents" name="commuContents" required>${commu.commuContents}</textarea>
        </div>

        <div class="form-group">
            <label>기존 첨부파일:</label>
            <c:if test="${not empty commu.commuStoreName}">
                <a href="/upload/community/${commu.commuStoreName}" download="${commu.commuOriginalName}">
                    ${commu.commuOriginalName}
                </a>
            </c:if>
        </div>

        <div class="form-group">
            <label for="uploadFile">첨부파일 변경</label>
            <input type="file" name="uploadFile" id="uploadFile" />
        </div>

        <div class="form-group">
            <label>기존 이미지:</label>
            <c:if test="${not empty commu.commuImageStoreName}">
                <img src="/upload/community/${commu.commuImageStoreName}" style="max-width: 300px;" />
            </c:if>
        </div>

        <div class="form-group">
            <label for="uploadImage">이미지 변경</label>
            <input type="file" name="uploadImage" id="uploadImage" />
        </div>

        <div class="form-actions">
            <button type="submit">수정 완료</button>
        </div>
    </form>
</div>
</body>
</html>
