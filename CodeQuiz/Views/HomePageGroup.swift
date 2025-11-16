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
    
    var body: some View {
        if isQuizActive ?? false{
            QAPageView()
        } else {
            HomepageView()
        }
    }
}

#Preview {
    HomePageGroup()
}
