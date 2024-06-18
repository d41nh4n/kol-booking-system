let conversationWrapper = null;
let conversationId = null;
let date = null;
let senderId = null;
let recipientId = null;
let stompClient = null;
let currentlyDisplayedUserId = null;
let contentMessageName = null;

const accessToken = getCookie("accessToken");

if (accessToken) {
  console.log("Access Token:", accessToken);
} else {
  console.log("Access Token not found or expired.");
}

// Hàm scrollToBottom để cuộn xuống cuối cuộc trò chuyện
function scrollToBottom() {
  var conversationContainer = document.querySelector(".conversation-main");
  conversationContainer.scrollTo({
    top: conversationContainer.scrollHeight,
    behavior: "smooth",
  });
}

// Hàm lấy giá trị của cookie
function getCookie(name) {
  const cookieValue = document.cookie
    .split("; ")
    .find((row) => row.startsWith(name + "="))
    ?.split("=")[1];

  return cookieValue ? decodeURIComponent(cookieValue) : null;
}

// Hàm lấy tin nhắn từ máy chủ
function getMessage(conversationId) {
  $.getJSON(`/getChat?conversationId=${conversationId}`, function (data) {
    var messages = data.message;
    messages.reverse();
    // Xóa toàn bộ nội dung trong .conversation-wrapper trước khi thêm tin nhắn mới
    $(".conversation-wrapper").empty();

    // Duyệt qua các tin nhắn và hiển thị chúng
    $.each(messages, function (index, message) {
      if (typeof message === "object") {
        displayMessage(message);
      } else {
        console.error("Invalid message format:", message);
      }
    });
  }).fail(function (error) {
    console.error("Error fetching chat data:", error);
  });
}

// Hàm hiển thị tin nhắn
function displayMessage(message) {
  var messageDate = new Date(message.timeStamp);
  console.log(messageDate);
  var currentDate = new Date();
  console.log(message);
  // Kiểm tra xem ngày của tin nhắn có phải là hôm nay không
  if (messageDate.toDateString() === currentDate.toDateString()) {
    // Nếu là hôm nay, hiển thị giờ
    var timeString = messageDate.toLocaleTimeString([], {
      hour: "2-digit",
      minute: "2-digit",
    });
    var displayTime = timeString;
  } else {
    // Nếu không phải hôm nay, kiểm tra xem ngày của tin nhắn có phải là hôm qua không
    var yesterday = new Date(currentDate);
    yesterday.setDate(currentDate.getDate() - 1);
    if (messageDate.toDateString() === yesterday.toDateString()) {
      // Nếu là hôm qua, hiển thị "Hôm qua" và giờ
      var timeString = messageDate.toLocaleTimeString([], {
        hour: "2-digit",
        minute: "2-digit",
      });
      var displayTime = "Yesterday " + timeString;
    } else {
      // Nếu không phải hôm qua, hiển thị ngày và giờ
      var timeString = messageDate.toLocaleString();
      var displayTime = timeString;
    }
  }

  // Tạo các phần tử HTML
  var conversationItem = $("<li>").addClass("conversation-item");
  var conversationItemContent = $("<div>").addClass(
    "conversation-item-content"
  );
  var conversationItemWrapper = $("<div>").addClass(
    "conversation-item-wrapper"
  );
  var conversationItemBox = $("<div>").addClass("conversation-item-box");
  var conversationItemTime = $("<div>")
    .addClass("conversation-item-time")
    .text(displayTime);

  // Hiển thị nội dung dựa trên loại tin nhắn
  var messageContent;
  if (message.type === "TEXT") {
    messageContent = $("<div>")
      .addClass("conversation-item-text")
      .html("<p>" + message.content + "</p>");
  } else if (message.type === "IMAGE") {
    messageContent = $("<div>")
      .addClass("conversation-item-image")
      .html('<img src="' + message.content + '" alt="Image" />');
  } else if (message.type === "VIDEO") {
    var videoElement = $("<video>")
      .attr({
        src: message.content,
        controls: true,
      })
      .append(
        '<source src="' +
          message.content +
          '" type="video/mp4">Your browser does not support the video tag.'
      );
    messageContent = $("<div>")
      .addClass("conversation-item-video")
      .append(videoElement);
  } else if (message.type === "AUDIO") {
    messageContent = $("<div>")
      .addClass("conversation-item-audio")
      .html(
        '<audio controls><source src="' +
          message.content +
          '" type="audio/mp3">Your browser does not support the audio tag.</audio>'
      );
  } else if (message.type === "FILE") {
    messageContent = $("<div>")
      .addClass("conversation-item-file")
      .html(
        '<a href="' + message.content + '" download>' + message.content + "</a>"
      );
  }

  // Xác định người gửi và thêm lớp 'me' nếu tin nhắn thuộc về người đang đăng nhập
  if (message.sender === senderId) {
    conversationItem.addClass("me");
  }

  // Thêm nội dung và thời gian vào các phần tử
  conversationItemBox.append(messageContent);
  conversationItemBox.append(conversationItemTime);
  conversationItemWrapper.append(conversationItemBox);
  conversationItemContent.append(conversationItemWrapper);
  conversationItem.append(conversationItemContent);

  // Thêm tin nhắn vào cuộc trò chuyện
  $(".conversation-wrapper").append(conversationItem);
  scrollToBottom();
}

