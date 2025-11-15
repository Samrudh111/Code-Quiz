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
    @State var testProperties = TestProperties()
    
    var body: some Scene {
        WindowGroup {
            TabBarView()
                .environment(testProperties)
            // Difficulty level nomenclature
            // Add classic touch sounds for almost everything
            // Handle Frame size (width/height)
            // Handle Dynamic Type
            // Create color constants
            // Basic logic: Generates questions whenever the quiz begins
            // Future implementation: Generate unique set of questions daily
            
        }
        // .modelContainer(sharedModelContainer)
    }
}
