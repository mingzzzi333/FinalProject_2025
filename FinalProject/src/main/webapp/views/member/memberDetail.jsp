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
    <h1>내 정보</h1>
    <p>아이디: ${auth.userId}</p>
    <p>이름: ${auth.userName}</p>
    <p>이메일: ${auth.userEmail}</p>
    <p>등급: ${auth.grade == 'mem' ? '회원' : '직원'}</p>
</body>
</html>