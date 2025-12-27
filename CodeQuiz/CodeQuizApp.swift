//
//  CodeQuizApp.swift
//  CodeQuiz
//
//  Created by Samrudh S on 11/6/25.
//

import SwiftUI
import SwiftData
import CoreData
import FirebaseCore

@main
struct CodeQuizApp: App {
    @StateObject private var networkMonitor = NetworkMonitor.shared
    @StateObject private var dataController = DataController()
    @StateObject private var authManager = AuthManager()
    
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            TabBarView()
                .font(.custom("Exo2-Medium", size: 20))
                .environmentObject(networkMonitor)
                .environmentObject(authManager)
                .environment(\.managedObjectContext, dataController.container.viewContext)
            // Caching the generated questions through ai
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
