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
    case Swift
    case Python
    case SQL
    case Java
    case Cpp = "C++"
    case Rust
    
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
        }
    }
    
    var categories: [String]{
        switch self{
        case .Swift: return ["Swift UI", "UIKit", "AppKit", "Storyboard", "Async/Await", "URLSession"]
        case .Python: return ["Pandas", "NumPy", "SciPy", "TensorFlow", "PyTorch", "Scikit-Learn", "Flask"]
        case .SQL: return ["MySQL", "PostgreSQL", "Oracle", "SQLite", "Snowflake", "Indexes", "Joins"]
        case .Java: return ["Spring Boot", "Android SDK", "Jetpack", "Kotlin", "Kubernetes", "Hibernate", "JUnit", "Mockito"]
        case .Cpp: return ["Windows API", "POSIX", "TensorRT", "OpenCV", "Arduino SDK"]
        case .Rust: return ["No-Std", "RTIC", "Ring", "AWS Lambda Runtime for Rust"]
        }
    }
}
