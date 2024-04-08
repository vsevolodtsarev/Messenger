//
//  AuthService.swift
//  Messenger
//
//  Created by Всеволод Царев on 02.04.2024.
//

import Firebase
import FirebaseFirestoreSwift

final class AuthService {
    @Published var userSession: FirebaseAuth.User?
    
    static let shared = AuthService()
    
    init() {
        userSession = Auth.auth().currentUser
        loadCurrentUserData()
    }
    
    @MainActor
    func login(withEMail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            userSession = result.user
            loadCurrentUserData()
        } catch {
            print("Failed to sign in with error: \(error.localizedDescription)")
        }
    }
    
    func login(withGoogle email: String) async throws {
        print("login with google")
    }
    
    @MainActor
    func createUser(withEMail email: String, password: String, fullname: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            userSession = result.user
            try await uploadUserData(email: email, fullname: fullname, id: result.user.uid)
            loadCurrentUserData()
        } catch {
            print("Failed to create user with error: \(error.localizedDescription)")
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            userSession = nil
            UserService.shared.currentUser = nil
        } catch {
            print("Failed to Sign out with errje: \(error.localizedDescription)")
        }
    }
    
    private func uploadUserData(email: String, fullname: String, id: String) async throws {
        let user = User(fullname: fullname, email: email, profileImageUrl: nil)
        guard let encodedUser = try? Firestore.Encoder().encode(user) else { return }
        try await Firestore.firestore().collection("users").document(id).setData(encodedUser)
    }
    
    private func loadCurrentUserData() {
        Task { try await UserService.shared.fetchCurrentUser() }
    }
}
