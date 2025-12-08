//
//  Constants.swift
//  CodeQuiz
//
//  Created by Samrudh S on 11/6/25.
//

import Foundation
import SwiftUI

enum DifficultyLevel: String, CaseIterable{
    case Easy
    case Medium
    case Hard
    
    var weightage: Int{
        switch self{
        case .Easy: return 1
        case .Medium: return 2
        case .Hard: return 3
        }
    }
}

enum Language: String, CaseIterable{
    //Offline ready
    case Swift
    case Python
    case SQL
    case Java
    case Cpp = "C++"
    case Rust
    
    //Only Online
    case JavaScript
    case CSharp
    case Go
    case Kotlin
    case TypeScript
    case PHP
    case Ruby
    case R
    case Dart
    case Scala
    case MATLAB
    
    //    private var foreground: Color{
    //        switch self{
    //        case .Swift:
    //        case .Python:
    //        case .SQL:
    //        case .Java:
    //        case .Cpp:
    //        case .Rust:
    //        }
    //    }
    
    var logo: String{
        switch self{
        case .Swift: return "swiftLogo"
        case .Python: return "pythonLogo"
        case .SQL: return "sqlLogo"
        case .Java: return "javaLogo"
        case .Cpp: return "c++Logo"
        case .Rust: return "rustLogo"
        default: return ""
        }
    }
    
    var backgroundColor: Color{
        switch self{
        case .Swift: return Color(red: 222/255, green: 93/255, blue: 67/255)
        case .Python: return Color(red: 249/255, green: 218/255, blue: 99/255)
        case .SQL: return Color(red: 79/255, green: 146/255, blue: 207/255)
        case .Java: return Color(red: 227/255, green: 52/255, blue: 39/255)
        case .Cpp: return Color(red: 58/255, green: 70/255, blue: 164/255)
        case .Rust: return Color(red: 89/255, green: 49/255, blue: 18/255)
        default: return Color.white
        }
    }
    
