//
//  CurrentUserProfileView.swift
//  Threads
//
//  Created by Emanuele Di Pietro on 25/07/24.
//

import SwiftUI

struct CurrentUserProfileView: View {
    
    @StateObject var vm = CurrentUserProfileViewModel()
    @State private var showEditProfile = false
    private var currentUser: User? {
        return vm.currentUser
    }
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                Rectangle()
                    .fill(.xBlue)
                    .frame(height: 116)
                    .ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    //bio
                    VStack(spacing: 20) {
                        ProfileHeaderView(user: currentUser) {
                            Button {
                                showEditProfile.toggle()
                            } label: {
                                Text("Edit Profile")
                                    .font(.footnote)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.white)
                                    .frame(maxWidth: 90)
                                    .padding(6)
                                    .background(RoundedRectangle(cornerRadius: 50).stroke(.gray, lineWidth: 0.5))
                            }
                        }
                        if let user = currentUser {
                           UserContentListView(user: user)
                        } else {
                            ProgressView()
                        }
                    }
                }.padding(10)
                    .padding(.top, 15)
                    .sheet(isPresented: $showEditProfile, content: {
                        if let user = currentUser {
                            EditProfileView(user: user).presentationBackground(.black)
                        }
                    })
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            Menu {
                                Button(role: .destructive) {
                                    AuthService.shared.signOut()
                                } label: {
                                    Label("Logout", systemImage: "arrow.right.to.line.alt")
                                }
                                Button(role: .destructive) {
                                    Task {
                                       try await AuthService.shared.deleteAccount()
                                    }
                                } label: {
                                    Label("Delete Account", systemImage: "xmark.bin")
                                }
                            } label: {
                                Image(systemName: "ellipsis").rotationEffect(.degrees(90)).imageScale(.medium)
                            }
                        }
                    }
            }
        }
    }
}

#Preview {
    CurrentUserProfileView()
}
