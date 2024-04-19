//
//  InboxService.swift
//  Messenger
//
//  Created by Всеволод Царев on 19.04.2024.
//

import Foundation
import Firebase

final class InboxService {
    @Published var documentChanges = [DocumentChange]()
    let messageCollection = Firestore.firestore().collection("messages")
    
    func observeRecentMessages() {
        guard let currentUserUid = Auth.auth().currentUser?.uid else { return }
        
        let query = messageCollection.document(currentUserUid).collection("recent-messages").order(by: "timestamp", descending: true)
        
        query.addSnapshotListener { [weak self] snapshot, _ in
            guard let self else { return }
            guard let changes = snapshot?.documentChanges.filter({
                $0.type == .added || $0.type == .modified
            }) else { return }
            
            self.documentChanges = changes
        }
    }
}
