//
//  RegistrationView.swift
//  Threads
//
//  Created by Emanuele Di Pietro on 24/07/24.
//

import SwiftUI

struct RegistrationView: View {
    
    
    
    @Environment(\.dismiss) var dismiss
    
    @StateObject var vm = RegistrationViewModel()
    
    var body: some View {
        VStack(spacing: 40) {
            Spacer()
            Image("x-twitter").resizable().scaledToFill().frame(width: 50, height: 50)
            VStack(spacing: 20) {
                TextField("Enter your email", text: $vm.email)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .modifier(ThreadsTextFieldModifier())
                SecureField("Enter your password", text: $vm.password)
                    .modifier(ThreadsTextFieldModifier())
                TextField("Enter your full name", text: $vm.fullname)
                    .modifier(ThreadsTextFieldModifier())
                TextField("Enter your username", text: $vm.username)
                    .modifier(ThreadsTextFieldModifier())
                
                Spacer()
                Button {
                    Task {
                        try await vm.createUser()
                    }
                } label: {
                    Text("Sign up")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.accent).cornerRadius(50)
                }
                
            }
            Spacer()
            
            Divider()
            
            Button {
                dismiss()
            } label: {
                HStack {
                    Text("Already have an account?")
                    Text("Sign In")
                }
                .foregroundStyle(.white)
                .font(.footnote)
                    .fontWeight(.semibold)
            }
        }.padding()
    }
}

#Preview {
    RegistrationView()
}
