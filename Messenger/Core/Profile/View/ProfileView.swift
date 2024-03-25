//
//  ProfileView.swift
//  Messenger
//
//  Created by Всеволод Царев on 25.03.2024.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        VStack {
            //header
            VStack {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .foregroundStyle(Color(.systemGray4))
                
                Text(verbatim: "User Name")
                    .font(.title2)
                    .fontWeight(.semibold)
            }
            
            //list
            List {
                Section {
                    ForEach(SettingsOptionsModel.allCases) { option in
                        HStack {
                            Image(systemName: option.imageName)
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundStyle(option.imageColor)
                            
                            Text(option.title)
                                .font(.subheadline)
                        }
                    }
                }
                
                Section {
                    Button("Log Out") {
                        print("log out")
                    }
                    
                    Button("Delete Account") {
                        print("delete account")
                    }
                }
                .foregroundStyle(.red)
            }
        }
    }
}

#Preview {
    ProfileView()
}
