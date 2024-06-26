//
//  MessageService.swift
//  Messenger
//
//  Created by Всеволод Царев on 12.04.2024.
//

import Foundation
import Firebase

struct MessageService {
    let messageCollection = Firestore.firestore().collection("messages")
    let chatPartner: User
    
    func sendMessage(_ textMessage: String) {
        guard let currentUId = Auth.auth().currentUser?.uid else { return }
        let chatPartnerId = chatPartner.id
        
        let currentUserRef = messageCollection.document(currentUId).collection(chatPartnerId).document()
        let chatPartnerRef = messageCollection.document(chatPartnerId).collection(currentUId)
        
        let recentCurrentUserRef = messageCollection.document(currentUId).collection("recent-messages").document(chatPartnerId)
        let recentPartnerRef = messageCollection.document(chatPartnerId).collection("recent-messages").document(currentUId)
        
        let messageId = currentUserRef.documentID
        let message = Message(messageId: messageId,
                              fromId: currentUId,
                              toId: chatPartnerId,
                              messageText: textMessage,
                              timestamp: Timestamp())
        
        guard let messageData = try? Firestore.Encoder().encode(message) else { return }
        
        currentUserRef.setData(messageData)
        chatPartnerRef.document(messageId).setData(messageData)
        
        recentCurrentUserRef.setData(messageData)
        recentPartnerRef.setData(messageData)
    }
    
    func observeMessages(completion: @escaping([Message]) -> Void) {
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
