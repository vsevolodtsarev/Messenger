//
//  ChatMessageCell.swift
//  Messenger
//
//  Created by Всеволод Царев on 31.03.2024.
//

import SwiftUI

struct ChatMessageCell: View {
    let message: Message
    @AppStorage("userTheme") private var userTheme: Theme = .systemDefault
    
    private var isFromCurrentUser: Bool {
        message.isFromCurrentUser
    }
    
    var body: some View {
        HStack {
            if message.isFromCurrentUser {
                Spacer()
                
                Text(verbatim: message.messageText)
                    .font(.subheadline)
                    .padding(12)
                    .background(Color(.systemBlue))
                    .foregroundStyle(.white)
                    .clipShape(ChatBubble(isFromCurrentUser: isFromCurrentUser))
                    .frame(maxWidth: UIScreen.main.bounds.width / 1.5, alignment: .trailing)
                
            } else {
                HStack(alignment: .bottom, spacing: 8) {
                    ImageProfileView(user: User.mockUser, size: .small)
                    
                    Text(verbatim: message.messageText)
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
