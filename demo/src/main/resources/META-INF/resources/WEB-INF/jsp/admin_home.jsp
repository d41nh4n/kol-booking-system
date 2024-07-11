
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Home</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        .chart-container {
            width: 80%;
            margin: 0 auto;
        }
    </style>
</head>
<body>
    <h2>Admin Dashboard</h2>
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
            var currentYear = ${currentYear}; // Gán giá trị năm hiện tại từ server-side
            $("#year").val(currentYear); // Đặt năm hiện tại làm mặc định trong select box
            loadChartData(currentYear);

            function loadChartData(year) {
                $.ajax({
                    url: "/admin/userCountPerMonth",
                    type: "POST",
                    data: { year: year },
                    success: function(response) {
                        console.log("Received response: ", response);

                        var year = response.year;
                        var userCounts = response.userCounts;

                        if (!userCounts || userCounts.length === 0) {
                            console.error("No data received for the selected year.");
                            return;
                        }

                        var labels = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
                        var ctx = document.getElementById('myChart').getContext('2d');

                        if (window.myChart instanceof Chart) {
                            window.myChart.destroy();
                        }

                        window.myChart = new Chart(ctx, {
                            type: 'bar',
                            data: {
                                labels: labels,
                                datasets: [{
                                    label: 'User Count Per Month in ' + year,
                                    data: userCounts,
                                    backgroundColor: 'rgba(54, 162, 235, 0.2)',
                                    borderColor: 'rgba(54, 162, 235, 1)',
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

            $("#yearForm").on("submit", function(event) {
                event.preventDefault(); // Ngăn chặn chuyển hướng trang
                var year = $("#year").val();
                loadChartData(year);
            });
        });
    </script>
</body>
</html>
