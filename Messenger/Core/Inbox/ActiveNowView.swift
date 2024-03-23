//
//  ActiveNowView.swift
//  Messenger
//
//  Created by Всеволод Царев on 23.03.2024.
//

import SwiftUI

struct ActiveNowView: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 32) {
                ForEach(0 ... 10, id: \.self) { user in
                    VStack {
                        ZStack(alignment: .bottomTrailing) {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .frame(width: 64, height: 64)
                                .foregroundStyle(Color(.systemGray4))
                            
                            ZStack {
                                Circle()
                                    .fill(.white)
                                    .frame(width: 18, height: 18)
                                
                                Circle()
                                    .fill(.green)
                                    .frame(width: 12, height: 12)
                            }
                        }
                        
                        Text(verbatim: "Name")
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
