//
//  SettingsView.swift
//  CodeQuiz
//
//  Created by Samrudh S on 11/9/25.
//

import SwiftUI
import FirebaseAuth

struct SettingsView: View {
    @EnvironmentObject private var authManager: AuthManager
    @State private var noCurrentUser = true
    
    var body: some View {
        VStack(spacing: 10){
            Circle()
                .frame(width: 100)
            Text(authManager.user?.email ?? "Mr. Guest")
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 300, height: 5)
                .foregroundStyle(.secondary)
                .padding()
            
            List {
                Group{
                    settingsButton(for: "Account Settings")
                    settingsButton(for: "App Settings")
                    if !noCurrentUser{
                        logOutButton()
                    }
                }
                .padding(.leading, 20)
            }
            .foregroundStyle(.black)
            .frame(height: 200)
        }
        .onAppear{
            noCurrentUser = (authManager.user == nil)
        }
    }
    @ViewBuilder
    private func settingsButton(for title: String) -> some View{
        Button {
            // Open respective page
        } label: {
            Text(title)
        }
    }
    
    @ViewBuilder
    private func logOutButton() -> some View{
        Button {
            authManager.signOut()
        } label: {
            Text("Log out") // For Guest login ?
                .foregroundStyle(.red)
        }
    }
}

#Preview {
    @StateObject var authManager = AuthManager()
    SettingsView()
        .environmentObject(authManager)
}
