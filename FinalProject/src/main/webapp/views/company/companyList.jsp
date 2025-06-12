<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <title>기업 목록</title>
</head>
<body>

<h2>📋 등록된 기업 목록</h2>

<form action="/company/list" method="get">
    <input type="text" name="keyword" placeholder="기업명 검색" value="${param.keyword}">
    <input type="submit" value="검색">
</form>

<br>

<table border="1" cellpadding="5" cellspacing="0">
    <thead>
        <tr>
            <th>기업코드</th>
            <th>기업명</th>
            <th>대표자</th>
            <th>업종</th>
            <th>설립일</th>
        </tr>
    </thead>
    <tbody>
        <c:choose>
            <c:when test="${not empty companyList}">
                <c:forEach var="company" items="${companyList}">
                    <tr>
                        <td>${company.companyNum}</td>
                        <td>
                            <a href="/company/${company.companyNum}">
                                ${company.companyName}
                            </a>
                        </td>
                        <td>${company.companyCeoName}</td>
                        <td>${company.companyType}</td>
                        <td><fmt:formatDate value="${company.companyYear}" pattern="yyyy-MM-dd"/></td>
                    </tr>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <tr>
                    <td colspan="5" style="text-align: center;">📭 검색 결과가 없습니다</td>
                </tr>
            </c:otherwise>
        </c:choose>
    </tbody>
</table>

<!-- 페이징 영역 -->
<div style="margin-top: 20px;">
    <c:if test="${totalPages > 1}">
        <c:if test="${hasPrev}">
            <a href="?page=${startPage - 1}&keyword=${param.keyword}">◀ 이전</a>
        </c:if>

        <c:forEach var="i" begin="${startPage}" end="${endPage}">
            <c:choose>
                <c:when test="${i == currentPage}">
                    <strong>[${i}]</strong>
                </c:when>
                <c:otherwise>
                    <a href="?page=${i}&keyword=${param.keyword}">${i}</a>
                </c:otherwise>
            </c:choose>
        </c:forEach>

        <c:if test="${hasNext}">
            <a href="?page=${endPage + 1}&keyword=${param.keyword}">다음 ▶</a>
        </c:if>
    </c:if>
</div>

</body>
</html>
