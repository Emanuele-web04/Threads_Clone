//
//  ContentView.swift
//  Threads
//
//  Created by Emanuele Di Pietro on 24/07/24.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var vm = MainViewModel()
    
    var body: some View {
        Group {
            if vm.userSession != nil {
                ThreadsTabView()
            } else {
                LoginView()
            }
        }
    }
}

#Preview {
    MainView()
}
