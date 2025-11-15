//
//  HomePageGroup.swift
//  CodeQuiz
//
//  Created by Samrudh S on 11/9/25.
//

import SwiftUI
import Foundation

struct HomePageGroup: View {
    @Environment(TestProperties.self) var testProperties
    
    var body: some View {
        if testProperties.testRunning{
            QAPageView()
        } else {
            HomepageView()
        }
    }
}


#Preview {
    HomePageGroup()
}
