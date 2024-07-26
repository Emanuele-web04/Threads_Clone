//
//  FeedView.swift
//  Threads
//
//  Created by Emanuele Di Pietro on 24/07/24.square.and.arrow.up
//

import SwiftUI

struct FeedView: View {
    
    @State private var offset: CGFloat = 0
    @State private var createThread = false
    
    @StateObject var vm = FeedViewModel()
    
    private var user: User? {
        return UserService.shared.currentUser
    }
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                GeometryReader { geometry in
                                    Color.clear
                                        .preference(key: OffsetKey.self, value: geometry.frame(in: .global).minY)
                                }
                                .frame(height: 0)
                LazyVStack {
                    ForEach(vm.threads) { thread in
                        NavigationLink {
                            if let user = thread.user {
                                ProfileView(user: user)
                            }
                        } label: {
                            ThreadCell(thread: thread)
                        }
                    }
                }
            }
            .onPreferenceChange(OffsetKey.self) { value in
                self.offset = value
            }
            .refreshable {
                Task { try await vm.fetchThreads() }
            }
            .toolbarBackground(.clear)
            .safeAreaInset(edge: .top) {
                HStack {
                    NavigationLink {
                        CurrentUserProfileView()
                    } label: {
                        CircularProfileView(user: user, size: .s)
                    }.buttonStyle(.plain)
                    
                    Spacer(minLength: 0)
                    Button {
                        Task { try await vm.fetchThreads() }
                    } label: {
                        Image("x-twitter").resizable().scaledToFill().frame(width: 20, height: 20)
                            .padding(.trailing, 40)
                    }
                    Spacer()
                }.padding()                
                    .background(.black)
                    .overlay(alignment: .bottom) {
                        Rectangle().frame(width: 400, height: 0.5).foregroundStyle(.gray.opacity(0.3))
                    }
            }
            .overlay(alignment: .bottomTrailing) {

                Button {
                    createThread = true
                } label: {
                    Image(systemName: "plus")
                        .foregroundStyle(.white)
                        .fontWeight(.medium)
                        .imageScale(.large)
                        .background {
                            Circle().fill(.xBlue).frame(width: 55, height: 55)
                        }
                        .padding()
                }.padding()
                    .fullScreenCover(isPresented: $createThread) {
                        CreateThreadView()
                            .onDisappear(perform: {
                                Task { try await vm.fetchThreads() }
                            })
                    }
            }
        }
    }
}

#Preview {
    FeedView()
}

struct OffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