function replaceNewestMessage(recipient, messageData) {
  var chosenUser = $(`li[data-recipient="${recipient}"]`);
  var newestMessage = chosenUser.find(".content-message-text");
  console.log(messageData);
  newestMessage.empty();
  if (messageData.type === "TEXT") {
    newestMessage.append(messageData.content); // Trường hợp tin nhắn là văn bản đơn giản
  } else if (
    messageData.type === "IMAGE/JPEG" ||
    messageData.type === "IMAGE"
  ) {
    newestMessage.append("A-IMG"); // Hiển thị văn bản cho tin nhắn hình ảnh
  } else if (messageData.type === "VIDEO/MP4" || messageData.type === "VIDEO") {
    newestMessage.append("A-VIDEO"); // Hiển thị văn bản cho tin nhắn video
  } else if (messageData.type === "AUDIO" || messageData.type === "AUDIO/MP3") {
    newestMessage.append("A-AUDIO"); // Hiển thị văn bản cho tin nhắn âm thanh
  } else {
    newestMessage.append("A-FILE"); // Hiển thị văn bản cho tin nhắn tệp
  }
}

// Hàm gửi tin nhắn
function sendMessage() {
  const senderId = $("#userId").val();
  const recipientId = currentlyDisplayedUserId;
  const messageFile = $("#fileInput")[0].files[0];
  const messageText = $("#messageInput").val().trim();

  if (messageText !== "") {
    console.log("Send Text");
    let chatMessage = {
      sender: senderId,
      recipient: recipientId,
      content: messageText,
      type: "TEXT",
      timeStamp: new Date().toISOString(),
    };

    let typeMessage = "TEXT";
    stompClient.send(
      "/app/chat.sendMessage",
      {},
      JSON.stringify({ typeMessage, chatMessage })
    );
    displayMessage(chatMessage);
    replaceNewestMessage(recipientId, chatMessage);
  }

  if (messageFile !== undefined) {
    console.log("Send File");
    const reader = new FileReader();
    reader.onload = function (event) {
      let fileType;
      const fileTypeGroup = messageFile.type.split("/")[0].toUpperCase();

      if (fileTypeGroup === "IMAGE") {
        fileType = "IMAGE";
      } else if (fileTypeGroup === "VIDEO") {
        fileType = "VIDEO";
      } else if (fileTypeGroup === "AUDIO") {
        fileType = "AUDIO";
      } else {
        fileType = "FILE";
      }

      let fileMessage = {
        sender: senderId,
        recipient: recipientId,
        content: event.target.result,
        type: fileType,
        timeStamp: new Date().toISOString(),
      };
      let typeMessage = "FILE";
      stompClient.send(
        "/app/chat.sendMessage",
        {},
        JSON.stringify({ typeMessage, fileMessage })
      );
    };
    reader.readAsDataURL(messageFile);
  }

  $("#messageInput").val("");
  $("#fileInput").val("");
  $("#fileInfo").hide();
}

// Hàm xử lý khi nhận được tin nhắn mới từ máy chủ WebSocket
function onMessageReceived(message) {
  console.log("Received message:", message.body);
  var messageData = JSON.parse(message.body);

  // Kiểm tra xem tin nhắn đến có phải từ người đang hiển thị trên chatbox hay không
  if (String(messageData.sender) === String(currentlyDisplayedUserId)) {
    displayMessage(messageData);
  } else {
    // Hiển thị dấu hiệu tin nhắn mới
    var conversationListItem = $(`li[data-recipient="${messageData.sender}"]`);
    //nười nhắn tin mới chưa render trong view
    if (!conversationListItem.length) {
      getConnectedUser(renderUserConversations);
    }
    var recipientListItem = $(`li[data-recipient="${messageData.sender}"]`);
    var unreadSpan = recipientListItem.find(".content-message-unread");
    unreadSpan.show();
  }
  replaceNewestMessage(messageData.sender, messageData);
}

// Hàm hiển thị thông báo tin nhắn chưa đọc

