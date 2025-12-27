//
//  TabBarView.swift
//  CodeQuiz
//
//  Created by Samrudh S on 11/9/25.
//

import SwiftUI

struct TabBarView: View {
    @EnvironmentObject var authManager: AuthManager
    
    var body: some View {
        Group{
            if authManager.user == nil{
                LoginView()
            } else{
                TabView {
                    Tab("Quiz", systemImage: "rectangle.and.pencil.and.ellipsis") {
                        HomePageGroup()
                    }
                    Tab("Favorites", systemImage: "heart") {
                        FavoritesPageView()
                    }
                    Tab("Settings", systemImage: "gear") {
                        SettingsView()
                    }
                }
            }
        }
    }
}

#Preview {
    var networkMonitor = NetworkMonitor.shared
    @StateObject var authManager = AuthManager()

    TabBarView()
        .font(.custom("Exo2-Medium", size: 20))
        .environmentObject(networkMonitor)
        .environmentObject(authManager)
}
