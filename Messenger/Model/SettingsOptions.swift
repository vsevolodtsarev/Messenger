//
//  SettingsOptions.swift
//  Messenger
//
//  Created by Всеволод Царев on 25.03.2024.
//

import Foundation
import SwiftUI

enum SettingsOptions: Int, CaseIterable, Identifiable {
    var id: Int { return self.rawValue }
    
    case darkMode
    case activeStatus
    case accessibility
    case privacy
    case notifications
    
    var title: LocalizedStringKey {
        switch self {
        case .darkMode:
            "Dark Mode"
        case .activeStatus:
            "Active Status"
        case .accessibility:
            "Accessibility"
        case .privacy:
            "Privacy"
        case .notifications:
            "Notifications"
        }
    }
    
    var imageName: String {
        switch self {
        case .darkMode:
            return "moon.circle.fill"
        case .activeStatus:
            return "message.badge.circle.fill"
        case .accessibility:
            return "person.circle.fill"
        case .privacy:
            return "lock.circle.fill"
        case .notifications:
            return "bell.circle.fill"
        }
    }
    
    var imageColor: Color {
        switch self {
            
        case .darkMode:
                .orange
        case .activeStatus:
                .green
        case .accessibility:
                .cyan
        case .privacy:
                .blue
        case .notifications:
                .purple
        }
    }
}
