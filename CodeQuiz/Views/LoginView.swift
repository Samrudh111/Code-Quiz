//
//  LoginView.swift
//  CodeQuiz
//
//  Created by Samrudh S on 12/25/25.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        VStack(spacing: 10){
            TextField("email", text: $email)
                .padding()
                .frame(width: 300, height: 50)
                .background(.gray.opacity(0.3), in: RoundedRectangle(cornerRadius: 10))
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 2)
                }
            SecureField("password", text: $password)
                .padding()
                .frame(width: 300, height: 50)
                .background(.gray.opacity(0.3), in: RoundedRectangle(cornerRadius: 10))
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 2)
                }
            
            Button {
                //showYellow.toggle()
                // Login function
            } label: {
                Text("Login")
                    .font(.custom("Exo2-Black", size: 45))
                    .foregroundStyle(.green)
                    .shadow(color: .black, radius: 1, x: 4, y: 4)
            }
            .padding(.top, 35)
            
            Button {
                // Continue as Guest func
            } label: {
                Text("or, Continue as a Guest")
                    .underline()
                    .foregroundStyle(.black.opacity(0.6))
            }
            .padding(.top, 40)
        }
    }
    
    private func login() {
        
    }
}

#Preview {
    LoginView()
}