$(document).ready(function () {
  const accessToken = getCookie("accessToken");

  if (accessToken) {
    console.log("Access Token:", accessToken);

    userId = $("#userId").val();
    console.log("User ID:", userId);

    var headers = {
      token: accessToken,
    };

    const socket = new SockJS("/ws");
    stompClient = Stomp.over(socket, {
      heartbeat: {
        incoming: 0,
        outgoing: 20000,
      },
      reconnectDelay: 5000,
    });

    // onConnect CallBack
    function onConnected() {
      console.log("Connected to WebSocket");
      senderId = $("#userId").val();
      stompClient.subscribe(
        `/user/${senderId}/queue/messages`,
        onMessageReceived // Gọi hàm onMessageReceived khi nhận được tin nhắn mới
      );
    }

    // onError CallBack
    function onError(error) {
      console.error(
        "Could not connect to WebSocket server. Please refresh this page to try again!"
      );
    }

    // Connect
    stompClient.connect(headers, onConnected, onError);
  } else {
    console.log("Access Token not found or expired.");
  }
});

function handleConversationClick(event) {
  var recipientListItem = $(this).closest("li");
  if (!recipientListItem || recipientListItem.length === 0) {
    console.error("recipientListItem is undefined");
    return;
  }

  if (recipientListItem.hasClass("active")) {
    return;
  }
  event.preventDefault();
  conversationId = $(this).data("conversation");
  recipientId = $(this).closest("li").data("recipient");
  currentlyDisplayedUserId = String(recipientId);
  console.log("Clicked on conversation link");
  // Ẩn dấu hiệu tin nhắn mới khi mở một cuộc trò chuyện mới
  var recipientListItem = $(this).closest("li");
  recipientListItem.find(".content-message-unread").hide();
  console.log(conversationId);

  $(".content-messages-list li").removeClass("active");
  recipientListItem.addClass("active");

  getConversationTop(conversationId);
  getMessage(conversationId);
}

// Hàm gửi tin nhắn khi người dùng click nút gửi
function getMessageFromInputAndSend() {
  var messageContent = $(".conversation-form-input").val().trim();
  if (messageContent !== "") {
    sendMessage();
  }
}
function getConnectedUser(callback) {
  fetch(`/getUserChatted?userId=${senderId}`)
    .then(function (res) {
      return res.json();
    })
    .then(callback);
}

function createConversationElement(conversation) {
  const listItem = document.createElement("li");
  listItem.setAttribute("data-id", conversation.conversationId);
  listItem.setAttribute("data-recipient", conversation.recipientId);

  const conversationLink = document.createElement("a");
  conversationLink.setAttribute("href", "#");
  conversationLink.setAttribute("class", "conversation-link");
  conversationLink.setAttribute(
    "data-conversation",
    conversation.conversationId
  );

  const contentMessageImage = document.createElement("img");
  contentMessageImage.setAttribute("class", "content-message-image");
  contentMessageImage.setAttribute("src", conversation.avatarUrl);
  contentMessageImage.setAttribute("alt", "");

  const contentMessageInfo = document.createElement("span");
  contentMessageInfo.setAttribute("class", "content-message-info");

  const contentMessageName = document.createElement("span");
  contentMessageName.setAttribute("class", "content-message-name");
  contentMessageName.innerText = conversation.recipientName;

  const contentMessageText = document.createElement("span");
  contentMessageText.setAttribute("class", "content-message-text");
  contentMessageText.innerText = conversation.lastMessage;

  const contentMessageMore = document.createElement("span");
  contentMessageMore.setAttribute("class", "content-message-more");

  const contentMessageUnread = document.createElement("span");
  contentMessageUnread.setAttribute("class", "content-message-unread");
  contentMessageUnread.setAttribute("style", "display:none;");
  contentMessageUnread.innerText = " ";

  contentMessageMore.appendChild(contentMessageUnread);
  contentMessageInfo.appendChild(contentMessageName);
  contentMessageInfo.appendChild(contentMessageText);
  conversationLink.appendChild(contentMessageImage);
  conversationLink.appendChild(contentMessageInfo);
  conversationLink.appendChild(contentMessageMore);

  listItem.appendChild(conversationLink);

  return listItem;
}

function renderUserConversations(conversations) {
  try {
    const conversationList = $(".content-messages-list");
    conversationList.empty();
    conversations.forEach((conversation) => {
      const listItem = createConversationElement(conversation);
      conversationList.append(listItem);
    });
    $("#conversation-default").removeClass("active");
    $("#conversation").addClass("active");
  } catch (error) {
    console.error("Error rendering user conversations:", error);
  }
}

