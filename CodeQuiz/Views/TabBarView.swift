//
//  TabBarView.swift
//  CodeQuiz
//
//  Created by Samrudh S on 11/9/25.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
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

#Preview {
    var networkMonitor = NetworkMonitor.shared
    TabBarView()
        .font(.custom("Exo2-Medium", size: 20))
        .environmentObject(networkMonitor)
}
