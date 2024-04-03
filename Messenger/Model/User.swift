//
//  User.swift
//  Messenger
//
//  Created by Всеволод Царев on 28.03.2024.
//

import Foundation
import FirebaseFirestoreSwift

struct User: Codable, Hashable {
    @DocumentID var uid: String?
    let fullname: String
    let email: String
    let profileImageUrl: String?
    
    var id: String {
        return uid ?? UUID().uuidString
    }
}

extension User {
    static let mockUser = User(fullname: "Mock User", email: "mockUserEmail@gmail.com", profileImageUrl: "placeholder")
}
