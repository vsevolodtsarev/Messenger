//
//  ContentViewModel.swift
//  Messenger
//
//  Created by Всеволод Царев on 02.04.2024.
//

import Firebase
import Combine

final class ContentViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setupSubscribers()
    }
    
    private func setupSubscribers() {
        AuthService.shared.$userSession.sink { [weak self] userSessionFromAuthService in
            guard let self else { return }
            self.userSession = userSessionFromAuthService
        }.store(in: &cancellables)
    }
}
