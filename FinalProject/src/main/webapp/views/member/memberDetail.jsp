<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    finalProject.domain.AuthInfoDTO auth =
        (finalProject.domain.AuthInfoDTO) session.getAttribute("authInfo");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>내 정보</title>
</head>
<body>
    <h1>👤 회원 상세 정보</h1>
    <p><strong>회원번호:</strong> ${member.memberNum}</p>
    <p><strong>아이디:</strong> ${member.memberId}</p>
    <p><strong>이름:</strong> ${member.memberName}</p>
    <p><strong>전화번호:</strong> ${member.memberPhone}</p>
    <p><strong>이메일:</strong> ${member.memberEmail}</p>
    <p><strong>생년월일:</strong> ${member.memberBirth}</p>
    <p><strong>성별:</strong> ${member.memberGender}</p>
    <p><strong>우편번호:</strong> ${member.memberPost}</p>
    <p><strong>주소:</strong> ${member.memberAddr}</p>
    <p><strong>상세주소:</strong> ${member.memberDetailAddr}</p>

    <c:if test="${not empty member.memberImg}">
        <p><strong>프로필 이미지:</strong><br/>
           <img src="/upload/${member.memberImg}" alt="프로필 이미지" width="150"/>
        </p>
    </c:if>
</body>
</html>

