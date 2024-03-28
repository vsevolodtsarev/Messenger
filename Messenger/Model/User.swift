//
//  User.swift
//  Messenger
//
//  Created by Всеволод Царев on 28.03.2024.
//

import Foundation

struct User: Codable, Hashable {
    var id = UUID().uuidString
    let fullname: String
    let email: String
    let profileImageUrl: String?
}

extension User {
    static let mockUser = User(fullname: "Mock User", email: "mockUserEmail@gmail.com", profileImageUrl: "placeholder")
}
