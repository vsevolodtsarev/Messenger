//
//  ChatViewModel.swift
//  Messenger
//
//  Created by Всеволод Царев on 12.04.2024.
//

import Foundation

final class ChatViewModel: ObservableObject {
    @Published var messageText = ""
    let user: User
    
    init(user: User) {
        self.user = user
    }
    
    func sendMessage() {
        MessageService.sendMessage(messageText, toUser: user)
    }
}
