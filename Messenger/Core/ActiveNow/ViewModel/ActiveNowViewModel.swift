//
//  ActiveNowViewModel.swift
//  Messenger
//
//  Created by Всеволод Царев on 29.04.2024.
//

import Foundation

final class ActiveNowViewModel: ObservableObject {
    @Published var users = [User]()
    
    init() {
        Task { try await fetchUsers() }
    }
    
    @MainActor
    func fetchUsers() async throws {
        users = try await UserService.fetchAllUsers()
    }
}
