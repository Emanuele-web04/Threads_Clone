//
//  UserContentListView.swift
//  Threads
//
//  Created by Emanuele Di Pietro on 25/07/24.
//

import SwiftUI

struct UserContentListView: View {
    
    @Namespace var animation
    @State private var selectedFilter: ProfileThreadFilter = .threads
    private var filterBarWidth: CGFloat {
        let count = CGFloat(ProfileThreadFilter.allCases.count)
        return UIScreen.main.bounds.width / count - 20
    }
    
    @StateObject var vm: UserContentListViewModel
    
    init(user: User) {
        self._vm = StateObject(wrappedValue: UserContentListViewModel(user: user))
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
                ForEach(vm.threads) { thread in
                  ThreadCell(thread: thread) { updatedPost in
                      if let index = vm.threads.firstIndex(where: { thread in
                          thread.threadID == updatedPost.threadID
                      }) {
                          vm.threads[index].likedIDs = updatedPost.likedIDs
                      }
                  } onDelete: {
                      withAnimation() {
                          vm.threads.removeAll { thread.threadID == $0.threadID }
                      }
                  }
                }
            }
        }.padding(.vertical, 8)
    }
}

//#Preview {
//    UserContentListView()
//}
