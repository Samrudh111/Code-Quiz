//
//  QuizViewModel.swift
//  CodeQuiz
//
//  Created by Samrudh S on 11/29/25.
//

import Foundation
import SwiftUI
import Combine

@MainActor
final class QuizViewModel: ObservableObject {
    @Published var questions: [QAai] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    func loadAIQuestions(language: String, topic: String, difficulty: Difficulty, count: Int = 10) {
        isLoading = true
        errorMessage = nil

        Task {
            do {
                let qs = try await QuestionAPI.shared.generateQuestions(
                    language: language,
                    topic: topic,
                    difficulty: difficulty,
                    count: count
                )
                self.questions = qs
            } catch {
                self.errorMessage = "Failed to load questions. Please try again."
                print("❌ API error:", error)
            }
            self.isLoading = false
        }
    }
}
