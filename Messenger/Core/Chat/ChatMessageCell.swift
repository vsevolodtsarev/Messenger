//
//  ChatMessageCell.swift
//  Messenger
//
//  Created by Всеволод Царев on 31.03.2024.
//

import SwiftUI

struct ChatMessageCell: View {
    let isFromCurrentUser: Bool
    @AppStorage("userTheme") private var userTheme: Theme = .systemDefault
    
    var body: some View {
        HStack {
            if isFromCurrentUser {
                Spacer()
                
                Text(verbatim: "This is a text message from current user")
                    .font(.subheadline)
                    .padding(12)
                    .background(Color(.systemBlue))
                    .foregroundStyle(.white)
                    .clipShape(ChatBubble(isFromCurrentUser: isFromCurrentUser))
                    .frame(maxWidth: UIScreen.main.bounds.width / 1.5, alignment: .trailing)
                
            } else {
                HStack(alignment: .bottom, spacing: 8) {
                    ImageProfileView(user: User.mockUser, size: .small)
                    
                    Text(verbatim: "This is a text message from another user")
                        .font(.subheadline)
                        .padding(12)
                        .background(userTheme.colorScheme == .light ? Color(.systemGray5) : .white)
                        .foregroundStyle(.black)
                        .clipShape(ChatBubble(isFromCurrentUser: isFromCurrentUser))
                        .frame(maxWidth: UIScreen.main.bounds.width / 1.75, alignment: .leading)
                    
                    Spacer()
                }
            }
        }
        .padding(.horizontal, 8)
    }
}

#Preview {
    ChatMessageCell(isFromCurrentUser: false)
}
