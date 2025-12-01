//
//  HomePageGroup.swift
//  CodeQuiz
//
//  Created by Samrudh S on 11/9/25.
//

import SwiftUI
import Foundation

struct HomePageGroup: View {
    @AppStorage("QuizActive") private var isQuizActive: Bool?
    @StateObject var quizVM = QuizViewModel()
    
    var body: some View {
        if isQuizActive ?? false{
            QAPageViewAIMode()
                .environmentObject(quizVM)
//            QAPageView()
//                .environmentObject(quizVM)
        } else {
            HomepageView()
                .environmentObject(quizVM)
        }
    }
}

#Preview {
    HomePageGroup()
}
