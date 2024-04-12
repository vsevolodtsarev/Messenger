//
//  MessageService.swift
//  Messenger
//
//  Created by Всеволод Царев on 12.04.2024.
//

import Foundation
import Firebase

struct MessageService {
    static let messageCollection = Firestore.firestore().collection("messages")
    
    static func sendMessage(_ textMessage: String, toUser user: User) {
        guard let currentUId = Auth.auth().currentUser?.uid else { return }
        let chatPartnerId = user.id
        
        let currentUserRef = messageCollection.document(currentUId).collection(chatPartnerId).document()
        let chatPartnerRef = messageCollection.document(chatPartnerId).collection(currentUId)
        
        let messageId = currentUserRef.documentID
        let message = Message(messageId: messageId, 
                              fromId: currentUId,
                              toId: chatPartnerId,
                              messageText: textMessage,
                              timestamp: Timestamp())
        
        guard let messageData = try? Firestore.Encoder().encode(message) else { return }
        
        currentUserRef.setData(messageData)
        chatPartnerRef.document(messageId).setData(messageData)
    }
}
