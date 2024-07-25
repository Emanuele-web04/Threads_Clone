//
//  UserCell.swift
//  Threads
//
//  Created by Emanuele Di Pietro on 24/07/24.
//

import SwiftUI

struct UserCell: View {
    var body: some View {
        HStack {
           CircularProfileView()
            
            VStack(alignment: .leading) {
                Text("maxverstappen1")
                    
                    .fontWeight(.semibold)
                Text("Max Verstappen")
                    
                    .multilineTextAlignment(.center)
            }.font(.footnote)
            
            Spacer()
            
            Text("Follow")
                .font(.subheadline)
                .fontWeight(.semibold)
                .frame(width: 100, height: 32)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(.systemGray4), lineWidth: 1)
                }
            
        }
        .padding(.horizontal)
    }
}

#Preview {
    UserCell()
}
