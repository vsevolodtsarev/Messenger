//
//  InboxView.swift
//  Messenger
//
//  Created by Всеволод Царев on 23.03.2024.
//

import SwiftUI

struct InboxView: View {
    @AppStorage("userTheme") private var userTheme: Theme = .systemDefault
    @StateObject var viewModel = InboxViewModel()
    @State private var showNewMessage = false
    @State private var selectedUser: User?
    @State private var showChat = false

    private var user: User? {
        viewModel.currentUser
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                ActiveNowView()
                
                List {
                    ForEach(0 ... 10, id: \.self) { message in
                        InboxRowView()
                    }
                }
                .listStyle(PlainListStyle())
                .frame(height: UIScreen.main.bounds.height - 120)
            }
            .onChange(of: selectedUser, perform: { value in
                showChat = value != nil
            })
            .navigationDestination(isPresented: $showChat, destination: {
                if let user = selectedUser {
                    ChatView(user: user)
                }
            })
            .fullScreenCover(isPresented: $showNewMessage, content: {
                NewMessageView(selectedUser: $selectedUser)
            })
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    HStack {
                        NavigationLink(value: user) {
                            ImageProfileView(user: user, size: .small)
                        }
                        .navigationDestination(for: User.self) { user in
                            ProfileView(user: user)
                        }
                        
                        Text("Chats")
                            .font(.title)
                            .fontWeight(.bold)
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        showNewMessage.toggle()
                        selectedUser = nil
                    }, label: {
                        Image(systemName: "square.and.pencil.circle.fill")
                            .resizable()
                            .frame(width: 32, height: 32)
                            .foregroundStyle(userTheme.colorScheme == .light ? Color(.systemGray) : Color(.white))
                    })
                }
            }
        }
        .preferredColorScheme(userTheme.colorScheme)
    }
}

#Preview {
    InboxView()
}
