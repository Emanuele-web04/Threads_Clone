//
//  ProfileView.swift
//  Threads
//
//  Created by Emanuele Di Pietro on 24/07/24.
//

import SwiftUI

struct ProfileView: View {
    
    
    @State private var following = 903
    @State private var followers = 9.7
    
    let user: User
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            //bio
            VStack(spacing: 20) {
                ProfileHeaderView(user: user) {
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
                
                UserContentListView(user: user)
            }
        }.padding(.horizontal, 10)
    }
    
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(user: dev.user)
    }
}

