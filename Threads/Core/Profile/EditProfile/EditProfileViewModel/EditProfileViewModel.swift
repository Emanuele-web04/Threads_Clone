//
//  EditProfileViewModel.swift
//  Threads
//
//  Created by Emanuele Di Pietro on 25/07/24.
//

import SwiftUI
import PhotosUI

class EditProfileViewModel: ObservableObject {
    @Published var selectedItem: PhotosPickerItem? {
        didSet {
            Task {
                await loadImage()
            }
        }
    }
    
    @Published var profileImage: Image?
    private var uiImage: UIImage?
    
    @MainActor
    func updateUserData(withBio bio: String, link: String) async throws {
        try await updateProfileImage()
        try await UserService.shared.updateUserBio(withBio: bio)
        try await UserService.shared.updateUserLink(withLink: link)
    }
    
    @MainActor
    private func loadImage() async {
        guard let item = selectedItem else { return }
        guard let data = try? await item.loadTransferable(type: Data.self) else { return }
        guard let uiImage = UIImage(data: data) else { return }
        self.uiImage = uiImage
        self.profileImage = Image(uiImage: uiImage)
    }
    
    @MainActor
    private func updateProfileImage() async throws {
        guard let image = self.uiImage else { return }
        guard let imageURL = try? await ImageUploader.uploadImage(image) else { return }
        try await UserService.shared.updateUserProfileImage(withImageURL: imageURL)
    }
}
