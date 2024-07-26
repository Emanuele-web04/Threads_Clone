//
//  ThreadsTabView.swift
//  Threads
//
//  Created by Emanuele Di Pietro on 24/07/24.
//

import SwiftUI

struct ThreadsTabView: View {
    
    @State var selection: Int = 0
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        TabView(selection: $selection) {
            FeedView()
                .onTapGesture {
                    dismiss()
                }
                .tabItem {
                    Image(systemName: selection == 0 ? "house.fill" : "house")
                        .environment(\.symbolVariants, selection == 0 ? .fill : .none)
                }
                .tag(0)
            ExploreView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                }.tag(1)
            CommunityView()
                .tabItem {
                    Image(systemName: selection == 2 ? "person.2.fill" : "person.2")
                        .environment(\.symbolVariants, selection == 2 ? .fill : .none)
                }.tag(2)
            ActivityView()
                .tabItem {
                    Image(systemName: selection == 3 ? "bell.fill" : "bell")
                        .environment(\.symbolVariants, selection == 3 ? .fill : .none)
                }.tag(3)
            MessageView()
                .tabItem {
                    Image(systemName: selection == 4 ? "tray.fill" : "tray")
                        .environment(\.symbolVariants, selection == 4 ? .fill : .none)
                }.tag(4)
        }
        .tint(.white)
            .background(.thinMaterial)
    }
}

#Preview {
    ThreadsTabView()
}
