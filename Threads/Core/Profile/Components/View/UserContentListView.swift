//
//  UserContentListView.swift
//  Threads
//
//  Created by Emanuele Di Pietro on 25/07/24.
//

import SwiftUI
import Firebase

struct UserContentListView: View {
    
    @Namespace var animation
    @State private var selectedFilter: ProfileThreadFilter = .threads
    private var filterBarWidth: CGFloat {
        let count = CGFloat(ProfileThreadFilter.allCases.count)
        return UIScreen.main.bounds.width / count - 20
    }
    
    @StateObject var vm: UserContentListViewModel
    let user: User
    
    init(user: User) {
        self._vm = StateObject(wrappedValue: UserContentListViewModel(user: user))
        self.user = user
    }
    
    var body: some View {
        VStack {
            HStack {
                ForEach(ProfileThreadFilter.allCases, id: \.id) { filter in
                    VStack {
                        Text(filter.title)
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundStyle(selectedFilter == filter ? .white : .gray)
                        
                        
                        if selectedFilter == filter {
                            Rectangle()
                                .foregroundStyle(.xBlue)
                                .frame(width: filterBarWidth, height: 2).matchedGeometryEffect(id: "item", in: animation)
                        } else {
                            Rectangle()
                                .foregroundStyle(.clear)
                                .frame(width: filterBarWidth, height: 2)
                        }
                        
                    }
                    .onTapGesture {
                        withAnimation(.spring()) {
                            selectedFilter = filter
                        }
                    }
                }
            }
            
            LazyVStack {
                ForEach(selectedFilter == .threads ? vm.threads : selectedFilter == .likes ? vm.currentUserLikedThreads : vm.currentUserBookmarkedThreads) { thread in
                    ThreadCell(thread: thread, user: user) { updatedPost in
                        updateLikeThread(withUpdatedPost: updatedPost)
                    } onDelete: {
                        withAnimation() {
                            switch selectedFilter {
                            case .threads:
                                vm.threads.removeAll { thread.threadID == $0.threadID }
                            case .likes:
                                vm.currentUserLikedThreads.removeAll { thread.threadID == $0.threadID }
                            case .bookmarks:
                                vm.currentUserBookmarkedThreads.removeAll { thread.threadID == $0.threadID }
                            }
                        }
                    }
                }
            }
        }.padding(.vertical, 8)
    }
    
    private func updateLikeThread(withUpdatedPost updatedPost: Thread) {
        switch selectedFilter {
        case .threads:
            if let index = vm.threads.firstIndex(where: { thread in
                thread.threadID == updatedPost.threadID
            }) {
                vm.threads[index].likedIDs = updatedPost.likedIDs
                vm.threads[index].bookmarkIDs = updatedPost.bookmarkIDs
            }
        case .likes:
            if let index = vm.currentUserLikedThreads.firstIndex(where: { thread in
                thread.threadID == updatedPost.threadID
            }) {
                vm.currentUserLikedThreads[index].likedIDs = updatedPost.likedIDs
                // if the liked list no longer contains the user id then remove it
                if !updatedPost.likedIDs.contains(user.id) {
                    withAnimation(.spring()) {
                        vm.currentUserLikedThreads.remove(at: index)
                    }
                }
            }
        case .bookmarks:
            if let index = vm.currentUserBookmarkedThreads.firstIndex(where: { thread in
                thread.threadID == updatedPost.threadID
            }) {
                vm.currentUserBookmarkedThreads[index].bookmarkIDs = updatedPost.bookmarkIDs
                if !updatedPost.bookmarkIDs.contains(user.id) {
                    withAnimation(.spring()) {
                        vm.currentUserBookmarkedThreads.remove(at: index)
                    }
                }
            }
        }
    }
}

//#Preview {
//    UserContentListView()
//}
