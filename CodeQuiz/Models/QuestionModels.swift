//
//  QuestionModels.swift
//  CodeQuiz
//
//  Created by Samrudh S on 11/13/25.
//

import Foundation

struct QA: Codable {
    //let id = UUID()
    let question: String
    let options: [String]
}

struct Root: Decodable {
    let data: LanguageData
}

struct LanguageData: Decodable {
    let swift: SwiftTopics

    enum CodingKeys: String, CodingKey {
        case swift = "Swift"
    }
}

struct SwiftTopics: Decodable {
    let swiftUI: DifficultySet
    let uiKit: DifficultySet
    let appKit: DifficultySet
    let storyboard: DifficultySet
    let asyncAwait: DifficultySet
    let urlSession: DifficultySet

    enum CodingKeys: String, CodingKey {
        case swiftUI    = "Swift UI"
        case uiKit      = "UIKit"
        case appKit     = "AppKit"
        case storyboard = "Storyboard"
        case asyncAwait = "Async/Await"
        case urlSession = "URLSession"
    }
}

struct DifficultySet: Decodable {
    let easy: [QA]
    let medium: [QA]
    let hard: [QA]

    enum CodingKeys: String, CodingKey {
        case easy   = "Easy"
        case medium = "Medium"
        case hard   = "Hard"
    }
}
