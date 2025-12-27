//
//  LoginView.swift
//  CodeQuiz
//
//  Created by Samrudh S on 12/25/25.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject private var authManager: AuthManager
    @State private var email = ""
    @State private var password = ""
    @State private var isSignUp = false
    
    var body: some View {
        VStack(spacing: 10){
            Group{
                TextField("email", text: $email)
                    .textInputAutocapitalization(.never)
                    .keyboardType(.emailAddress)
                    .autocorrectionDisabled()
                SecureField("password", text: $password)
            }
            .padding()
            .frame(width: 300, height: 50)
            .background(.gray.opacity(0.3), in: RoundedRectangle(cornerRadius: 10))
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 2)
            }
            
            if let error = authManager.authError{
                Text(error)
                    .foregroundStyle(.red)
                    .font(.footnote)
            }
            
            Button {
                Task{
                    if isSignUp{
                        await authManager.signUp(email: email, password: password)
                    }else{
                        await authManager.signIn(email: email, password: password)
                    }
                }
            } label: {
                if authManager.isLoading{
                    ProgressView()
                } else{
                    Text(isSignUp ? "Register" : "Login")
                        .font(.custom("Exo2-Black", size: 40))
                        .foregroundStyle(.green)
                        .shadow(color: .black, radius: 1, x: 4, y: 4)
                }
            }
            .disabled(email.isEmpty || password.isEmpty || authManager.isLoading)
            .padding(.top, 35)
            
            Button {
                isSignUp.toggle()
                email = ""
                password = ""
            } label: {
                Text(isSignUp ? "Already have an account? Login here >>" : "New User? Register here >>")
                    .font(.system(size: 15))
                    .bold()
                    .shadow(color: .black, radius: 1)
            }
            .padding(.top, 35)

            Button {
                Task{
                    await authManager.signInAnonymously()
                }
            } label: {
                Text("or, Continue as a Guest")
                    .font(.system(size: 17, weight: .bold))
                    .underline()
                    .foregroundStyle(.black.opacity(0.6))
            }
            .padding(.top, 20)
        }
    }
}

#Preview {
    @StateObject var authManager = AuthManager()
    LoginView()
        .environmentObject(authManager)
}
