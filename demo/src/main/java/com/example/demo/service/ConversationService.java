package com.example.demo.service;

import org.springframework.stereotype.Service;

import com.example.demo.entity.conversation.Conversation;
import com.example.demo.repository.ConversationRepository;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ConversationService {

    private final ConversationRepository conversationRepository;

    public Conversation findConversationById(String id) {
        return conversationRepository.findById(id).orElse(null);
    }

    public void save(Conversation conversation) {
        conversationRepository.save(conversation);
    }

}
