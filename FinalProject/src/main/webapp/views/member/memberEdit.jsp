<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page session="true" %>

<!DOCTYPE html>
<html>
<script>
function togglePwArea() {
    const pwArea = document.getElementById("pwArea");
    pwArea.style.display = pwArea.style.display === "none" ? "block" : "none";
}
function validateForm() {
    const pwAreaVisible = document.getElementById("pwArea").style.display !== "none";
    const pw = document.getElementById("pw").value;
    const pwCheck = document.getElementById("pwCheck").value;
    const msg = document.getElementById("pwMsg");

    msg.textContent = "";

    if (pwAreaVisible) {
        if (!pw) {
            msg.textContent = "비밀번호를 입력해주세요.";
            return false;
        }
        if (pw !== pwCheck) {
            msg.textContent = "비밀번호가 일치하지 않습니다.";
            return false;
        }
    }
    return true; // 통과 시 제출 허용
}
</script>

<head>
    <meta charset="UTF-8">
    <title>회원 정보 수정</title>
    <style>
        body { font-family: Arial, sans-serif; padding: 40px; background: #f8f8f8; }
        .container { max-width: 600px; margin: auto; background: #fff; padding: 30px; border-radius: 10px; box-shadow: 0 0 10px rgba(0,0,0,0.1); }
        h1 { text-align: center; margin-bottom: 30px; }
        .form-row { margin-bottom: 20px; }
        .form-row label { display: block; margin-bottom: 5px; font-weight: bold; }
        .form-row input, .form-row select { width: 100%; padding: 8px; border: 1px solid #ccc; border-radius: 5px; }
        .form-row input[type="radio"] { width: auto; }
        .form-actions { text-align: center; margin-top: 30px; }
        .form-actions button { padding: 10px 20px; }
        /* 성별 라디오버튼 정렬 */
		.gender-row {
		    display: flex;
		    align-items: center;
		    gap: 20px;
		}
		
		.gender-options {
		    display: flex;
		    gap: 20px;
		}
    </style>
</head>
<body>
<div class="container">
    <h1>👤 회원 정보 수정</h1>
    <form action="/member/memberUpdate" method="post" onsubmit="return validateForm();" enctype="multipart/form-data">
        <!-- 아이디 (수정 불가능) -->
        <div class="form-row">
            <label>아이디</label>
            <input type="text" name="memberId" value="${memberInfo.memberId}" readonly />
        </div>
       <!-- 비밀번호 변경 버튼 -->
		<div class="info-row">
		    <span>비밀번호:</span>
		    <button type="button" onclick="togglePwArea()">비밀번호 변경</button>
		</div>
		
		<!-- 비밀번호 입력 영역 (초기에는 숨김) -->
		<div id="pwArea" style="display:none;">
		    <div class="info-row">
		        <span>새 비밀번호:</span>
		        <input type="password" id="pw" name="memberPw" />
		    </div>
		    <div class="info-row">
		        <span>비밀번호 확인:</span>
		        <input type="password" id="pwCheck" />
		        <p id="pwMsg" style="color:red;"></p>
		    </div>
		</div>


        <!-- 이름 -->
        <div class="form-row">
            <label>이름</label>
            <input type="text" name="memberName" value="${memberInfo.memberName}" />
        </div>

        <!-- 성별 -->
        <div class="form-row gender-row">
		    <label>성별</label>
		    <div class="gender-options">
		        <label><input type="radio" name="memberGender" value="남자" <c:if test="${memberInfo.memberGender == '남자'}">checked</c:if>> 남자</label>
		        <label><input type="radio" name="memberGender" value="여자" <c:if test="${memberInfo.memberGender == '여자'}">checked</c:if>> 여자</label>
		    </div>
		</div>

        <!-- 이메일 -->
        <div class="form-row">
            <label>이메일</label>
            <input type="email" name="memberEmail" value="${memberInfo.memberEmail}" />
        </div>

        <!-- 전화번호 -->
        <div class="form-row">
            <label>전화번호</label>
            <input type="text" name="memberPhone" value="${memberInfo.memberPhone}" />
        </div>

        <!-- 주소 -->
        <div class="form-row">
            <label>주소</label>
            <input type="text" name="memberAddr" value="${memberInfo.memberAddr}" />
        </div>
        <div class="form-row">
            <label>상세주소</label>
            <input type="text" name="memberDetailAddr" value="${memberInfo.memberDetailAddr}" />
        </div>

        <!-- 우편번호 -->
        <div class="form-row">
            <label>우편번호</label>
            <input type="text" name="memberPost" value="${memberInfo.memberPost}" />
        </div>

        <!-- 생년월일 -->
        <div class="form-row">
            <label>생년월일</label>
            <input type="date" name="memberBirth" value="${fn:substringBefore(memberInfo.memberBirth, ' ')}" />
        </div>

        <!-- 프로필 이미지 -->
        <div class="form-row">
            <label>프로필 이미지 변경</label>
            <input type="file" name="memberImgFile" />
            <c:if test="${not empty memberInfo.memberImg}">
                <p>현재 이미지: <img src="/upload/${memberInfo.memberImg}" width="100"/></p>
            </c:if>
        </div>

        <!-- 제출 -->
        <div class="form-actions">
            <button type="submit">수정 완료</button>
            <a href="/member/myPage"><button type="button">취소</button></a>
        </div>
    </form>
</div>
</body>
</html>
