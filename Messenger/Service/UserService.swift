//
//  UserService.swift
//  Messenger
//
//  Created by Всеволод Царев on 03.04.2024.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

final class UserService {
    @Published var currentUser: User?
    static let shared = UserService()
    
    @MainActor
    func fetchCurrentUser() async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
        let user = try snapshot.data(as: User.self)
        currentUser = user
    }
    
    static func fetchAllUsers() async throws -> [User] {
        let snapshot = try await Firestore.firestore().collection("users").getDocuments()
        guard let currentUid = Auth.auth().currentUser?.uid else { return [] }
        let users = snapshot.documents.compactMap({ try? $0.data(as: User.self) })
        return users.filter({ $0.uid != currentUid })
    }
}