$(document).ready(function () {
  var contentMessagesList = $(".content-messages-list");

  if (contentMessagesList.children().length > 0) {
    // Nếu có cuộc trò chuyện trong danh sách
    firstConversation = contentMessagesList.find("li:first-child"); // Lấy phần tử li đầu tiên
    conversationId = firstConversation.data("id");
    recipientId = firstConversation.data("recipient");
    currentlyDisplayedUserId = String(recipientId);
    senderId = $("#userId").val();
    // Hiển thị cuộc trò chuyện và ẩn cuộc trò chuyện mặc định
    $("#conversation-default").removeClass("active");
    $("#conversation").addClass("active");
    firstConversation.addClass("active");
    // Hiển thị thông tin của người nhận
    getConversationTop(conversationId);
    getMessage(conversationId);
  }
  // Lấy dữ liệu và hiển thị cuộc trò chuyện
});

function getConversationTop(conversationId) {
  var conversationListItem = $(".content-messages-list").find(
    `li[data-id="${conversationId}"]`
  );
  if (conversationListItem.length > 0) {
    // Nếu tìm thấy phần tử li, lấy thông tin của người nhận
    var recipientName = conversationListItem
      .find(".content-message-name")
      .text();
    var recipientImage = conversationListItem
      .find(".content-message-image")
      .attr("src");

    // Tạo phần tử để chứa thông tin người nhận
    var userInfo = $("<div>").addClass("conversation-user");
    var userImage = $("<img>")
      .addClass("conversation-user-image")
      .attr("src", recipientImage);
    var userName = $("<div>")
      .addClass("conversation-user-name")
      .text(recipientName);

    // Thêm hình ảnh và tên người nhận vào phần tử .conversation-user
    userInfo.append(userImage);
    userInfo.append(userName);

    // Xóa nội dung hiện tại trong .conversation-top và thêm thông tin người nhận
    var conversationTop = $(".conversation-top");
    conversationTop.empty(); // Xóa nội dung hiện tại
    conversationTop.append(userInfo); //
  }
}

$(document).ready(function () {
  $(".conversation-form-submit").click(getMessageFromInputAndSend);

  $("#messageInput, #fileInput").keyup(function (event) {
    var message = $("#messageInput").val().trim();
    var file = $("#fileInput")[0].files[0];
    if (event.keyCode === 13 && (message !== "" || file)) {
      getMessageFromInputAndSend();
    }
  });
});

// show status file
$(document).ready(function () {
  // Trigger file input when icon is clicked
  $("#fileInputButton").on("click", function () {
    $("#fileInput").click();
  });

  // Handle file input change
  $("#fileInput").on("change", function () {
    var file = this.files[0];

    // File type and size validation
    if (file) {
      var fileType = file.type.split("/")[0];
      var fileSize = file.size / 1024 / 1024; // size in MB

      if (
        (fileType === "image" && fileSize <= 5) ||
        (fileType === "video" && fileSize <= 25) ||
        fileType === "audio"
      ) {
        // Display file info in the span
        $("#fileName").text(file.name);
        $("#fileType").text(fileType);
        $("#fileInfo").show();
      } else {
        alert(
          "File không hợp lệ. Vui lòng tải lên ảnh dưới 5MB, video dưới 25MB hoặc audio."
        );
        $("#fileInput").val(""); // Clear the file input
        $("#fileInfo").hide(); // Hide file info
      }
    }
  });

  $("#removeFileButton").on("click", function () {
    $("#fileInput").val(""); // Clear the file input
    $("#fileInfo").hide(); // Hide file info
    $("#fileName").text("");
    $("#fileType").text("");
  });

  // Handle open file and show in chat box
  $(".conversation-form-submit").on("click", function () {
    var file = $("#fileInput")[0].files[0];
    if (file) {
      var reader = new FileReader();
      reader.onload = function (e) {
        var content = "";

        var fileType = file.type.split("/")[0];
        if (fileType === "image") {
          content =
            '<li class="sent"><img src="' +
            e.target.result +
            '" class="chat-image" alt="Image"></li>';
        } else if (fileType === "video") {
          content =
            '<li class="sent"><video controls class="chat-video"><source src="' +
            e.target.result +
            '"></video></li>';
        } else if (fileType === "audio") {
          content =
            '<li class="sent"><audio controls class="chat-audio"><source src="' +
            e.target.result +
            '"></audio></li>';
        }
        $(".conversation-wrapper").append(content);
        if (file) {
          const data = {
            type: file.type.toUpperCase(),
          };
          replaceNewestMessage(recipientId, data);
          sendMessage();
        }
      };
      reader.readAsDataURL(file);
    }
  });
});

// Khi người dùng chọn một cuộc trò chuyện từ danh sách
$(".content-messages-list").on("click", "a", handleConversationClick);
