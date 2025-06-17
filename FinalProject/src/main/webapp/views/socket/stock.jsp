<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>실시간 주가 차트</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

  <style>
    body {
      font-family: 'Montserrat', sans-serif;
      background-color: #f9fafb;
      margin: 0;
      padding: 0;
    }

    .header-line1 {
      background: #FF6B6B;
      color: #fff;
      padding: 20px 24px;
      display: flex;
      justify-content: center;
      align-items: center;
      font-weight: 700;
      font-size: 28px;
    }

    .header-line1 a {
      color: #fff;
      text-decoration: none;
    }

    #chartContainer {
      width: 100%;
      height: 400px;
      margin: 40px auto;
    }

    #myChart {
      width: 100% !important;
      height: 400px !important;
    }
  </style>
</head>

<body>
  <div class="header-line1">
    <a href="/home">INVEST YATRA</a>
  </div>

  <div id="chartContainer">
    <canvas id="myChart"></canvas>
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

  <script>
    let chart;
    const ctx = document.getElementById('myChart').getContext('2d');

    chart = new Chart(ctx, {
      type: 'line',
      data: {
        labels: [],
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
          x: { display: false },
          y: { display: true }
        },
        plugins: {
          legend: { display: true }
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
        const dateStr = now.getFullYear() + "-" + String(now.getMonth() + 1).padStart(2, '0') + "-" + String(now.getDate()).padStart(2, '0');

        const newRow =
          "<td>" + dateStr + "</td>" +
          "<td>" + data.price + "</td>" +
          "<td>" + data.cumulativeVolume + "</td>";
        $("#stock").html(newRow);

        chart.data.labels.push(chart.data.labels.length);
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
</body>
</html>
