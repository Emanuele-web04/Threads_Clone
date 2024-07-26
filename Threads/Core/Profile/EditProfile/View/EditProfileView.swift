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
    @State private var isVerified = false
    
    @Environment(\.dismiss) var dismiss
    @StateObject var vm = EditProfileViewModel()
    
    let user: User
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                Rectangle().frame(height: 0.5).foregroundStyle(.gray.opacity(0.3))
                VStack(spacing: 60) {
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
                    }.padding(.top)
                    
                    VStack(spacing: 20) {
                        Divider()
                        HStack() {
                            HStack(spacing: 40) {
                                Text("Name")
                                    .frame(width: 60, alignment: .leading)
                                    .fontWeight(.semibold)
                                Text(user.fullname).foregroundStyle(.xBlue)
                            }
                            Spacer()
                        }
                        Divider()
                        
                        HStack(spacing: 40) {
                            Text("Bio")
                                .frame(width: 60, alignment: .leading)
                                .fontWeight(.semibold)
                            TextField("Add a bio to your profile", text: $bio, axis: .vertical)
                        }.frame(height: 60, alignment: .top)
                        
                        
                        Divider()
                        
                        HStack(spacing: 40) {
                            Text("Website")
                                .frame(width: 60, alignment: .leading)
                                .fontWeight(.semibold)
                            TextField("Add link", text: $link)
                        }
                        
                        Divider()
                        
                        Toggle(isOn: $isVerified) {
                            Text("Verified Account")
                                .fontWeight(.semibold)
                        }.tint(.xBlue)
                        
                    }.padding()
                        .font(.subheadline)
                    
                }
            }
            Spacer()
            
            .font(.footnote)
            .onAppear {
                if let userBio = user.bio, let userLink = user.link {
                    bio = userBio
                    link = userLink
                    isVerified = user.isVerified
                    print(isVerified)
                }
            }
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
                            try await vm.updateUserData(withBio: bio, link: link)
                            try await vm.updateVerificationStatus(withVerified: isVerified)
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
