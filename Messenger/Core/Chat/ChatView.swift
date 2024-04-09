//
//  ChatView.swift
//  Messenger
//
//  Created by Всеволод Царев on 31.03.2024.
//

import SwiftUI

struct ChatView: View {
    @State private var textMessage = ""
    let user: User
    
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
                ForEach(0 ... 15, id: \.self) { message in
                    ChatMessageCell(isFromCurrentUser: Bool.random())
                }
                
            }
            
            //messages input
            ZStack(alignment: .trailing) {
                TextField("Message", text: $textMessage, axis: .vertical)
                    .padding(12)
                    .padding(.trailing, 48)
                    .background(Color(.systemGroupedBackground))
                    .clipShape(Capsule())
                    .font(.subheadline)
                
                Button(action: {
                    print("send message")
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
