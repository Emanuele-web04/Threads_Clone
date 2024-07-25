//
//  UserCell.swift
//  Threads
//
//  Created by Emanuele Di Pietro on 24/07/24.
//

import SwiftUI

struct UserCell: View {
    
    let user: User
    
    var body: some View {
        HStack {
            CircularProfileView(user: user, size: .s)
            
            VStack(alignment: .leading) {
                Text(user.fullname)
                    
                    .fontWeight(.semibold)
                Text("@" + "\(user.username)").foregroundStyle(.gray)
                    
                    .multilineTextAlignment(.center)
            }.font(.subheadline)
            
            Spacer()
            
            Text("Follow")
                .font(.footnote)
                .fontWeight(.semibold)
                .frame(width: 90, height: 32)
                .overlay {
                    RoundedRectangle(cornerRadius: 50)
                        .stroke(Color(.systemGray4), lineWidth: 1)
                }
            
        }
        .padding(.horizontal)
        .padding(.vertical, 5)
    }
}


struct UserCell_Previews: PreviewProvider {
    static var previews: some View {
        UserCell(user: dev.user)
    } 
}
