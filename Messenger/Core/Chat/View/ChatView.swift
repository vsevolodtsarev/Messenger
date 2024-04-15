//
//  ChatView.swift
//  Messenger
//
//  Created by Всеволод Царев on 31.03.2024.
//

import SwiftUI

struct ChatView: View {
    let user: User
    @StateObject private var viewModel: ChatViewModel
    
    init(user: User) {
        self.user = user
        self._viewModel = StateObject(wrappedValue: ChatViewModel(user: user))
    }
    
    var body: some View {
        VStack {
            ScrollView {
                // header
                VStack {
                    ImageProfileView(user: user, size: .large)
                    
                    VStack(spacing: 4) {
                        Text(verbatim: user.fullname)
                            .font(.title3)
                            .fontWeight(.semibold)
                    }
                    
                    Text(verbatim: "Messenger")
                        .font(.footnote)
                        .foregroundStyle(.gray)
                }
                
                // messages
                ForEach(viewModel.messages) { message in
                    ChatMessageCell(message: message)
                }
                
            }
            
            //messages input
            ZStack(alignment: .trailing) {
                TextField("Message", text: $viewModel.messageText, axis: .vertical)
                    .padding(12)
                    .padding(.trailing, 48)
                    .background(Color(.systemGroupedBackground))
                    .clipShape(Capsule())
                    .font(.subheadline)
                
                Button(action: {
                    viewModel.sendMessage()
                    viewModel.messageText = ""
                }, label: {
                    Text("Send")
                        .fontWeight(.semibold)
                })
                .padding(.horizontal)
            }
            .padding()
        }
    }
}

#Preview {
    ChatView(user: User.mockUser)
}
