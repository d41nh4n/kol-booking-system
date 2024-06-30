
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
            // Set modal content based on clicked item data
            $("#modal-avatar").attr("src", $(this).data("avatar"));
            $("#modal-fullname").text($(this).data("fullname"));
            $("#modal-location").text($(this).data("location"));
            $("#modal-description").html($(this).data("description").replace(/\n/g, "<br>"));
            $("#modal-deadline").text("Deadline: " + $(this).data("deadline"));
            $("#modal-daylocation").text($(this).data("daylocation"));
            $("#modal-daydescription").text($(this).data("daydescription"));
            $("#modal-daysrequired").text("Days Required: " + $(this).data("daysrequired"));
            $("#modal-replocation").text($(this).data("replocation"));
            $("#modal-repdescription").text($(this).data("repdescription"));
            $("#modal-startdate").text("Start Date: " + $(this).data("startdate"));
            $("#modal-months").text("Months: " + $(this).data("months"));
            $("#modal-price").text($(this).data("price"));
            $("#modal-type").text($(this).data("type"));
    
            var requestType = $(this).data("type");
            // Show/hide modal content based on request type
            if (requestType === "POST" || requestType === "VIDEO") {
                $("#modal-daysrequired").hide();
                $("#modal-startdate").hide();
                $("#modal-months").hide();
            } else if (requestType === "HIREBYDAY") {
                $("#modal-daysrequired").show();
                $("#modal-startdate").hide();
                $("#modal-months").hide();
                $("#modal-deadline").hide();
            } else if (requestType === "REPRESENTATIVE") {
                $("#modal-daysrequired").hide();
                $("#modal-startdate").show();
                $("#modal-months").show();
                $("#modal-deadline").hide();
            }
    
            // Reset type display
            $("#modal-type").text(requestType);
        });
    
        // Reset modal content when modal is hidden
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
    });
    