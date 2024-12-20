//
//  ThreadCell.swift
//  Threads
//
//  Created by Emanuele Di Pietro on 24/07/24.
//

import SwiftUI
import Firebase
import FirebaseStorage

struct ThreadCell: View {
    
    let thread: Thread
    @StateObject var vm = ThreadCellViewModel()
    
    let user: User?
    
    var onUpdate: (Thread) -> ()
    var onDelete: () -> ()
    
    @State private var docListener: ListenerRegistration?
    
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 12) {
                if thread.ownerUid != user?.id {
                    NavigationLink {
                        if let user = thread.user {
                            ProfileView(user: user)
                        }
                    } label: {
                        CircularProfileView(user: thread.user, size: .s)
                    }
                } else {
                    CircularProfileView(user: thread.user, size: .s)
                }
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(thread.user?.fullname ?? "")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        if let isVerified = thread.user?.isVerified {
                            if isVerified {
                                Image(systemName: "checkmark.seal.fill")
                                    .foregroundStyle(.xBlue).imageScale(.small)
                            }
                        }
                        Text("•").padding(.bottom, 3)
                            .foregroundStyle(Color(.systemGray2))
                        Text(thread.timestamp.toString())
                            .font(.footnote)
                            .foregroundStyle(Color(.systemGray2))
                        Spacer()
                        Menu {
                            if thread.ownerUid == user?.id {
                                Button(role: .destructive) {
                                    Task {
                                        try await ThreadService.deleteThread(thread)
                                    }
                                } label: {
                                    Label("Delete Post", systemImage: "trash")
                                }
                            }
                        } label: {
                            Image(systemName: "ellipsis")
                                .foregroundStyle(Color(.darkGray))
                        }
                    }
                    
                    Text(thread.caption)
                        .font(.subheadline)
                        .multilineTextAlignment(.leading)
                    
                    HStack {
                        Button {
                            
                        } label: {
                            Image(systemName: "bubble.left").imageScale(.small)
                        }
                        Spacer()
                        Button {
                            
                        } label: {
                            Image(systemName: "arrow.2.squarepath").imageScale(.small)
                        }
                        Spacer()
                        Button {
                            Task {
                                try await vm.likeThread(thread)
                            }
                        } label: {
                            if let uid = UserService.shared.currentUser?.id {
                                Image(systemName: thread.likedIDs.contains(uid) ? "heart.fill" : "heart").imageScale(.small)
                                    .foregroundStyle(thread.likedIDs.contains(uid) ? .red : .gray)
                                Text("\(thread.likes)").font(.footnote)
                            }
                        }
                        Spacer()
                        Button {
                            
                        } label: {
                            Image(systemName: "text.alignright").rotationEffect(.degrees(90)).imageScale(.small)
                        }
                        Spacer()
                        Button {
                            Task {
                                try await vm.bookmarkThread(thread)
                            }
                        } label: {
                            if let uid = UserService.shared.currentUser?.id {
                                Image(systemName: thread.bookmarkIDs.contains(uid) ? "bookmark.fill" : "bookmark")
                                    .resizable().frame(width: 10, height: 13)
                                    .foregroundStyle(thread.bookmarkIDs.contains(uid) ? .xBlue : .gray)
                            }
                        }
                        Spacer()
                        Button {
                            
                        } label: {
                            Image(systemName: "arrow.up.circle").imageScale(.small)
                        }
                        
                    }.foregroundStyle(.gray).padding(.vertical, 10)
                }
            }
            Divider()
                .frame(width: 400)
        }.padding(.horizontal)
            .padding(.vertical, 6)
            .onAppear {
                if docListener == nil {
                    guard let threadID = thread.threadID else { return }
                    docListener = Firestore.firestore().collection("threads").document(threadID).addSnapshotListener({ snapshot, error in
                        if let snapshot {
                            if snapshot.exists {
                                if let updatedPost = try? snapshot.data(as: Thread.self) {
                                    onUpdate(updatedPost)
                                }
                            } else {
                                onDelete()
                            }
                        }
                    })
                }
            }
            .onDisappear {
                if let docListener {
                    docListener.remove()
                    self.docListener = nil
                }
            }
    }
}

struct ThreadCell_Previews: PreviewProvider {
    static var previews: some View {
        ThreadCell(thread: dev.thread, user: dev.user) { _ in
            
        } onDelete: {
            
        }
    }
}
