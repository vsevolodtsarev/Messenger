//
//  LoginViewModel.swift
//  Messenger
//
//  Created by Всеволод Царев on 02.04.2024.
//

import SwiftUI

final class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    
    func loginWithEmail() async throws {
        try await AuthService.shared.login(withEMail: email, password: password)
    }
    
    func loginWithGoogle() async throws {
        try await AuthService.shared.login(withGoogle: "testGoggleAccount.gmail.com")
    }
}
