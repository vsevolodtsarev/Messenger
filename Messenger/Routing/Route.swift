//
//  Route.swift
//  Messenger
//
//  Created by Всеволод Царев on 29.04.2024.
//

import Foundation

enum Route: Hashable {
    case profile(User)
    case chatView(User)
}
