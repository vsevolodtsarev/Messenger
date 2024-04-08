//
//  ProfileView.swift
//  Messenger
//
//  Created by Всеволод Царев on 25.03.2024.
//

import SwiftUI
import PhotosUI

struct ProfileView: View {
    @Environment(\.colorScheme) private var scheme
    @StateObject var viewModel = ProfileViewModel()
    @AppStorage("userTheme") private var userTheme: Theme = .systemDefault
    @State private var changeTheme = false
    let user: User
    
    var body: some View {
        VStack {
            //header
            VStack {
                PhotosPicker(selection: $viewModel.selectedItem) {
                    if let profileImage = viewModel.profileImage {
                        profileImage
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                        
                    } else {
                        ImageProfileView(user: user, size: .large)
                    }
                }
                
                Text(verbatim: user.fullname)
                    .font(.title2)
                    .fontWeight(.semibold)
            }
            
            //list
            
            List {
                Section {
                    ForEach(SettingsOptions.allCases) { option in
                        Button(action: {
                            if option == .darkMode {
                                changeTheme.toggle()
                            }
                        }, label: {
                            HStack {
                                Image(systemName: option.imageName)
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                    .foregroundStyle(option.imageColor)
                                
                                Text(option.title)
                                    .font(.subheadline)
                            }
                        })
                        .foregroundStyle(.foreground)
                    }
                }
                
                Section {
                    Button("Log Out") {
                        AuthService.shared.signOut()
                    }
                    
                    Button("Delete Account") {
                        print("delete account")
                    }
                }
                .foregroundStyle(.red)
            }
        }
        .preferredColorScheme(userTheme.colorScheme)
        .sheet(isPresented: $changeTheme, content: {
            ThemeChangeView(scheme: scheme)
                .presentationDetents([.height(410)])
                .presentationBackground(.clear)
        })
    }
    
}

#Preview {
    ProfileView(user: User.mockUser)
}
