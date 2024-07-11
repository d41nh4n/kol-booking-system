<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Total Payment Per Month</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        .chart-container {
            width: 80%; /* Đặt chiều rộng của biểu đồ */
            margin: 0 auto; /* Canh giữa */
        }
    </style>
</head>
<body>
    <div class="chart-container">
        <canvas id="myChart"></canvas>
    </div>

    <!-- Sử dụng JSTL để gán giá trị vào các phần tử HTML -->
    <input type="hidden" id="year" value="${year}">
    <input type="hidden" id="totalPayments" value="${totalPayments}">

    <script>
        var year = document.getElementById('year').value;
        var totalPaymentsString = document.getElementById('totalPayments').value;
        var totalPayments = totalPaymentsString.split(',').map(Number);

        var labels = ["Month 1", "Month 2", "Month 3", "Month 4", "Month 5", "Month 6", "Month 7", "Month 8", "Month 9", "Month 10", "Month 11", "Month 12"];

        var ctx = document.getElementById('myChart').getContext('2d');

        var myChart = new Chart(ctx, {
            type: 'line',
            data: {
                labels: labels,
                datasets: [{
                    label: 'Total Payment Per Month in ' + year,
                    data: totalPayments,
                    backgroundColor: 'rgba(255, 99, 132, 0.2)',
                    borderColor: 'rgba(255, 99, 132, 1)',
                    borderWidth: 1
                }]
            },
            options: {
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });
    </script>
</body>
</html>
