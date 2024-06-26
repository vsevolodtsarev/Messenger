//
//  LoginView.swift
//  Messenger
//
//  Created by Всеволод Царев on 12.03.2024.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    @AppStorage("userTheme") private var userTheme: Theme = .systemDefault
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                //logo image
                Image(.logoMain)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 150)
                    .padding()
                
                //textfields
                TextField("Enter your email", text: $viewModel.email)
                    .font(.subheadline)
                    .padding(12)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal, 20)
                
                SecureField("Enter your password", text: $viewModel.password)
                    .font(.subheadline)
                    .padding(12)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal, 20)
                
                //forgot password
                NavigationLink {
                    Text("Reset password")
                } label: {
                    Text("Forgot Password?")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .padding(.top)
                        .padding(.trailing, 28)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                
                //login button
                Button(action: {
                    Task { try await viewModel.loginWithEmail() }
                }, label: {
                    Text("Login")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .frame(width: 360, height: 44)
                        .background(.blue)
                        .cornerRadius(10)
                })
                .padding(.vertical)

                //separator
                HStack {
                    Rectangle()
                        .frame(width: (UIScreen.main.bounds.width / 2) - 40, height: 0.5)
                    
                    Text("OR")
                        .font(.footnote)
                        .fontWeight(.semibold)
                    
                    Rectangle()
                        .frame(width: (UIScreen.main.bounds.width / 2) - 40, height: 0.5)
                }
                .foregroundStyle(.gray)
                
                //sign with google
                HStack(spacing: 0) {
                    Image(.logoGoogle)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 30, height: 30)
                    
                    Button(action: {
                        Task { try await viewModel.loginWithGoogle() }
                    }, label: {
                        Text("Continue with Google")
                            .font(.footnote)
                            .fontWeight(.semibold)
                        
                    })
                }
                
                Spacer()
                
                //sign up link
                Divider()
                NavigationLink {
                    RegistrationView()
                        .navigationBarBackButtonHidden()
                } label: {
                    HStack(spacing: 3) {
                        Text("Don't have an account?")
                        
                        Text("Sign Up")
                            .fontWeight(.semibold)
                    }
                    .font(.footnote)
                }
                .padding(.vertical)
            }
        }
        .preferredColorScheme(userTheme.colorScheme)
    }
}

#Preview {
    LoginView()
}
