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
    let service: MessageService
    
    init(user: User) {
        service = MessageService(chatPartner: user)
        observeMessages()
    }
    
    func sendMessage() {
        service.sendMessage(messageText)
    }
    
    func observeMessages() {
        service.observeMessages() { [weak self] messages in
            guard let self else { return }
            self.messages.append(contentsOf: messages)
        }
    }
}
