//
//  AuthService.swift
//  Messenger
//
//  Created by Всеволод Царев on 02.04.2024.
//

import Firebase

final class AuthService {
    @Published var userSession: FirebaseAuth.User?
    
    static let shared = AuthService()
    
    init() {
        userSession = Auth.auth().currentUser
        print("User session with user id \(userSession?.uid)")
    }
    
    func login(withEMail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            userSession = result.user
        } catch {
            print("Failed to sign in with error: \(error.localizedDescription)")
        }
    }
    
    func login(withGoogle email: String) async throws {
        print("login with google")
    }
    
    func createUser(withEMail email: String, password: String, fullname: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            userSession = result.user
            print("Create user: \(result.user.uid)")
        } catch {
            print("Failed to create user with error: \(error.localizedDescription)")
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            userSession = nil
        } catch {
            print("Failed to Sign out with errje: \(error.localizedDescription)")
        }
    }
}
