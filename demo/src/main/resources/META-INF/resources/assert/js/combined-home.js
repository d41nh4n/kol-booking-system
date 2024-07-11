$(document).ready(function() {
    var currentYear = 2024; // Gán giá trị năm hiện tại từ server-side
    $("#paymentYear").val(currentYear); // Đặt năm hiện tại làm mặc định trong select box
    $("#userYear").val(currentYear); // Đặt năm hiện tại làm mặc định trong select box
    $("#categoryYear").val(currentYear); // Đặt năm hiện tại làm mặc định trong select box
    
    loadPaymentChartData(currentYear);
    loadUserChartData(currentYear);
    loadCategoryChartData(currentYear);

    function loadPaymentChartData(year) {
        $.ajax({
            url: "/admin/home/totalPaymentPerMonth",
            type: "POST",
            data: { year: year },
            success: function(response) {
                console.log("Received payment response: ", response);

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

    function loadUserChartData(year) {
        $.ajax({
            url: "/admin/home/userCountPerMonth",
            type: "POST",
            data: { year: year },
            success: function(response) {
                console.log("Received user count response: ", response);

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

    function loadCategoryChartData(year) {
        $.ajax({
            url: "/admin/home/categoryCount",
            type: "POST",
            data: { year: year },
            success: function(response) {
                console.log("Received category count response: ", response);

                var categoryCounts = response.categoryCounts;

                if (!categoryCounts || categoryCounts.length === 0) {
                    console.error("No category count data received for the selected year.");
                    return;
                }

                var labels = categoryCounts.map(c => c.categoryName);
                var data = categoryCounts.map(c => c.count);
                var backgroundColors = labels.map((_, i) => `hsl(${i * 360 / labels.length}, 70%, 50%)`);

                var ctx = document.getElementById('categoryChart').getContext('2d');

                if (window.categoryChart instanceof Chart) {
                    window.categoryChart.destroy();
                }

                window.categoryChart = new Chart(ctx, {
                    type: 'doughnut',
                    data: {
                        labels: labels,
                        datasets: [{
                            data: data,
                            backgroundColor: backgroundColors
                        }]
                    }
                });
            },
            error: function(xhr, status, error) {
                console.error("Error: " + error);
            }
        });
    }

    $("#paymentYearForm").on("submit", function(event) {
        event.preventDefault(); // Ngăn chặn chuyển hướng trang
        var year = $("#paymentYear").val();
        loadPaymentChartData(year);
    });

    $("#userYearForm").on("submit", function(event) {
        event.preventDefault(); // Ngăn chặn chuyển hướng trang
        var year = $("#userYear").val();
        loadUserChartData(year);
    });

    $("#categoryYearForm").on("submit", function(event) {
        event.preventDefault(); // Ngăn chặn chuyển hướng trang
        var year = $("#categoryYear").val();
        loadCategoryChartData(year);
    });
});