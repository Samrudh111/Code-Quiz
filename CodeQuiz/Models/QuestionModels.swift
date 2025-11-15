//
//  QuestionModels.swift
//  CodeQuiz
//
//  Created by Samrudh S on 11/13/25.
//

import Foundation

struct testObject{
    let levelWeight: Int
    let language: String
    let category: String?
}

struct QA: Identifiable, Equatable, Decodable {
    let id = UUID()
    let question: String
    let answers: [String]
}

struct langSet: Decodable{
    let Swift: Category
}

struct Category: Decodable{
    let categoryName: [Difficulty]? // check name
    let UIKit: [Difficulty]?
    let AppKit: [Difficulty]?
    let Storyboard: [Difficulty]?
    let `Async/Await`: [Difficulty]? // check name
    let URLSession: [Difficulty]?
}

struct Difficulty: Decodable{
    let Easy: [QA]
    let Medium: [QA]
    let Hard: [QA]
}
