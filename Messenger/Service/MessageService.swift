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
    
    static func observeMessages(chatPartner: User, completion: @escaping([Message]) -> Void) {
        guard let currentId = Auth.auth().currentUser?.uid else { return }
        let chatPartnerId = chatPartner.id
        
        let query = messageCollection
            .document(currentId)
            .collection(chatPartnerId)
            .order(by: "timestamp", descending: false)
        
        query.addSnapshotListener { snapshot, _ in
            guard let changes = snapshot?.documentChanges.filter({ $0.type == .added }) else { return }
            var messages = changes.compactMap({ try? $0.document.data(as: Message.self) })
            
            for(index, message) in messages.enumerated() where message.fromId != currentId {
                messages[index].user = chatPartner
            }
            
            completion(messages)
        }
    }
}
