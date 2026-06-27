<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
    <title>${company.companyName} - 기업 정보</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600&display=swap');

        body {
            font-family: 'Montserrat', sans-serif;
            background-color: #f9fafb;
            margin: 0; padding: 0;
            color: #333;
            line-height: 1.6;
        }

        h3, h4 {
            color: #ff6b6b;
            margin-bottom: 16px;
        }

        a {
            color: #ff6b6b;
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
        }

        table {
          border-collapse: collapse;
          width: auto;
          background: #fff;
          box-shadow: 0 2px 10px rgba(0,0,0,0.05);
          border-radius: 8px;
          overflow: hidden;
          padding: 0 24px;
      }
      
      th, td {
          padding: 14px 16px;
          border-bottom: 1px solid #eee;
          text-align: center;
          white-space: nowrap;
      }
      
      th {
          background-color: #ffe5e5;
          color: #555;
          width: 120px;
      }
      
      td {
          background-color: #fff;
          color: #555;
          width: 340px;
      }

      .description-box {
        white-space: pre-line;
        border: 1px solid #ccc;
        padding: 20px;
        border-radius: 10px;
        background-color: #fff8f8;
        margin-top: 20px;
        padding: 0 24px;
      }

        .header-line1 {
            background: #FF6B6B;
            color: #fff;
            padding: 20px 24px;
            display: flex;
            justify-content: center;
            align-items: center;
            position: relative;
            font-weight: 700;
            font-size: 28px;
            letter-spacing: 1.2px;
        }

      .header-line1 a {
          color: #fff;
          text-decoration: none;
      }
      
      .header-line1 a:hover,
      .header-line1 a:visited,
      .header-line1 a:active {
          color: #fff;
          text-decoration: none;
      }

        .header-line1 .auth-links {
            position: absolute;
            right: 24px;
            top: 50%;
            transform: translateY(-50%);
            font-weight: 500;
            font-size: 14px;
        }
        .header-line1 .auth-links a {
            color: #fff;
            margin-left: 16px;
            text-decoration: none;
            transition: color 0.3s;
        }
        .header-line1 .auth-links a:hover {
            color: #ffc3c3;
            text-decoration: underline;
        }

        .header-line2 {
            background: #ffe5e5;
            padding: 12px 50px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-weight: 600;
            font-size: 15px;
            color: #555;
        }
        .nav-links a {
            margin-right: 20px;
            color: #555;
            text-decoration: none;
            transition: color 0.3s;
        }
        .nav-links a:last-child {
            margin-right: 0;
        }
        .nav-links a:hover {
            color: #ff6b6b;
            text-decoration: underline;
        }

        .search-box form {
            display: flex;
            border-radius: 25px;
            overflow: hidden;
            box-shadow: 0 2px 8px rgb(0 0 0 / 0.1);
            background: #fff;
        }
        .search-box input[type="text"] {
            padding: 10px 18px;
            font-size: 14px;
            border: none;
            width: 280px;
            outline: none;
        }
        .search-box button {
            background-color: #ff6b6b;
            border: none;
            color: white;
            padding: 0 18px;
            font-size: 18px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .search-box button:hover {
            background-color: #e85757;
        }

        .section {
        display: flex;
        gap: 20px;
        margin-bottom: 40px;
        padding: 0 24px;
        }
      
        .section-row {
        flex: 3;
        background: #fff;
        padding: 24px;
        border-radius: 12px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
        }
      
        .section-half {
        flex: 7;
        background: #fff;
        padding: 24px;
        border-radius: 12px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
        }

        .summary-box {
        background: #fff;
        padding: 20px;
        width: 200px;
        text-align: center;
        border-radius: 10px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.05);
        font-size: 16px;
        }
      
        .summary-box h4 {
        color: #ff6b6b;
        margin-bottom: 8px;
        }

        .info-header {
          display: flex;   
           padding-top : 5px;
           padding-left: 20px;
          justify-content: between;
          align-items: center;
          margin-bottom: 30px;
          background: #fff;
        }
      
        .button-box {
        background: #fff;
           padding-left: 40px;
          flex-shrink: 0;
        }
      
        .button-box button {
          background-color: #ff6b6b;
          color: white;
          border: none;
          padding: 10px 20px;
          border-radius: 30px;
          font-size: 14px;
          cursor: pointer;
        }
      
        .button-box button:hover {
          background-color: #e85757;
        }
        
        .container.mt-4{
             display: flex;
           margin-bottom: 40px;
           padding: 0 24px;
        }

        .no-data {
            color: gray;
            font-style: italic;
            margin-top: 10px;
        }
        
        .stock-info-section {
          background: #fff;
          padding: 24px;
          margin: 0 24px 40px;
          border-radius: 12px;
          box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
        }

        .stock-info-section h5 {
          color: #ff6b6b;
          font-size: 20px;
          font-weight: 600;
          margin-top: -8px;
          text-align: center;
        }
      
        .stock-info-section table {
          width: 50%;
          margin: 0 auto;
          border-collapse: collapse;
          margin-top : -8px;
          font-size: 14px;
        }
      
        .stock-info-section th,
        .stock-info-section td {
          padding: 12px 14px;
          border-bottom: 1px solid #eee;
          text-align: center;
          white-space: nowrap;
        }
      
        .stock-info-section thead th {
          background-color: #ffe5e5;
          color: #555;
          font-weight: 600;
        }

        .description-textarea {
           width: 100%;
           height: 150px;
           padding: 16px;
           font-family: 'Montserrat', sans-serif;
           background-color: #fff8f8;
           border: 1px solid #ccc;
           border-radius: 10px;
           resize: vertical;
           line-height: 1.6;
           color: #555;
           font-size: 15px; 
           white-space: pre-line; 
        }

        #chartContainer {
            width: 100%;
            height: 400px;
            margin-top: 40px;
        }

        #myChart {
            width: 100% !important;
            height: 400px !important;
            background-color: white;
        }

        /* 찜 버튼 스타일 개선 */
        .wish-button {
            border: none;
            background: none;
            margin-left: 10px;
            padding: 5px;
            border-radius: 50%;
            transition: background-color 0.3s ease;
            cursor: pointer;
        }

        .wish-button:hover {
            background-color: rgba(255, 107, 107, 0.1);
        }

        .wish-button span {
          font-size: 20px;
          transition: transform 0.2s ease;
      }

      .wish-button:hover span {
          transform: scale(1.1);
      }

        /* 토스트 메시지 스타일 */
        .toast {
            position: fixed;
            top: 20px;
            right: 20px;
            background-color: #333;
            color: white;
            padding: 12px 20px;
            border-radius: 5px;
            z-index: 1000;
            opacity: 0;
            transform: translateX(100%);
            transition: all 0.3s ease;
        }

        .toast.show {
            opacity: 1;
            transform: translateX(0);
        }

        .toast.success {
            background-color: #4CAF50;
        }

        .toast.error {
            background-color: #f44336;
        }

        /* 로딩 스피너 */
        .loading-spinner {
            display: none;
            width: 16px;
            height: 16px;
            border: 2px solid #f3f3f3;
            border-top: 2px solid #ff6b6b;
            border-radius: 50%;
            animation: spin 1s linear infinite;
            margin-left: 5px;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        /* 슬라이딩 패널 및 오버레이 스타일 추가 */
        .overlay {
            display: none;
            position: fixed;
            top: 0; left: 0;
            width: 100%; height: 100%;
            background: rgba(0, 0, 0, 0.4);
            z-index: 998;
        }

        .slide-panel {
            width: 300px;
            height: 100%;
            background-color: #fff;
            position: fixed;
            top: 0;
            right: -300px;
            transition: right 0.3s ease-in-out;
            z-index: 999;
            box-shadow: -2px 0 10px rgba(0,0,0,0.3);
        }

        .slide-panel.open {
            right: 0;
        }

        .slide-panel-content {
            padding: 30px;
            position: relative;
            font-size: 16px;
        }

        .close-btn {
            position: absolute;
            top: 10px;
            right: 20px;
            font-size: 26px;
            cursor: pointer;
            color: #999;
        }

        .close-btn:hover {
            color: #333;
        }

        .slide-panel-content h2 {
            color: #FF6B6B;
            margin-bottom: 20px;
            font-size: 20px;
        }

        .slide-panel-content ul {
            list-style-type: none;
            padding: 0;
        }

        .slide-panel-content li {
            margin-bottom: 10px;
        }

        .slide-panel-content a {
            color: #333;
            text-decoration: none;
            padding: 8px 12px;
            display: block;
            border-radius: 5px;
            transition: background-color 0.2s;
        }

        .slide-panel-content a:hover {
            background-color: #FFDCDC;
            color: #FF6B6B;
        }
        
    </style>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    
</head>
<body>
<div class="header-line1">
    <div><a href="/home" class="no-style-link">INVEST YATRA</a></div>
        
    <div class="auth-links">
        <c:choose>
            <c:when test="${not empty sessionScope.authInfo}">
                <c:choose>
                    <c:when test="${sessionScope.authInfo.grade == 'mem'}">
                        <span>${sessionScope.authInfo.userId}님 (일반회원)</span>
                        <a href="#" onclick="openMyPage()">내 정보</a>
                        <a href="/logout">로그아웃</a>
                    </c:when>
                    <c:when test="${sessionScope.authInfo.grade == 'emp'}">
                        <span>${sessionScope.authInfo.userId}님 (관리자)</span>
                        <a href="/adminMain?empNum=${sessionScope.authInfo.userNum}">관리하기</a>
                        <a href="#" onclick="openMyPage()">내 정보</a>
                        <a href="/logout">로그아웃</a>
                    </c:when>
                </c:choose>
            </c:when>
            <c:otherwise>
                <a href="/login">로그인</a>
                <a href="/member/memberWrite">회원가입</a>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<div class="header-line2">
    <div class="nav-links">
        <a href="/news">뉴스</a>
        <a href="/stock">인기주식</a>
        <a href="/communityMain">토론장</a>
    </div>
    <div class="search-box">
        <form action="/search" method="get" style="display:flex;">
            <input type="text" name="query" placeholder="검색어 입력" />
            <button type="submit">🔍</button>
        </form>
    </div>
</div>

<div class="info-header">
  <h3>
    📋 <a href="/company/list?keyword=${company.companyName}">${company.companyName}</a> 기업 정보
  </h3>

  <div class="button-box">
    <a href="/community/list?companyNum=${company.companyNum}">
        <button type="button">기업 주식 게시판</button>
    </a>
    
    <!-- 개선된 찜 버튼 -->
    <button type="button" 
            id="wishButton" 
            class="wish-button"
            onclick="toggleWishlist('${company.companyNum}', this)"
            data-company-num="${company.companyNum}"
            data-wished="${company.wished}">
        <span id="wishIcon" style="font-size: 20px;">
          <c:choose>
              <c:when test="${company.wished}">
                  ❤️
              </c:when>
              <c:otherwise>
                  🤍
              </c:otherwise>
          </c:choose>
      </span>
      <span class="loading-spinner" id="loadingSpinner"></span>
    </button>
</div>
</div>

<div class="section">
  <!-- 왼쪽: 기본정보 + 설명 -->
  <div class="section-row">
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

    <h4>회사 설명</h4>
      <textarea class="description-textarea" readonly>
         삼성전자는 한국을 대표하는 종합 전자기업입니다.
         반도체, 디스플레이, 휴대폰, 가전 등 다양한 분야에서 사업을 영위하고 있습니다.
         지속적인 혁신을 통해 인류 사회에 기여하는 것을 목표로 합니다.
      </textarea>

  </div>

  <!-- 오른쪽: 실시간 차트 -->
  <div class="section-half">
    <h4>📈 실시간 주가 차트</h4>
    <div id="chartContainer">
      <canvas id="myChart"></canvas>
    </div>
  </div>
</div>

<div class="stock-info-section">
    <h5>📈 실시간 주식 정보</h5>
    <table>
        <thead>
            <tr>
                <th>거래일</th>
                <th>종가</th>
                <th>최고가</th>
                <th>최저가</th>
            </tr>
        </thead>
        <tbody>
            <tr id="stock"></tr>
            <c:forEach items="${list}" var="data">
                <tr>
                    <td>${data.tradingDate}</td>
                    <td>${data.price}</td>
                    <td>${data.highPrice}</td>
                    <td>${data.lowPrice}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

<!-- 재무정보 -->
<div class="stock-site">
    <h4>📊 재무정보 </h4>
    <a href="https://comp.fnguide.com/SVO2/ASP/SVD_Finance.asp">여기를 누르면 이동</a>
</div>

<!-- 오버레이 -->
<div id="overlay" class="overlay" onclick="closeMyPage()"></div>

<!-- 오른쪽 슬라이딩 패널 -->
<div id="myPagePanel" class="slide-panel">
    <div class="slide-panel-content">
        <span class="close-btn" onclick="closeMyPage()">×</span>
        <h2>👤 내 정보</h2>
        <ul>
            <li><a href="/member/myPage">회원정보</a></li>
            <li><a href="/member/myAsset">내 자산</a></li>
            <li><a href="/myStoke">보유종목</a></li>
            <li><a href="/wish/wishList">관심종목</a></li>
            <li><a href="/inquiry">문의하기</a></li>
        </ul>
    </div>
</div>

<!-- 토스트 메시지 컨테이너 -->
<div id="toastContainer"></div>

<script>
// 내 정보 패널 관련 함수 추가
function openMyPage() {
    document.getElementById("myPagePanel").classList.add("open");
    document.getElementById("overlay").style.display = "block";
}

function closeMyPage() {
    document.getElementById("myPagePanel").classList.remove("open");
    document.getElementById("overlay").style.display = "none";
}

// 차트 관련 코드
let chart;
const ctx = document.getElementById('myChart').getContext('2d');

chart = new Chart(ctx, {
    type: 'line',
    data: {
        labels: [],
        datasets: [
            {
                label: 'Price',
                data: [],
                borderColor: 'rgba(255, 99, 132, 1)',
                borderWidth: 1,
                pointRadius: 0,
                fill: false,
                tension: 0.1
            },
            {
                label: 'High vs Low Avg',
                data: [],
                borderColor: 'rgba(54, 162, 235, 1)',
                borderWidth: 1,
                pointRadius: 0,
                fill: false,
                tension: 0.1
            }
        ]
    },
    options: {
        responsive: true,
        maintainAspectRatio: false,
        animation: {
            duration: 0
        },
        scales: {
            x: {
                display: true,
                title: {
                    display: true,
                    text: '날짜'
                },
                ticks: {
                    maxRotation: 45,
                    minRotation: 45,
                    maxTicksLimit: 10,
                    callback: function(value, index, ticks) {
                        return index % 5 === 0 ? this.getLabelForValue(value) : '';
                    }
                }
            },
            y: {
                display: true,
                title: {
                    display: true,
                    text: '가격'
                },
                ticks: {
                    maxTicksLimit: 8,
                }
            }
        },
        plugins: {
            legend: {
                display: true
            },
            tooltip: {
                enabled: true,
                callbacks: {
                    label: function(context) {
                        return `가격: ${context.formattedValue}`;
                    }
                }
            }
        }
    }
});

// 웹소켓 연결
function connectWebSocket() {
    const ws = new WebSocket("ws://localhost:1234");

    ws.onopen = () => {
        console.log("웹소켓 연결됨");
    };

    ws.onmessage = evt => {
        const data = JSON.parse(evt.data);
        const now = new Date();
        const dateStr = now.getFullYear() + "-" +
                        String(now.getMonth() + 1).padStart(2, '0') + "-" +
                        String(now.getDate()).padStart(2, '0') + " " +
                        String(now.getHours()).padStart(2, '0') + ":" +
                        String(now.getMinutes()).padStart(2, '0');

        const newRow =
            "<td>" + dateStr + "</td>" +
            "<td>" + data.price + "</td>" +
            "<td>" + data.highPrice + "</td>" +
            "<td>" + data.lowPrice + "</td>";
        $("#stock").html(newRow);

        // 차트 데이터 추가
        chart.data.labels.push(dateStr);
        chart.data.datasets[0].data.push(data.price);
        const avgHighLow = (data.highPrice + data.lowPrice) / 2;
        chart.data.datasets[1].data.push(avgHighLow);

        // Y축 업데이트
        chart.options.scales.y.max = data.highPrice + 1000;
        chart.options.scales.y.min = data.lowPrice - 1000;
        chart.options.scales.y.ticks.stepSize = 10;
        
        // 데이터 제한
        if (chart.data.labels.length > 1000) {
            chart.data.labels.shift();
            chart.data.datasets[0].data.shift();
            chart.data.datasets[1].data.shift();
        }

        chart.update();
    };

    ws.onclose = () => {
        console.log("웹소켓 연결 종료");
    };
}

// 토스트 메시지 표시 함수
function showToast(message, type = 'success') {
    const toast = document.createElement('div');
    toast.className = `toast ${type}`;
    toast.textContent = message;
    
    document.getElementById('toastContainer').appendChild(toast);
    
    // 토스트 표시
    setTimeout(() => {
        toast.classList.add('show');
    }, 100);
    
    // 3초 후 토스트 제거
    setTimeout(() => {
        toast.classList.remove('show');
        setTimeout(() => {
            if (toast.parentNode) {
                toast.parentNode.removeChild(toast);
            }
        }, 300);
    }, 3000);
}

// 개선된 찜 토글 함수
function toggleWishlist(companyNum, button) {
    // 로그인 체크
    <c:choose>
        <c:when test="${empty sessionScope.authInfo}">
            showToast('로그인이 필요한 서비스입니다.', 'error');
            setTimeout(() => {
                location.href = '/login';
            }, 1500);
            return;
        </c:when>
        <c:otherwise>
            // 중복 클릭 방지
            if (button.disabled) {
                return;
            }
            
            // 버튼 비활성화 및 로딩 표시
            button.disabled = true;
            const loadingSpinner = document.getElementById('loadingSpinner');
            const wishIcon = document.getElementById('wishIcon');
            
            loadingSpinner.style.display = 'inline-block';
            wishIcon.style.opacity = '0.5';
            
            // AJAX 요청
            $.ajax({
                url: '/wish/toggle',
                type: 'POST',
                data: {
                    companyNum: companyNum
                },
                success: function(response) {
                    if (response.success) {
                        // 아이콘 변경
                                   if (response.isWished) {
                              wishIcon.textContent = '❤️';
                            showToast('찜 목록에 추가되었습니다! ❤️', 'success');
                           } else {
                            wishIcon.textContent = '🤍';
                            showToast('찜 목록에서 제거되었습니다.', 'success');
                  }
                        
                        // 버튼 data 속성 업데이트
                        button.setAttribute('data-wished', response.isWished);
                        
                    } else {
                        showToast('오류가 발생했습니다: ' + (response.message || '알 수 없는 오류'), 'error');
                    }
                },
                error: function(xhr, status, error) {
                    console.error('AJAX Error:', {
                        status: xhr.status,
                        statusText: xhr.statusText,
                        responseText: xhr.responseText,
                        error: error
                    });
                    
                    let errorMessage = '서버 오류가 발생했습니다.';
                    if (xhr.status === 401) {
                        errorMessage = '로그인이 필요합니다.';
                    } else if (xhr.status === 403) {
                        errorMessage = '권한이 없습니다.';
                    } else if (xhr.status === 404) {
                        errorMessage = '요청한 리소스를 찾을 수 없습니다.';
                    }
                    
                    showToast(errorMessage, 'error');
                },
                complete: function() {
                    // 로딩 상태 해제
                    button.disabled = false;
                    loadingSpinner.style.display = 'none';
                    wishIcon.style.opacity = '1';
                }
            });
        </c:otherwise>
    </c:choose>
}

// 페이지 로드 시 초기화
$(document).ready(function() {
    connectWebSocket();
    
    // 찜 버튼 초기 상태 확인
    const wishButton = document.getElementById('wishButton');
    const isWished = wishButton.getAttribute('data-wished') === 'true';
    console.log('초기 찜 상태:', isWished);
});

</script>

</body>
</html>