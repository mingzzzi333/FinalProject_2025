<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>직원등록</title>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="/static/js/daumAddressScript.js"></script>
</head>
<body>
직원등록<br />
<form action="employeeWrite" method="post">
<table border=1 width=600>
    <tr><th>직원번호</th>
        <td><input type="text" name="empNum" value="${employeeNum }" readonly /></td></tr>
    <tr><th>아이디</th>
        <td><input type="text" name="empId"/></td></tr>
    <tr><th>비밀번호</th>
        <td><input type="password" name="empPw"/></td></tr>
    <tr><th>이름</th>
        <td><input type="text" name="empName"/></td></tr>
    <tr><th>연락처</th>
        <td><input type="text" name="empPhone" /></td></tr>
    <tr><th>이메일</th>
        <td><input type="email" name="empEmail" /></td></tr>
    <tr><th>주소</th>
        <td><input type="text" name="empAddr" id="sample4_roadAddress"/>
            <button type="button" onclick="execDaumPostcode();">주소검색</button></td></tr>
    <tr><th>우편번호</th>
        <td><input type="text" name="empPost" id="sample4_postcode"/></td></tr>
    <tr><th>입사일</th>
        <td><input type="date" name="empHireDate"/></td></tr>
    <tr><th>프로필 이미지</th>
        <td><input type="file" name="empImg" /></td></tr>
    <tr><th colspan="2"><input type="submit" value="등록">
            <input type="button" value="목록으로" 
                   onclick="javascript:location.href='employeeList'" />
        </th></tr>
</table>
</form>
</body>
</html>
