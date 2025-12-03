//
//  CodeQuizApp.swift
//  CodeQuiz
//
//  Created by Samrudh S on 11/6/25.
//

import SwiftUI
import SwiftData

@main
struct CodeQuizApp: App {
    @StateObject private var networkMonitor = NetworkMonitor.shared
    
    var body: some Scene {
        WindowGroup {
            TabBarView()
                .font(.custom("Exo2-Medium", size: 20))
                .environmentObject(networkMonitor)
            // Caching the generated questions through ai
            // Handle the offline and online mode
            // Add classic touch sounds for almost everything
            // Handle Frame size (width/height)
            // Suggestions or Preferences using AI as per users likes
            // Handle Dynamic Type
            // Create color constants
            // Future implementation: Generate unique set of questions daily
            // Test cases
        }
        // .modelContainer(sharedModelContainer)
    }
}
