//
//  ImageProfileView.swift
//  Messenger
//
//  Created by Всеволод Царев on 29.03.2024.
//

import SwiftUI

enum ImageProfileSize {
    case small
    case medium
    case large
    
    var dimension: CGFloat {
        switch self {
        case .small: 32
        case .medium: 64
        case .large: 80
        }
    }
}

struct ImageProfileView: View {
    let user: User
    let size: ImageProfileSize
    
    var body: some View {
        if let imageUrl = user.profileImageUrl {
            Image(imageUrl)
                .resizable()
                .scaledToFill()
                .frame(width: size.dimension, height: size.dimension)
                .clipShape(Circle())
        } else {
            Image(.placeholder)
                .resizable()
                .scaledToFill()
                .frame(width: size.dimension, height: size.dimension)
                .clipShape(Circle())
        }
    }
}

#Preview {
    ImageProfileView(user: User.mockUser, size: .medium)
}
