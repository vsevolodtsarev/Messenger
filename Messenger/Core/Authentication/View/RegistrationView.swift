//
//  RegistrationView.swift
//  Messenger
//
//  Created by Всеволод Царев on 19.03.2024.
//

import SwiftUI

struct RegistrationView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel = RegistrationViewModel()
    
    var body: some View {
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
            
            TextField("Enter your fullname", text: $viewModel.fullname)
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
            
            //sign up button
            Button(action: {
                Task { try await viewModel.createUser() }
            }, label: {
                Text("Sign Up")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .frame(width: 360, height: 44)
                    .background(.blue)
                    .cornerRadius(10)
            })
            
            Spacer()
            
            //dismiss block
            Divider()
            Button {
                dismiss()
            } label: {
                HStack(spacing: 3) {
                    Text("Already have an account?")
                    
                    Text("Sign In")
                        .fontWeight(.semibold)
                }
                .font(.footnote)
            }
            .padding(.vertical)
        }
    }
}

#Preview {
    RegistrationView()
}
