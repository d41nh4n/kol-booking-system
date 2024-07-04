let requestId = null;

function cancelRequest(requestId) {
    if(confirm("Are you sure to cancel !")) {
        console.log(requestId);
        $.ajax({
            url: '/request/cancel-request',
            type: 'POST',
            data: { requestId: requestId },
            success: function(response) {
                alert(response.message);
                location.reload();
            },
            error: function(xhr, status, error) {
                alert('Failed to cancel request');
            }
        });
    }
}

$(document).ready(function () {
    $(".view-more").on("click", function () {
        // Lấy dữ liệu từ thuộc tính data-*
        var avatar = $(this).data("avatar");
        var fullname = $(this).data("fullname");
        var location = $(this).data("location");
        var description = String($(this).data("description")); // Chuyển đổi description thành chuỗi
        var deadline = $(this).data("deadline");
        var dayLocation = $(this).data("daylocation");
        var dayDescription = $(this).data("daydescription");
        var daysRequired = $(this).data("daysrequired");
        var repLocation = $(this).data("replocation");
        var repDescription = $(this).data("repdescription");
        var startDate = $(this).data("startdate");
        var months = $(this).data("months");
        var price = $(this).data("price");
        var type = $(this).data("type");

        // Cập nhật nội dung modal dựa trên dữ liệu của item được click
        $("#modal-avatar").attr("src", avatar);
        $("#modal-fullname").text(fullname);
        $("#modal-location").text(location);
        $("#modal-description").html(description.replace(/\n/g, "<br>"));  // Chuyển đổi thành chuỗi
        $("#modal-deadline").text("Deadline: " + (deadline || ""));
        $("#modal-daylocation").text(dayLocation || "");
        $("#modal-daydescription").text(dayDescription || "");
        $("#modal-daysrequired").text("Days Required: " + (daysRequired || ""));
        $("#modal-replocation").text(repLocation || "");
        $("#modal-repdescription").text(repDescription || "");
        $("#modal-startdate").text("Start Date: " + (startDate || ""));
        $("#modal-months").text("Months: " + (months || ""));
        $("#modal-price").text(price || "");
        $("#modal-type").text(type || "");

        // Hiển thị/ẩn nội dung modal dựa trên loại yêu cầu
        if (type === "POST" || type === "VIDEO") {
            $("#modal-daysrequired").hide();
            $("#modal-startdate").hide();
            $("#modal-months").hide();
        } else if (type === "HIREBYDAY") {
            $("#modal-daysrequired").show();
            $("#modal-startdate").hide();
            $("#modal-months").hide();
            $("#modal-deadline").hide();
        } else if (type === "REPRESENTATIVE") {
            $("#modal-daysrequired").hide();
            $("#modal-startdate").show();
            $("#modal-months").show();
            $("#modal-deadline").hide();
        }

        // Cập nhật hiển thị loại yêu cầu
        $("#modal-type").text(type || "");
    });

    // Reset nội dung modal khi modal bị ẩn
    $("#viewMoreModal").on("hidden.bs.modal", function () {
        $("#modal-avatar").attr("src", "");
        $("#modal-fullname").text("");
        $("#modal-location").text("");
        $("#modal-description").text("");
        $("#modal-deadline").text("");
        $("#modal-daylocation").text("");
        $("#modal-daydescription").text("");
        $("#modal-daysrequired").text("");
        $("#modal-replocation").text("");
        $("#modal-repdescription").text("");
        $("#modal-startdate").text("");
        $("#modal-months").text("");
        $("#modal-price").text("");
        $("#modal-type").text("");
    });

    $('#viewUrlModal').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget);
        var urlResult = button.data('urlresult');
        var modal = $(this);
        modal.find('#modal-urlResult').attr("href", urlResult).text(urlResult).attr("target", "_blank");
    });
});

async function submitResult() {
    const submitUrl = document.getElementById('resultLink').value;

    const data = {
        url: submitUrl,
        requestId: requestId
    };
    console.log(data);
    try {
        const response = await fetch("/request/submit", {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify(data)
        });

        if (!response.ok) {
            throw new Error('Network response was not ok ' + response.statusText);
        }

        const result = await response.json();
        alert(result.message);
    } catch (error) {
        alert("An error occurred: " + error.message);
    }
}

$(document).ready(function () {
    // Xử lý khi modal "View URL" được hiển thị
    $('#viewUrlModal').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget);
        var urlResult = button.data('urlresult');
        requestId = button.data('requestid'); 
        var modal = $(this);
        modal.find('#modal-urlResult').attr("href", urlResult).text(urlResult).attr("target", "_blank");
    });
});

// Hàm để gửi yêu cầu hoàn thành request
async function finishRequest() {
    if (requestId === null) {
        alert("Request ID is not set.");
        return;
    }

    const data = {
        requestId: requestId
    };

    try {
        const response = await fetch("/request/finish-request", {
            method: "POST",
            headers: {
                "Content-Type": "application/x-www-form-urlencoded"
            },
            body: new URLSearchParams(data)
        });

        if (!response.ok) {
            throw new Error('Network response was not ok ' + response.statusText);
        }

        const result = await response.json();
        alert(result.message);

        // Đóng modal sau khi hoàn thành request
        $('#viewUrlModal').modal('hide');
        location.reload(); // Tải lại trang để cập nhật trạng thái request

    } catch (error) {
        alert("An error occurred: " + error.message);
    }
}

