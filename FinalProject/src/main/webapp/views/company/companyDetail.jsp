<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
    <title>${company.companyName} - 기업 정보</title>
    <style>
        table {
            border-collapse: collapse;
            width: 100%;
        }
        td, th {
            border: 1px solid #ccc;
            padding: 8px;
        }
        .section {
            margin-bottom: 30px;
        }
        .button-box {
            margin-top: 20px;
        }
    </style>
</head>
<body>

<h3>
    📋 
    <a href="/company/list?keyword=${company.companyName}" style="text-decoration: none;">
        ${company.companyName}
    </a> 
    기업 정보
</h3>

<!-- 기본정보 -->
<div class="section">
    <h4>기본정보</h4>
    <table>
        <tr>
            <th>대표자</th>
            <td>${company.companyCeoName}</td>
        </tr>
        <tr>
            <th>설립일</th>
            <td><fmt:formatDate value="${company.establishDate}" pattern="yyyy-MM-dd" /></td>
        </tr>
        <tr>
            <th>상장일</th>
            <td><fmt:formatDate value="${company.companyListDate}" pattern="yyyy-MM-dd" /></td>
        </tr>
        <tr>
            <th>테마</th>
            <td>${company.companyType}</td>
        </tr>
    </table>
</div>

<!-- 회사 설명 -->
<div class="section">
    <h4>회사 설명</h4>
    <div style="white-space: pre-line; border: 1px solid #ccc; padding: 10px;">
        ${company.companyContent}
    </div>
</div>

<!-- ✅ 재무정보 -->
<div class="section">
    <h4>📊 재무정보 </h4>
    <c:choose>
        <c:when test="${not empty financeList}">
            <table border="1" cellpadding="5" cellspacing="0">
                <thead>
                    <tr>
                        <th>항목</th>
                        <th>금액</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="item" items="${financeList}">
                        <tr>
                            <td>${item.accountName}</td>
                            <td>${item.amount}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:when>
        <c:otherwise>
            <p style="color: gray;">📭 등록된 재무정보가 없습니다.</p>
        </c:otherwise>
    </c:choose>
</div>

<!-- 게시판 이동 버튼 -->
<div class="button-box">
    <a href="/community/list?companyNum=${company.companyNum}">
        <button type="button">기업 주식 게시판</button>
    </a>
</div>



</body>
</html>
