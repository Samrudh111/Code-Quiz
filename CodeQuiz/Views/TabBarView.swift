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
            Tab("Settings", systemImage: "gear") {
                SettingsView()
            }
        }
    }
}


#Preview {
    TabBarView()
}
