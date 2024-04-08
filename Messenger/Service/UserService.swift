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
}
