//
//  RegistrationViewModel.swift
//  Messenger
//
//  Created by Всеволод Царев on 02.04.2024.
//

import SwiftUI

final class RegistrationViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var fullname = ""
    
    func createUser() async throws {
        try await AuthService.shared.createUser(withEMail: email, password: password, fullname: fullname)
    }
}
