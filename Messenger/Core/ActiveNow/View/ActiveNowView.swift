//
//  ActiveNowView.swift
//  Messenger
//
//  Created by Всеволод Царев on 23.03.2024.
//

import SwiftUI

struct ActiveNowView: View {
    @StateObject private var viewModel = ActiveNowViewModel()
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 32) {
                ForEach(viewModel.users) { user in
                    VStack {
                        ZStack(alignment: .bottomTrailing) {
                            ImageProfileView(user: user, size: .medium)
                            
                            ZStack {
                                Circle()
                                    .fill(.white)
                                    .frame(width: 18, height: 18)
                                
                                Circle()
                                    .fill(.green)
                                    .frame(width: 12, height: 12)
                            }
                        }
                        
                        Text(verbatim: user.fullname)
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                    }
                }
            }
            .padding()
        }
        .frame(height: 105)
    }
}

#Preview {
    ActiveNowView()
}