    var categories: [String]{
        switch self{
            // ------------------------------------------------------
            // MARK: - Swift (Expanded)
            // ------------------------------------------------------
        case .Swift: return ["Swift UI",
                             "UIKit",
                             "AppKit",
                             "Storyboard",
                             "Async/Await",
                             "URLSession",
                             "Combine",
                             "Actors",
                             "Core Data",
                             "SwiftData",
                             "Core Animation",
                             "Core ML",
                             "Vision",
                             "ARKit",
                             "MapKit",
                             "SpriteKit",
                             "Metal",
                             "Networking",
                             "Property Wrappers",
                             "Protocols & Generics",
                             "Swift Macros",
                             "Concurrency",
                             "Package Manager (SPM)"]
            
            // ------------------------------------------------------
            // MARK: - Python (Expanded)
            // ------------------------------------------------------
        case .Python:
            return [
                "Pandas",
                "NumPy",
                "SciPy",
                "TensorFlow",
                "PyTorch",
                "Scikit-Learn",
                "XGBoost",
                "LightGBM",
                "FastAPI",
                "Flask",
                "Django",
                "OpenCV",
                "NLTK",
                "SpaCy",
                "Matplotlib",
                "Seaborn",
                "Plotly",
                "PySpark",
                "Airflow",
                "Asyncio",
                "Numba",
                "PyTest",
                "Jupyter",
                "Data Engineering",
                "Machine Learning",
                "Deep Learning"
            ]
            
            // ------------------------------------------------------
            // MARK: - SQL
            // ------------------------------------------------------
        case .SQL:
            return [
                "MySQL",
                "PostgreSQL",
                "SQLite",
                "Oracle",
                "Snowflake",
                "Joins",
                "Indexes",
                "Query Optimization",
                "Stored Procedures"
            ]
            
            // ------------------------------------------------------
            // MARK: - Java (Expanded)
            // ------------------------------------------------------
        case .Java:
            return [
                "Kotlin",
                "Spring Boot",
                "Spring MVC",
                "Spring Security",
                "Spring Cloud",
                "Hibernate",
                "JPA",
                "Maven",
                "Gradle",
                "JUnit",
                "Mockito",
                "Android SDK",
                "Jetpack",
                "Concurrency",
                "JDBC",
                "Microservices",
                "Docker",
                "Kafka",
                "Kubernetes",
                "JavaFX",
                "Servlets",
                "JMS",
                "REST APIs"
            ]
            
            // ------------------------------------------------------
            // MARK: - C++
            // ------------------------------------------------------
        case .Cpp:
            return [
                "STL",
                "Object-Oriented Programming",
                "Memory Management",
                "Smart Pointers",
                "Templates",
                "Multithreading",
                "POSIX",
                "Windows API",
                "Qt",
                "OpenCV",
                "TensorRT",
                "Arduino SDK"
            ]
            
            // ------------------------------------------------------
            // MARK: - Rust
            // ------------------------------------------------------
        case .Rust: return ["No-Std",
                            "AWS Lambda Runtime for Rust",
                            "Ownership & Borrowing",
                            "Lifetimes",
                            "Cargo",
                            "Tokio",
                            "RTIC",
                            "Ring",
                            "Actix Web",
                            "Rocket",
                            "WASM",
                            "Error Handling"
        ]
            
            // ------------------------------------------------------
            // MARK: - JavaScript
            // ------------------------------------------------------
        case .JavaScript:
            return [
                "React",
                "Node.js",
                "Express.js",
                "Next.js",
                "Vue.js",
                "Svelte",
                "DOM Manipulation",
                "Async/Await",
                "Promises",
                "Type Coercion",
                "Web APIs",
                "Event Loop",
                "D3.js",
                "Jest",
                "Cypress"
            ]
            
            // ------------------------------------------------------
            // MARK: - C#
            // ------------------------------------------------------
        case .CSharp:
            return [
                "ASP.NET Core",
                "Unity",
                "Xamarin",
                "WPF",
                "LINQ",
                "Entity Framework",
                "Blazor",
                "WinForms",
                "Azure Functions",
                "Microservices",
                "C# Generics",
                "Task Parallel Library"
            ]
            
            
            // ------------------------------------------------------
            // MARK: - Go
            // ------------------------------------------------------
        case .Go:
            return [
                "Goroutines",
                "Channels",
                "net/http",
                "Gin Framework",
                "Go Modules",
                "Microservices",
                "gRPC",
                "Concurrency",
                "Testing",
                "Dependency Injection"
            ]
            
            // ------------------------------------------------------
            // MARK: - Kotlin
            // ------------------------------------------------------
        case .Kotlin:
            return [
                "Kotlin Coroutines",
                "Jetpack Compose",
                "Android SDK",
                "Ktor",
                "Multiplatform",
                "DSLs",
                "Koin",
                "Room Database"
            ]
            
            // ------------------------------------------------------
            // MARK: - TypeScript
            // ------------------------------------------------------
        case .TypeScript:
            return [
                "Type System",
                "Generics",
                "React",
                "Next.js",
                "Express",
                "NestJS",
                "RxJS",
                "Angular"
            ]
            
            // ------------------------------------------------------
            // MARK: - PHP
            // ------------------------------------------------------
        case .PHP:
            return [
                "Laravel",
                "Symfony",
                "WordPress",
                "Composer",
                "Blade Templates",
                "REST APIs"
            ]
            
            // ------------------------------------------------------
            // MARK: - Ruby
            // ------------------------------------------------------
        case .Ruby:
            return [
                "Ruby on Rails",
                "ActiveRecord",
                "Sinatra",
                "RSpec",
                "Metaprogramming"
            ]
            
            // ------------------------------------------------------
            // MARK: - R
            // ------------------------------------------------------
        case .R:
            return [
                "ggplot2",
                "dplyr",
                "tidyr",
                "Shiny",
                "Caret",
                "RandomForest",
                "Time-Series Analysis"
            ]
            
            // ------------------------------------------------------
            // MARK: - Dart
            // ------------------------------------------------------
        case .Dart:
            return [
                "Flutter",
                "State Management",
                "Asynchronous Programming",
                "HTTP Networking",
                "Bloc",
                "Provider",
                "Riverpod"
            ]
            
            // ------------------------------------------------------
            // MARK: - Scala
            // ------------------------------------------------------
        case .Scala:
            return [
                "Akka",
                "Spark",
                "Functional Programming",
                "Play Framework",
                "Cats"
            ]
            
            // ------------------------------------------------------
            // MARK: - MATLAB
            // ------------------------------------------------------
        case .MATLAB:
            return [
                "Signal Processing",
                "Image Processing",
                "Simulink",
                "Statistics Toolbox",
                "Machine Learning"
            ]
        }
    }
}
