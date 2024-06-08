<%@ page language="java" contentType="text/html; charset=US-ASCII" pageEncoding="US-ASCII" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/remixicon@3.2.0/fonts/remixicon.css" rel="stylesheet">
    <link rel="stylesheet" href="../../assert/css/chatbox.css">
    <link rel="stylesheet" href="../../assert/css/chatbox-taiwind-color.css">
    <title>Chat</title>
</head>
<body>
<%@include file="navbar.jsp" %>
<!-- start: Chat -->
<input type="text" id="recipientId" value="" readonly="" hidden="">

<section class="chat-section">
    <div class="chat-container">
        <div class="chat-content">
            <div class="content-sidebar">
                <div class="content-sidebar-title">Chats</div>
                <form action="" class="content-sidebar-form">
                    <input type="search" class="content-sidebar-input" placeholder="Search...">
                    <button type="submit" class="content-sidebar-submit"><i class="ri-search-line"></i></button>
                </form>
                <div class="content-messages">
                    <ul class="content-messages-list">
                        <c:forEach items="${conversations}" var="conversation">
                            <li data-id="${conversation.conversationId}" data-recipient="${conversation.recipientId}">
                                <a href="#" class="conversation-link" data-conversation="${conversation.conversationId}">
                                    <img class="content-message-image" src="${conversation.avatarUrl}" alt="">
                                    <span class="content-message-info">
                                        <span class="content-message-name">${conversation.recipientName}</span>
                                        <span class="content-message-text">${conversation.lastMessage}</span>
                                    </span>
                                    <span class="content-message-more">
                                    <span class="content-message-unread" style="display:none;">&nbsp</span>
                                    </span>
                                </a>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </div>

            <div class="conversation conversation-default active"  id="conversation-default">
                <i class="ri-chat-3-line"></i>
                <p>Select chat and view conversation!</p>
            </div>
            
            <div class="conversation" id="conversation">
                    <div class="conversation-top">
                        <div class="conversation-user">
                            <img class="conversation-user-image" src="https://images.unsplash.com/photo-1534528741775-53994a69daeb?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OXx8cGVvcGxlfGVufDB8fDB8fHww&auto=format&fit=crop&w=500&q=60" alt="">
                                <div class="conversation-user-name">Someone</div>
                        </div>
                    </div>
                <div class="conversation-main">
                    <ul class="conversation-wrapper">
                        <!-- Tin nhắn được hiển thị ở đây -->
                    </ul>
                </div>
                <div class="conversation-form">
                    <button type="button" class="conversation-form-button"><i class="ri-emotion-line"></i></button>
                    <div class="conversation-form-group">
                        <textarea class="conversation-form-input" rows="1" placeholder="Type here..."></textarea>
                        <button type="button" class="conversation-form-record"><i class="ri-mic-line"></i></button>
                    </div>
                    <button type="button" class="conversation-form-button conversation-form-submit"><i class="ri-send-plane-2-line"></i></button>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- end: Chat -->

<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.4/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="../../assert/js/chatbox.js"></script>