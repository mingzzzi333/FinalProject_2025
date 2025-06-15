<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>memberForm</title>
    
    <!-- Daum 주소 API -->
    <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    
    <!-- 주소 검색 스크립트 -->
    <script type="text/javascript">
        function execDaumPostcode() {
            new daum.Postcode({
                oncomplete: function(data) {
                    var roadAddr = data.roadAddress; // 도로명 주소
                    var zonecode = data.zonecode;    // 우편번호

                    // 주소와 우편번호 input에 값 넣기
                    document.getElementById("sample4_roadAddress").value = roadAddr;
                    document.getElementById("sample4_postcode").value = zonecode;
                }
            }).open();
        }
    </script>
</head>
<body>
    회원등록<br />
    <form action="memberWrite" method="post" enctype="multipart/form-data">
        <table border="1" width="600">
            <tr><th>회원번호</th>
                <td><input type="text" name="memNum" value="${memberNum }"/></td></tr>
            <tr><th>회원아이디</th>
                <td><input type="text" name="memId"/></td></tr>
            <tr><th>회원비밀번호</th>
                <td><input type="password" name="memPw"/></td></tr>
            <tr><th>회원이름</th>
                <td><input type="text" name="memName"/></td></tr>
            <tr><th>회원연락처</th>
                <td><input type="text" name="memPhone" /></td></tr>
            <tr><th>성별</th>
                <td>
                    <input type="radio" name="memGender" value="남자" checked /> 남자
                    <input type="radio" name="memGender" value="여자" /> 여자
                </td></tr>
            <tr><th>이메일</th>
                <td><input type="email" name="memEmail" /></td></tr>
            <tr><th>회원주소</th>
                <td>
                    <input type="text" name="memAddr" id="sample4_roadAddress" placeholder="도로명 주소"/>
                    <button type="button" onclick="execDaumPostcode();">주소검색</button>
                </td></tr>
            <tr><th>회원상세주소</th>
                <td><input type="text" name="memDetailAddr" placeholder="상세주소"/></td></tr>
            <tr><th>우편번호</th>
                <td><input type="text" name="memPost" id="sample4_postcode" placeholder="우편번호"/></td></tr>
            <tr><th>생년월일</th>
                <td><input type="date" name="memBirth"/></td></tr>
            <tr><th>프로필 이미지</th>
                <input type="file" name="memberImgFile" />
            <tr>
                <th colspan="2">
                    <input type="submit" value="등록">
                    <input type="button" value="목록으로" onclick="location.href='memberList'" />
                </th>
            </tr>
        </table>
    </form>
</body>
</html>
