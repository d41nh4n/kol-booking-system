function cancelRequest(requestId) {
  if (confirm("Are you sure to cancel !")) {
    console.log(requestId);
    $.ajax({
      url: "/request/cancel-request",
      type: "POST",
      data: { requestId: requestId },
      success: function (response) {
        alert(response.message);
        location.reload();
      },
      error: function (xhr, status, error) {
        alert("Failed to cancel request");
      },
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
    $("#modal-description").html(description.replace(/\n/g, "<br>")); // Chuyển đổi thành chuỗi
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

  $("#viewUrlModal").on("show.bs.modal", function (event) {
    var button = $(event.relatedTarget);
    var urlResult = button.data("urlresult");
    var modal = $(this);
    modal
      .find("#modal-urlResult")
      .attr("href", urlResult)
      .text(urlResult)
      .attr("target", "_blank");
  });
});

$(document).ready(function () {
  $("#submitModal").on("show.bs.modal", function (event) {
    var button = $(event.relatedTarget);
    var requestId = button.data("requestid");

    $("#submitRequestId").val(requestId);
  });
});

async function submitResult() {
  const submitUrl = $("#resultLink").val();
  var requestId = $("#submitRequestId").val();
  const data = {
    url: submitUrl,
    requestId: requestId,
  };
  console.log(data);
  try {
    const response = await fetch("/request/submit", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify(data),
    });

    if (!response.ok) {
      throw new Error("Network response was not ok " + response.statusText);
    }

    const result = await response.json();
    alert(result.message);
  } catch (error) {
    alert("An error occurred: " + error.message);
  }
}

$(document).ready(function () {
  $("#viewUrlModal").on("show.bs.modal", function (event) {
    var button = $(event.relatedTarget);
    var urlResult = button.data("urlresult");
    requestId = button.data("requestid");
    var modal = $(this);
    modal
      .find("#modal-urlResult")
      .attr("href", urlResult)
      .text(urlResult)
      .attr("target", "_blank");
  });
});

// Hàm để gửi yêu cầu hoàn thành request
async function finishRequest() {
  if (confirm("Are you sure to finish request!")) {
    if (requestId === null) {
      alert("Request ID is not set.");
      return;
    }

    const data = {
      requestId: requestId,
    };

    try {
      const response = await fetch("/request/finish-request", {
        method: "POST",
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        },
        body: new URLSearchParams(data),
      });

      if (!response.ok) {
        throw new Error("Network response was not ok " + response.statusText);
      }

      const result = await response.json();
      alert(result.message);

      // Đóng modal sau khi hoàn thành request
      $("#viewUrlModal").modal("hide");
      window.location.href = `https://localhost/comment/rating-page?requestId=${requestId}`;
    } catch (error) {
      alert("An error occurred: " + error.message);
    }
  }
}

function acceptRequest(requestId) {
  if (confirm("Are you sure to accept!")) {
    $.ajax({
      url: "/request/accept",
      type: "POST",
      data: { request: requestId },
      success: function (response) {
        alert(response);
        window.location.href = "https://localhost/request/in-process";
      },
      error: function (xhr, status, error) {
        console.error("Error:", error);
        alert("Failed to accept the request");
      },
    });
  }
}

function denyRequest(requestId) {
  if (confirm("Are you sure to deny!")) {
    $.ajax({
      url: "/request/deny",
      type: "POST",
      data: { request: requestId },
      success: function (response) {
        alert(response);
        window.location.href = "https://localhost/request/cancel";
      },
      error: function (xhr, status, error) {
        console.error("Error:", error);
        alert("Failed to deny the request");
      },
    });
  }
}
$(document).ready(function() {
  // Event listener for the 'Get Money' button click
  $('.get-money').click(function(e) {
    e.preventDefault();

    const requestId = $(this).data('requestid');

    if (requestId) {
      $.ajax({
        type: 'POST',
        url: '/request/get-money',
        data: { requestId: requestId },
        success: function(response) {
          alert('Success: ' + response);
          location.reload(); // Reload the page to update the UI
        },
        error: function(xhr, status, error) {
          alert('Error: ' + xhr.responseText);
        }
      });
    } else {
      alert('Request ID is missing.');
    }
  });
});
