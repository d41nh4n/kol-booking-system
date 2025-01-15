<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Home</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            background-color: #f4f4f9;
        }

        h2 {
            text-align: center;
            color: #333;
        }

        .form-container {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
        }

        .form-box {
            background-color: #fff;
            padding: 15px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 48%;
        }

        label {
            display: block;
            margin-bottom: 10px;
            color: #555;
        }

        select, button {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }

        button {
            background-color: #007bff;
            color: #fff;
            border: none;
            cursor: pointer;
        }

        button:hover {
            background-color: #0056b3;
        }

        .chart-container {
            display: flex;
            justify-content: space-between;
        }

        .chart-box {
            background-color: #fff;
            padding: 15px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 48%;
        }

        canvas {
            width: 100% !important;
            height: auto !important;
        }
        .category-chart-container {
            display: flex;
            justify-content: center;
            margin-top: 20px;
        }

        .category-chart-box {
            background-color: #fff;
            padding: 15px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 50%;
        }
    </style>
</head>
<body>
    <h2>Admin Dashboard</h2>

    <div class="form-container">
        <div class="form-box">
            <h3>Select Year for Payments</h3>
            <form id="paymentYearForm">
                <label for="paymentYear">Select Year:</label>
                <select id="paymentYear" name="year">
                    <c:forEach var="y" items="${years}">
                        <option value="${y}">${y}</option>
                    </c:forEach>
                </select>
                <button type="submit">View Payment Chart</button>
            </form>
        </div>
        <div class="form-box">
            <h3>Select Year for User Counts</h3>
            <form id="userYearForm">
                <label for="userYear">Select Year:</label>
                <select id="userYear" name="year">
                    <c:forEach var="y" items="${years}">
                        <option value="${y}">${y}</option>
                    </c:forEach>
                </select>
                <button type="submit">View User Count Chart</button>
            </form>
        </div>
    </div>

    <div class="chart-container">
        <div class="chart-box">
            <canvas id="paymentChart"></canvas>
        </div>
        <div class="chart-box">
            <canvas id="userChart"></canvas>
        </div>
    </div>
    
    <div class="category-chart-container">
        <div class="category-chart-box">
            <canvas id="categoryChart"></canvas>
        </div>
    </div>
    <script>
        $(document).ready(function() {
            var currentYear = /*[[${currentYear}]]*/ 2024; // Gán giá trị năm hiện tại từ server-side
            $("#paymentYear").val(currentYear); // Đặt năm hiện tại làm mặc định trong select box
            $("#userYear").val(currentYear); // Đặt năm hiện tại làm mặc định trong select box
        
            loadPaymentChartData(currentYear);
            loadUserChartData(currentYear);
            loadCategoryChartData();

            function loadPaymentChartData(year) {
                $.ajax({
                    url: "/admin/home/totalPaymentPerMonth",
                    type: "POST",
                    data: { year: year },
                    success: function(response) {
                        var year = response.year;
                        var totalPayments = response.totalPayments;

                        if (!totalPayments || totalPayments.length === 0) {
                            console.error("No payment data received for the selected year.");
                            return;
                        }

                        var labels = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
                        var ctx = document.getElementById('paymentChart').getContext('2d');

                        if (window.paymentChart instanceof Chart) {
                            window.paymentChart.destroy();
                        }

                        window.paymentChart = new Chart(ctx, {
                            type: 'bar',
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

            function loadUserChartData(year) {
                $.ajax({
                    url: "/admin/home/userCountPerMonth",
                    type: "POST",
                    data: { year: year },
                    success: function(response) {
                        var year = response.year;
                        var userCounts = response.userCounts;

                        if (!userCounts || userCounts.length === 0) {
                            console.error("No user count data received for the selected year.");
                            return;
                        }

                        var labels = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
                        var ctx = document.getElementById('userChart').getContext('2d');

                        if (window.userChart instanceof Chart) {
                            window.userChart.destroy();
                        }

                        window.userChart = new Chart(ctx, {
                            type: 'line',
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
                    error: function (xhr, status, error) {
                        console.error("Error: " + error);
                    }
                });
            }

            function loadCategoryChartData() {
    $.ajax({
        url: "/admin/home/categoryCount",
        type: "POST",
        success: function (response) {
            var categoryCounts = response.categoryCounts;

            if (!categoryCounts || categoryCounts.length === 0) {
                console.error("No category count data received.");
                return;
            }

            var labels = categoryCounts.map(c => c.categoryName);
            var data = categoryCounts.map(c => c.count);
            // Use fixed colors for doughnut chart segments
            var backgroundColors = [
                'rgba(255, 99, 132, 0.6)',
                'rgba(54, 162, 235, 0.6)',
                'rgba(255, 206, 86, 0.6)',
                'rgba(75, 192, 192, 0.6)',
                'rgba(153, 102, 255, 0.6)',
                'rgba(255, 159, 64, 0.6)'
                // Add more colors as needed
            ];

            var ctx = document.getElementById('categoryChart').getContext('2d');

            if (window.categoryChart instanceof Chart) {
                window.categoryChart.destroy();
            }

            window.categoryChart = new Chart(ctx, {
                type: 'doughnut',
                data: {
                    labels: labels,
                    datasets: [{
                        label: 'Category Count',
                        data: data,
                        backgroundColor: backgroundColors,
                        hoverOffset: 4
                    }]
                },
                options: {
                    responsive: true,
                    plugins: {
                        legend: {
                            position: 'top'
                        },
                        title: {
                            display: true,
                            text: 'Category Count'
                        }
                    }
                }
            });
        },
        error: function (xhr, status, error) {
            console.error("Error: " + error);
        }
    });
}


            $("#paymentYearForm").on("submit", function (event) {
                event.preventDefault();
                var year = $("#paymentYear").val();
                loadPaymentChartData(year);
            });

            $("#userYearForm").on("submit", function (event) {
                event.preventDefault();
                var year = $("#userYear").val();
                loadUserChartData(year);
            });
        });
    </script>
</body>
</html>