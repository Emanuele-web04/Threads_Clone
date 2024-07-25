//
//  ExploreView.swift
//  Threads
//
//  Created by Emanuele Di Pietro on 24/07/24.
//

import SwiftUI

struct ExploreView: View {
    
    @State private var searchText = ""
    @StateObject var vm = ExploreViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
                    ForEach(vm.users, id: \.id) { user in
                        NavigationLink(value: user) {
                            VStack {
                                UserCell(user: user)
                                Divider()
                            }
                            .padding(.vertical, 4)
                        }
                    }
                }
            }
            .navigationDestination(for: User.self, destination: { user in
                ProfileView(user: user)
            })
            .navigationTitle("Search")
            .searchable(text: $searchText, prompt: "Search")
        }
    }
}

#Preview {
    ExploreView()
}
