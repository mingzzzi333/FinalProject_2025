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
		    width: auto; /* ✅ 고정 비율을 위해 auto */
		    background: #fff;
		    box-shadow: 0 2px 10px rgba(0,0,0,0.05);
		    border-radius: 8px;
		    overflow: hidden;
		    padding: 0 24px;
		}
		
		th, td {
		    padding: 14px 16px;
		    border-bottom: 1px solid #eee;
		    text-align: center;     /* ✅ 가운데 정렬 */
		    white-space: nowrap;    /* ✅ 줄바꿈 방지 */
		}
		
		th {
		    background-color: #ffe5e5;
		    color: #555;
		    width: 120px;           /* ✅ 고정 */
		}
		
		td {
		    background-color: #fff;
		    color: #555;
		    width: 340px;           /* ✅ th의 두 배 */
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
        /* header 내부의 모든 링크에 밑줄 제거 및 흰색 적용 */
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
		  padding: 0 24px; /* 상하 0, 좌우 24px */
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
		
		
        .description-box {
            white-space: pre-line;
            border: 1px solid #ccc;
            padding: 20px;
            border-radius: 10px;
            background-color: #fff8f8;
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
		  
		  .container mt-4{
		  	  display: flex;
			  margin-bottom: 40px;
			  padding: 0 24px; /* 상하 0, 좌우 24px */
		  }

        .no-data {
            color: gray;
            font-style: italic;
            margin-top: 10px;
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
    </style>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    
</head>
<body>
<div class="header-line1">
    <div><a href="/home" class="no-style-link">INVEST YATRA</a></div>
        
    <div class="auth-links">
        <c:choose>
            <c:when test="${not empty authInfo}">
                <span>${authInfo.userId}님 (${authInfo.grade})</span>
                <a href="/logout">로그아웃</a>
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
  </div>
</div>

<div class="section">
  <!-- 왼쪽: 기본정보 + 설명 -->
  <div class="section-row">
    <h4>기본정보</h4>
    <table>
      <tr><th>대표자</th><td>${company.companyCeoName}</td></tr>
      <tr><th>설립일</th><td><fmt:formatDate value="${company.establishDate}" pattern="yyyy-MM-dd" /></td></tr>
      <tr><th>상장일</th><td><fmt:formatDate value="${company.companyListDate}" pattern="yyyy-MM-dd" /></td></tr>
      <tr><th>테마</th><td>${company.companyType}</td></tr>
    </table>

    <h4>회사 설명</h4>
    <div class="description-box">
      ${company.companyDescription}
    </div>
  </div>

  <!-- 오른쪽: 실시간 차트 -->
  <div class="section-half">
    <h4>📈 실시간 주가 차트</h4>
    <div id="chartContainer">
      <canvas id="myChart"></canvas>
    </div>
  </div>
</div>


 <div class="container mt-4">
    <h5 class="mb-3">📈 실시간 주식 정보</h5>
    <table class="table table-bordered table-hover table-sm text-center align-middle">
      <thead class="table-light">
        <tr>
          <th>거래일</th>
          <th>종가</th>
          <th>누적거래량</th>
        </tr>
      </thead>
      <tbody>
        <tr id="stock"></tr>
        <c:forEach items="${list}" var="data">
          <tr>
            <td>${data.tradingDate}</td>
            <td>${data.price}</td>
            <td>${data.cumulativeVolume}</td>
          </tr>
        </c:forEach>
      </tbody>
    </table>
  </div>

<div class="section"> 
    <h4>📊 재무정보</h4>
    <c:choose>
        <c:when test="${not empty financeList}">
            <table>
                <thead><tr><th>항목</th><th>금액</th></tr></thead>
                <tbody>
                <c:forEach var="item" items="${financeList}">
                    <tr><td>${item.accountName}</td><td>${item.amount}</td></tr>
                </c:forEach>
                </tbody>
            </table>
        </c:when>
        <c:otherwise>
            <p class="no-data">📫 등록된 재무정보가 없습니다.</p>
        </c:otherwise>
    </c:choose>
</div>


</body>
<script>
  let chart;
  const ctx = document.getElementById('myChart').getContext('2d');

  chart = new Chart(ctx, {
    type: 'line',
    data: {
      labels: [], // 날짜가 여기에 들어감
      datasets: [{
        label: 'Price',
        data: [],
        borderColor: 'rgba(255, 99, 132, 1)',
        borderWidth: 1,
        pointRadius: 0,
        fill: false,
        tension: 0.1
      }]
    },
    options: {
      responsive: true,
      maintainAspectRatio: false,
      scales: {
        x: {
          display: true,
          title: {
            display: true,
            text: '날짜'
          },
          ticks: {
            maxRotation: 45,
            minRotation: 45
          }
        },
        y: {
          display: true,
          title: {
            display: true,
            text: '가격'
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
        "<td>" + data.cumulativeVolume + "</td>";
      $("#stock").html(newRow);

      chart.data.labels.push(dateStr); // 날짜를 label로 사용
      chart.data.datasets[0].data.push(data.price);

      if (chart.data.labels.length > 1000) {
        chart.data.labels.shift();
        chart.data.datasets[0].data.shift();
      }

      chart.update();
    };

    ws.onclose = () => {
      console.log("웹소켓 연결 종료");
    };
  }

  $(function () {
    connectWebSocket();
  });
</script>

</html>
