//
//  SettingsView.swift
//  CodeQuiz
//
//  Created by Samrudh S on 11/9/25.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        VStack(spacing: 10){
            Circle()
                .frame(width: 100)
            Text("Full Name")
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 300, height: 5)
                .foregroundStyle(.secondary)
                .padding()
            
            List {
                settingsButton(for: "Account Settings")
                settingsButton(for: "App Settings")
            }
            .foregroundStyle(.black)
            .frame(height: 200)
        }
    }
    
    @ViewBuilder
    private func settingsButton(for title: String) -> some View{
        Button {
            // Open respective page
        } label: {
            Text(title)
                .padding(.leading, 20)
        }
    }
}

#Preview {
    SettingsView()
}
