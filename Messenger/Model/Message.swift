//
//  Message.swift
//  Messenger
//
//  Created by Всеволод Царев on 12.04.2024.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct Message: Identifiable, Hashable, Codable {
    @DocumentID var messageId: String?
    var user: User?
    let fromId: String
    let toId: String
    let messageText: String
    let timestamp: Timestamp

    var id: String {
        messageId ?? UUID().uuidString
    }
    
    var chatPartnerId: String {
        fromId == Auth.auth().currentUser?.uid ? toId : fromId
    }
    
    var isFromCurrentUser: Bool {
        fromId == Auth.auth().currentUser?.uid
    }
}
