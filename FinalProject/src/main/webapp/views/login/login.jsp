<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<form action="/login" method="post">
    <table border="1">
        <tr>
            <td colspan="2" align="left">
                자동 로그인 <input type="checkbox" name="autoLogin">
                &nbsp;|&nbsp;
                아이디 저장
                <input type="checkbox" name="idStore"
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
회원관리<br />
<a href="member/memberList">회원목록</a><br />
</body>
</html>