
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Select Year</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        .chart-container {
            width: 80%; /* Đặt chiều rộng của biểu đồ */
            margin: 0 auto; /* Canh giữa */
        }
    </style>
</head>
<body>
    <h2>Select Year</h2>
    <form id="yearForm">
        <label for="year">Select Year:</label>
        <select id="year" name="year">
            <c:forEach var="y" items="${years}">
                <option value="${y}">${y}</option>
            </c:forEach>
        </select>
        <button type="submit">View Chart</button>
    </form>
    
    <div class="chart-container">
        <canvas id="myChart"></canvas>
    </div>

    <script>
        $(document).ready(function() {
            var currentYear = new Date().getFullYear();
            $("#year").val(currentYear); // Đặt năm hiện tại làm mặc định trong select box
            loadChartData(currentYear);

            $("#yearForm").on("submit", function(event) {
                event.preventDefault(); // Ngăn chặn chuyển hướng trang
                var year = $("#year").val();
                loadChartData(year);
            });

            function loadChartData(year) {
                $.ajax({
                    url: "/admin/totalPaymentPerMonth",
                    type: "POST",
                    data: { year: year },
                    success: function(response) {
                        console.log("Received response: ", response); // Kiểm tra dữ liệu trả về

                        var year = response.year;
                        var totalPayments = response.totalPayments;

                        if (!totalPayments || totalPayments.length === 0) {
                            console.error("No data received for the selected year.");
                            return;
                        }

                        var labels = ["Month 1", "Month 2", "Month 3", "Month 4", "Month 5", "Month 6", "Month 7", "Month 8", "Month 9", "Month 10", "Month 11", "Month 12"];
                        var ctx = document.getElementById('myChart').getContext('2d');

                        if (window.myChart instanceof Chart) {
                            window.myChart.destroy();
                        }

                        window.myChart = new Chart(ctx, {
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
                    },
                    error: function(xhr, status, error) {
                        console.error("Error: " + error);
                    }
                });
            }
        });
    </script>
</body>
</html>
