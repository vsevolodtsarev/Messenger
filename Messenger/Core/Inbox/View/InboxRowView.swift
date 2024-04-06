//
//  InboxRowView.swift
//  Messenger
//
//  Created by Всеволод Царев on 23.03.2024.
//

import SwiftUI

struct InboxRowView: View {
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            ImageProfileView(user: User.mockUser, size: .medium)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(verbatim: "Test Name")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                
                Text(verbatim: "Some last message was here with two lines")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                    .lineLimit(2)
                    .frame(maxWidth: UIScreen.main.bounds.width - 100, alignment: .leading)
            }
            
            HStack {
                Text(verbatim: "Yesterday")
                
                Image(systemName: "chevron.right")
            }
            .font(.footnote)
            .foregroundStyle(.gray)
        }
        .frame(height: 72)
    }
}

#Preview {
    InboxRowView()
}
