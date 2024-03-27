//
//  ProfileViewModel.swift
//  Messenger
//
//  Created by Всеволод Царев on 27.03.2024.
//

import SwiftUI
import PhotosUI

final class ProfileViewModel: ObservableObject {
    @Published var profileImage: Image?
    @Published var selectedItem: PhotosPickerItem? {
        didSet {
            Task { try await loadImage() }
        }
    }
    
    func loadImage() async throws {
        guard let item = selectedItem else { return }
        guard let imageData = try await item.loadTransferable(type: Data.self) else { return }
        guard let uiImage = UIImage(data: imageData) else { return }
        
        profileImage = Image(uiImage: uiImage)
    }
}
