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
            List {
                ActiveNowView()
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets())
                    .padding(.vertical)
                    .padding(.horizontal, 4)
                
                ForEach(viewModel.recentMessages) { message in
                    ZStack {
                        NavigationLink(value: message) {
                            EmptyView()
                        }.opacity(0)
                        
                        InboxRowView(message: message)
                    }
                }
            }
            .listStyle(PlainListStyle())
            .onChange(of: selectedUser, perform: { value in
                showChat = value != nil
            })
            .navigationDestination(for: Message.self, destination: { message in
                if let user = message.user {
                    ChatView(user: user)
                }
            })
            .navigationDestination(for: Route.self, destination: { route in
                switch route {
                case .profile(let user):
                    ProfileView(user: user)
                    
                case .chatView(let user):
                    ChatView(user: user)
                }
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
                        if let user {
                            NavigationLink(value: Route.profile(user)) {
                                ImageProfileView(user: user, size: .small)
                            }
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
