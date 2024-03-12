//
//  LoginView.swift
//  Messenger
//
//  Created by Всеволод Царев on 12.03.2024.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    
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
                TextField("Enter your email", text: $email)
                    .font(.subheadline)
                    .padding(12)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal, 20)
                
                SecureField("Enter your password", text: $password)
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
                    print("login tap")
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
                        print("login with hoogle")
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
                    Text("Sign Up")
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
    }
}

#Preview {
    LoginView()
}
