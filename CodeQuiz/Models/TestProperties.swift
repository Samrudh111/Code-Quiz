//
//  TestProperties.swift
//  CodeQuiz
//
//  Created by Samrudh S on 11/9/25.
//

import Foundation

@Observable
class TestProperties{
    var testRunning = false
    var questionNumber = 1
    var testObject: testObject?
    var questionSet: [QA] = [
        QA(question: "What is the capital of France?", answers: ["Paris", "Lyon", "Marseille", "Nice"]),
        QA(question: "SwiftUI state that survives view reload?", answers: ["@State", "@StateObject", "@Binding", "@ObservedObject"]),
        QA(question: "HTTP success code?", answers: ["200", "404", "500", "301"]),
        QA(question: "What is the capital of France?", answers: ["Paris", "Lyon", "Marseille", "Nice"]),
        QA(question: "SwiftUI state that survives view reload?", answers: ["@State", "@StateObject", "@Binding", "@ObservedObject"]),
        QA(question: "HTTP success code?", answers: ["200", "404", "500", "301"])]
}
