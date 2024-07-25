//
//  CreateThreadView.swift
//  Threads
//
//  Created by Emanuele Di Pietro on 24/07/24.
//

import SwiftUI

struct CreateThreadView: View {
    
    @State private var caption = ""
    @Environment(\.dismiss) var dismiss
    
    @StateObject var vm = CreateThreadViewModel()
    
    private var user: User? {
        return UserService.shared.currentUser
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack() {
                    CircularProfileView(user: user, size: .m)
                    
                    TextField("What's happening?", text: $caption, axis: .vertical)
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
                        Task {
                            try await vm.uploadThread(caption)
                            dismiss()
                        }
                    } label: {
                        Text("Post")
                        .fontWeight(.semibold)
                        .font(.subheadline)
                        .foregroundStyle(.white)
                        .padding(.vertical, 5)
                        .padding(.horizontal, 15)
                        .background(RoundedRectangle(cornerRadius: 50).fill(.xBlue.opacity(caption.isEmpty ? 0.5 : 1)))
                    }.disabled(caption.isEmpty)
                }
            }
        }
    }
}

struct CreateThreadView_Previews: PreviewProvider {
    static var previews: some View {
        CreateThreadView()
    }
}
