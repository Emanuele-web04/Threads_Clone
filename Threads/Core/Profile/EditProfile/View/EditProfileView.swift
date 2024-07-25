//
//  EditProfileView.swift
//  Threads
//
//  Created by Emanuele Di Pietro on 24/07/24.
//

import SwiftUI
import PhotosUI

struct EditProfileView: View {
    
    @State private var bio = ""
    @State private var link = ""
    @State private var isPrivateProfile = false
    
    @Environment(\.dismiss) var dismiss
    @StateObject var vm = EditProfileViewModel()
    
    let user: User
    
    var body: some View {
        NavigationStack {
            VStack {
                
                PhotosPicker(selection: $vm.selectedItem) {
                    if let image = vm.profileImage {
                        VStack(spacing: 10) {
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 64, height: 64)
                                .clipShape(Circle())
                            textButtonProfileImage
                        }
                    } else {
                        VStack(spacing: 10) {
                            CircularProfileView(user: user, size: .l)
                                .foregroundStyle(.white)
                            textButtonProfileImage
                        }
                    }
                }
                Spacer()
                VStack(spacing: 20) {
                    HStack() {
                        HStack(spacing: 40) {
                            Text("Name")
                                .frame(width: 50, alignment: .leading)
                                .fontWeight(.semibold)
                            Text(user.fullname).foregroundStyle(.xBlue)
                        }
                        Spacer()
                    }
                    Divider()
                    
                    HStack(spacing: 40) {
                        Text("Bio")
                            .frame(width: 50, alignment: .leading)
                            .fontWeight(.semibold)
                        TextField("Enter your Bio", text: $bio, axis: .vertical)
                    }
                    
                    
                    Divider()
                    
                    HStack(spacing: 40) {
                        Text("Link")
                            .frame(width: 50, alignment: .leading)
                            .fontWeight(.semibold)
                        TextField("Add link", text: $link)
                    }
                    
                    
                    Divider()
                    
                    Toggle("Private Profile", isOn: $isPrivateProfile)
                    
                }.padding()
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(.systemGray4))
                }
                Spacer()
            }
            .padding()
            .font(.footnote)
            
            
            
            .navigationTitle("Edit Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundStyle(.white)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        Task {
                            try await vm.updateUserData()
                            dismiss()
                        }
                    }
                    .foregroundStyle(.white)
                    .fontWeight(.semibold)
                }
            }
        }
    }
    
    private var textButtonProfileImage: some View {
        Text("Edit")
            .font(.footnote)
            .fontWeight(.semibold)
            .foregroundStyle(.white)
            .frame(maxWidth: 70)
            .padding(6)
            .background(RoundedRectangle(cornerRadius: 50).stroke(Color(.systemGray4), lineWidth: 1.5))
    }
}

struct EditProfileView_Preview: PreviewProvider {
    static var previews: some View {
        EditProfileView(user: dev.user)
    }
}
