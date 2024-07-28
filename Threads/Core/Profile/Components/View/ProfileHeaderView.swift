//
//  ProfileHeaderView.swift
//  Threads
//
//  Created by Emanuele Di Pietro on 25/07/24.
//

import SwiftUI

struct ProfileHeaderView<Content: View>: View {
    
    var user: User?
    let button: Content
    
    init(user: User?, @ViewBuilder button: () -> Content) {
        self.user = user
        self.button = button()
    }
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 25) {
                // Full name
                HStack {
                    
                    VStack(alignment: .leading, spacing: 8) {
                        CircularProfileView(user: user, size: .xl)
                        
                        if let user {
                            HStack {
                                Text(user.fullname)
                                    .font(.title2)
                                    .fontWeight(.bold)
                                if user.isVerified {
                                    Image(systemName: "checkmark.seal.fill")
                                        .foregroundStyle(.white, .xBlue).imageScale(.medium)
                                }
                            }
                            Text("@" + "\(user.username)")
                                .foregroundStyle(.gray)
                                .font(.subheadline)
                        } else {
                            ProgressView()
                        }
                    }
                    Spacer()
                    button
                }
                VStack(alignment: .leading, spacing: 8) {
                    if let bio = user?.bio {
                        Text(bio)
                            .font(.subheadline)
                    }
                    if let link = user?.link, let validURL = URL(string: link) {
                        Link(destination: validURL, label: {
                            Text(link)
                                .font(.subheadline)
                                .foregroundStyle(.xBlue)
                        })
                    }
                }
                HStack(spacing: 10) {
                    HStack(spacing: 3) {
                        Text("903").fontWeight(.semibold)
                        Text("Following").foregroundStyle(.gray)
                    }
                    HStack(spacing: 3) {
                        Text("9,7M").fontWeight(.semibold)
                        Text("Followers").foregroundStyle(.gray)
                            .foregroundStyle(.gray)
                    }
                }.font(.footnote)
                
            }
            Spacer(minLength: 0)
        }
    }
}

struct ProfileHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHeaderView(user: dev.user) {
            Button(action: {
                // Action for follow button
            }) {
                Text("Follow")
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
                    .frame(maxWidth: 90)
                    .padding(6)
                    .background(RoundedRectangle(cornerRadius: 50).fill(.white))
            }
        }
    }
}
