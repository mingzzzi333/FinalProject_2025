<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<!DOCTYPE html>
<html>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<canvas id="stockChart" width="800" height="400"></canvas>
<script>
  const ctx = document.getElementById('stockChart').getContext('2d');
  const stockChart = new Chart(ctx, {
    type: 'line',
    data: {
      labels: ['09:00', '09:30', '10:00', '10:30', '11:00', '11:30'], // 시간
      datasets: [{
        label: '삼성전자 주가',
        data: [72000, 72500, 71000, 73000, 73500, 74000], // 가격 데이터
        fill: false,
        borderColor: 'blue',
        tension: 0.1
      }]
    },
    options: {
      scales: {
        x: {
          title: {
            display: true,
            text: '시간'
          }
        },
        y: {
          title: {
            display: true,
            text: '주가 (원)'
          },
          beginAtZero: false
        }
      }
    }
  });
</script>

<head>
<meta charset="UTF-8">
<title>기업 상세정보</title>
</head>
<body>
기업 정보
</body>
</html>