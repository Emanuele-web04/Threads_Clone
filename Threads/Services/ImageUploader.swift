//
//  ImageUploader.swift
//  Threads
//
//  Created by Emanuele Di Pietro on 25/07/24.
//

import Foundation
import Firebase
import FirebaseStorage

// struct because you need to create a copy for every image uploading
struct ImageUploader {
    static func uploadImage(_ image: UIImage) async throws -> String? {
        guard let imageData = image.jpegData(compressionQuality: 0.1) else { return nil }
        let filename = UUID().uuidString
        let storageRef = Storage.storage().reference(withPath: "/profile_images/\(filename)")
        
        do {
            let _ = try await storageRef.putDataAsync(imageData)
            let url = try await storageRef.downloadURL()
            return url.absoluteString
        } catch {
            print("DEBUG: Failed to upload image with error: \(error.localizedDescription)")
            return nil
        }
    }
}
