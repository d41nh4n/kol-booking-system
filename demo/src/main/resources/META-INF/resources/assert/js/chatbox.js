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
  var currentDate = new Date();

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
      var displayTime = "Hôm qua " + timeString;
    } else {
      // Nếu không phải hôm qua, hiển thị ngày và giờ
      var timeString = messageDate.toLocaleString();
      var displayTime = timeString;
    }
  }

  var conversationItem = $("<li>").addClass("conversation-item");
  var conversationItemContent = $("<div>").addClass(
    "conversation-item-content"
  );
  var conversationItemWrapper = $("<div>").addClass(
    "conversation-item-wrapper"
  );
  var conversationItemBox = $("<div>").addClass("conversation-item-box");
  var conversationItemText = $("<div>")
    .addClass("conversation-item-text")
    .html("<p>" + message.content + "</p>");
  var conversationItemTime = $("<div>")
    .addClass("conversation-item-time")
    .text(displayTime);

  // Xác định người gửi và thêm lớp 'me' nếu tin nhắn thuộc về người đang đăng nhập
  if (message.sender === senderId) {
    conversationItem.addClass("me");
  }

  conversationItemText.append(conversationItemTime);
  conversationItemBox.append(conversationItemText);
  conversationItemWrapper.append(conversationItemBox);
  conversationItemContent.append(conversationItemWrapper);
  conversationItem.append(conversationItemContent);

  // Thêm tin nhắn vào cuộc trò chuyện
  $(".conversation-wrapper").append(conversationItem);
  scrollToBottom();
}

// Hàm gửi tin nhắn
function sendMessage(content) {
  senderId = $("#userId").val();
  const chatMessage = {
    sender: senderId,
    recipient: recipientId,
    content: content,
    timeStamp: new Date().toISOString(),
  };
  stompClient.send("/app/chat.sendMessage", {}, JSON.stringify(chatMessage));
  displayMessage(chatMessage);
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

// Khi người dùng chọn một cuộc trò chuyện từ danh sách

$(".content-messages-list").on("click", "a", handleConversationClick);

function handleConversationClick(event) {
  event.preventDefault();
  conversationId = $(this).data("conversation");
  recipientId = $(this).closest("li").data("recipient");
  currentlyDisplayedUserId = String(recipientId);
  console.log("Clicked on conversation link");
  // Ẩn dấu hiệu tin nhắn mới khi mở một cuộc trò chuyện mới
  var recipientListItem = $(this).closest("li");
  recipientListItem.find(".content-message-unread").hide();
  console.log(conversationId);

  getConversationTop(conversationId);
  getMessage(conversationId);
}

// Hàm gửi tin nhắn khi người dùng click nút gửi
$(".conversation-form-submit").click(function () {
  var messageContent = $(".conversation-form-input").val().trim();

  if (messageContent !== "") {
    sendMessage(messageContent);
    $(".conversation-form-input").val("");
  }
});

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
