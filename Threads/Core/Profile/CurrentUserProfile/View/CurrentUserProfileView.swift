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
                    UserContentListView()
                }
            }.padding(.horizontal, 10)
                .sheet(isPresented: $showEditProfile, content: {
                    if let user = currentUser {
                        EditProfileView(user: user).presentationBackground(.black)
                    }
                })
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            AuthService.shared.signOut()
                        } label: {
                            Image(systemName: "arrow.right.to.line.alt").imageScale(.small).padding(10).foregroundStyle(.red)
                                .background(Circle().stroke(Color(.red)))
                        }
                    }
                }
        }
    }
}

#Preview {
    CurrentUserProfileView()
}
