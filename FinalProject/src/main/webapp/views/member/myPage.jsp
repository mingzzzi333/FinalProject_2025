<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head><title>내 정보</title></head>
<body>
    <h1>👤 내 정보</h1>
    <p>아이디: ${memberInfo.userId}</p>
    <p>회원번호: ${memberInfo.userNum}</p>
    <p>등급: ${memberInfo.grade}</p>
</body>
</html>