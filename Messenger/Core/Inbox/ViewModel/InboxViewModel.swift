//
//  InboxViewModel.swift
//  Messenger
//
//  Created by Всеволод Царев on 06.04.2024.
//

import Foundation
import Combine
import Firebase

final class InboxViewModel: ObservableObject {
    @Published var currentUser: User?
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setupSubscribers()
    }
    
    private func setupSubscribers() {
        UserService.shared.$currentUser.sink { [weak self] user in
            guard let self else { return }
            self.currentUser = user
        }.store(in: &cancellables)
    }
}
