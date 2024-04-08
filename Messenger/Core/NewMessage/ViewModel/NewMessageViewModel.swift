//
//  NewMessageViewModel.swift
//  Messenger
//
//  Created by Всеволод Царев on 08.04.2024.
//

import Foundation

final class NewMessageViewModel: ObservableObject {
    @Published var users = [User]()
    
    init() {
        Task { try await fetchUsers() }
    }
    
    @MainActor
    func fetchUsers() async throws {
        users = try await UserService.fetchAllUsers()
    }
}
