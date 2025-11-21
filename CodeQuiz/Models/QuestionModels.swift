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
    let swift: SwiftTopics?
    let java: JavaTopics?
    let sql: SQLTopics?
    let python: PythonTopics?
    let rust: RustTopics?
    let cpp: CppTopics?
    
    enum CodingKeys: String, CodingKey {
        case swift = "Swift"
        case java = "Java"
        case sql  = "SQL"
        case python = "Python"
        case rust  = "Rust"
        case cpp   = "C++"
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

struct JavaTopics: Decodable {
    let springBoot: DifficultySet
    let androidSDK: DifficultySet
    let jetpack: DifficultySet
    let kotlin: DifficultySet
    let kubernetes: DifficultySet
    let hiberate: DifficultySet
    let jUnit: DifficultySet
    let mockito: DifficultySet
    
    enum CodingKeys: String, CodingKey {
        case springBoot  = "Spring Boot"
        case androidSDK = "Android SDK"
        case jetpack    = "Jetpack"
        case kotlin      = "Kotlin"
        case kubernetes = "Kubernetes"
        case hiberate    = "Hibernate"
        case jUnit      = "JUnit"
        case mockito     = "Mockito"
    }
}
struct SQLTopics: Decodable {
    let mySql: DifficultySet
    let postgreSql: DifficultySet
    let oracle: DifficultySet
    let sqlLite: DifficultySet
    let snowflake: DifficultySet
    let indexes: DifficultySet
    let joins: DifficultySet
    
    enum CodingKeys: String, CodingKey{
        case mySql = "MySQL"
        case postgreSql = "PostgreSQL"
        case oracle = "Oracle"
        case sqlLite = "SQLite"
        case snowflake = "Snowflake"
        case indexes = "Indexes"
        case joins = "Joins"
    }
}

struct PythonTopics: Decodable {
    let pandas: DifficultySet
    let numPy: DifficultySet
    let sciPy: DifficultySet
    let tensorflow: DifficultySet
    let pytorch: DifficultySet
    let scikitLearn: DifficultySet
    let flask: DifficultySet
    
    enum CodingKeys: String, CodingKey{
        case pandas = "Pandas"
        case numPy  = "NumPy"
        case tensorflow = "TensorFlow"
        case pytorch  = "PyTorch"
        case scikitLearn = "Scikit-Learn"
        case sciPy = "SciPy"
        case flask = "Flask"
    }
}

struct RustTopics: Decodable {
    let noStd: DifficultySet
    let rTic: DifficultySet
    let ring: DifficultySet
    let awsLambda: DifficultySet
    
    enum CodingKeys: String, CodingKey{
        case noStd = "No-Std"
        case rTic = "RTIC"
        case ring = "Ring"
        case awsLambda = "AWS Lambda Runtime for Rust"
    }
}

struct CppTopics: Decodable {
    let windowsApi: DifficultySet
    let posix: DifficultySet
    let tensorRT: DifficultySet
    let openCV: DifficultySet
    let arduinoSdk: DifficultySet
    
    enum CodingKeys: String, CodingKey{
        case windowsApi = "Windows API"
        case posix = "POSIX"
        case tensorRT = "TensorRT"
        case openCV = "OpenCV"
        case arduinoSdk = "Arduino SDK"
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

struct TestObject: Codable {
     var levelWeight: Int?
     var languageSelected: String?
     var category: String?
}
