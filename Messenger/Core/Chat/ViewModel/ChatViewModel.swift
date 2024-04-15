//
//  ChatViewModel.swift
//  Messenger
//
//  Created by Всеволод Царев on 12.04.2024.
//

import Foundation

final class ChatViewModel: ObservableObject {
    @Published var messageText = ""
    @Published var messages = [Message]()
    let user: User
    
    init(user: User) {
        self.user = user
        observeMessages()
    }
    
    func sendMessage() {
        MessageService.sendMessage(messageText, toUser: user)
    }
    
    func observeMessages() {
        MessageService.observeMessages(chatPartner: user) { [weak self] messages in
            guard let self else { return }
            self.messages.append(contentsOf: messages)
        }
    }
}
