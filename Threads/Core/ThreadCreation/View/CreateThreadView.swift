//
//  CreateThreadView.swift
//  Threads
//
//  Created by Emanuele Di Pietro on 24/07/24.
//

import SwiftUI

struct CreateThreadView: View {
    
    @State private var newPost = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack() {
                    CircularProfileView()
                    
                    TextField("What's happening?", text: $newPost, axis: .vertical)
                }
                Spacer()
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundStyle(.white)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                      
                    } label: {
                        Text("Post")
                        .fontWeight(.semibold)
                        .font(.subheadline)
                        .foregroundStyle(.white)
                        .padding(.vertical, 5)
                        .padding(.horizontal, 15)
                        .background(RoundedRectangle(cornerRadius: 50).fill(.xBlue.opacity(newPost.isEmpty ? 0.5 : 1)))
                    }.disabled(newPost.isEmpty)
                }
            }
        }
    }
}

#Preview {
    CreateThreadView()
}
