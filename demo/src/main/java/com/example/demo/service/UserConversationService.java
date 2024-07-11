package com.example.demo.service;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;
import com.example.demo.dto.respone.ConversationExsisted;
import com.example.demo.entity.conversation.UserConversation;
import com.example.demo.repository.UserConversationRepository;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class UserConversationService {

    private final UserConversationRepository userConversationRepository;

    public void save(UserConversation conversation) {
        userConversationRepository.save(conversation);
    }

    // public Optional<List<UserConversation>> findByUsersInConversation(String
    // conversationId) {
    // return userConversationRepository.findByConversationId(conversationId);
    // }

    public List<ConversationExsisted> findConversationByUserId(int user) {
        return userConversationRepository.findConversationsByUserId(user);
    }
}
